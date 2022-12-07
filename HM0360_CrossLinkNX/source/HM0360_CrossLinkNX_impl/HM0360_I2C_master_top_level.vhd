library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HM0360_I2C_master_top_level is
port(
--Oscillator
CLK: in std_logic;					--CLK					: system clock
--Buttons
R_W_button_n: in std_logic;			--R_W_button_n			: Pin to switch in between read and operation mode. Everytime this signal goes high, the register operation is switched
start_button_n: in std_logic;		--start_button_n		: Pin to start a transaction (read or write operation)
--LEDs
RD_content1_LED_n: out std_logic;	--RD_content1_LED_n		: LED that display the Least-Significant bit of the register value. To correctly display the bit
RD_content2_LED_n: out std_logic;	
RD_content3_LED_n: out std_logic;
RD_content4_LED_n: out std_logic;
RD_content5_LED_n: out std_logic;
RD_content6_LED_n: out std_logic;
RD_content7_LED_n: out std_logic;
RD_content8_LED_n: out std_logic;
RW_LED_n: out std_logic;			--RW_LED_n				: LED to display weather a read or write operation is selected
--HM0360 Camera sensor pins
SDA: inout std_logic;				--SDA					: SDA (Serial Data)
SCL: out std_logic;					--SCL					: SCL (Serial Clock)
--
HM_MCLK: out std_logic;				--HM_MCLK				: Connected to MCLK pin 
HM_CLK_SEL: out std_logic;			--HM_CLK_SEL			: Connected to CLK_SEL pin
HM_RTC: out std_logic;				--HM_RTC				: Connected to RTC pin
HM_SHUTDOWN_N: out std_logic;		--HM_SHUTDOWN_N			: Connected to SHUTDOWN_N pin
HM_SLEEP_N: out std_logic;			--HM_SLEEP_N			: Connected to SLEEP_N pin
--Debug
debug_LED_n: out std_logic			--debug_LED_n			: LED for debugging signal in inners entities
);
end HM0360_I2C_master_top_level;

Architecture Behavioral of HM0360_I2C_master_top_level is

--Parameters
constant system_clock_F: natural := 27_000_000;
constant I2C_clock_F: natural := 500_000; 														-- SCL frequency must be in betweem 100_000 and 1_000_000 Hz
constant slave_ID: std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(16#24#, 7));
constant stable_time: integer := 10;
--Constants to debug design
constant addr_PMU_CFG3: std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(16#3024#,16));
constant addr_PMU_CFG4: std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(16#3025#,16));
constant addr_MODEL_ID_H: std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(16#0000#,16));
constant addr_MODEL_ID_L: std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(16#0001#,16));
constant addr_MODE_SELECT: std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(16#0100#,16));
constant data_write: std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#11#,8));
--Signals
signal data_read: std_logic_vector(7 downto 0) := (others => '0');
signal R_W: std_logic := '0';
signal finished: std_logic;
signal error: std_logic;
signal R_W_button_deb, start_button_deb: std_logic;
signal start_button		: std_logic;
signal R_W_button		: std_logic;
signal error_debug		: std_logic;
signal buffer_debug		: std_logic_vector(7 downto 0);
signal addr: std_logic_vector(15 downto 0);


component HM0360_serial_I2C_master is
generic(
	constant system_clock_F : natural;
	constant I2C_clock_F: natural;
	constant slave_ID: std_logic_vector(6 downto 0)
);
port(
	reset_n		: in std_logic;
	CLK		: in std_logic;
	SDA		: inout std_logic;
	SCL		: out std_logic;
	addr		: in std_logic_vector(15 downto 0);
	R_W		: in std_logic;
	data_write	: in std_logic_vector(7 downto 0);
	data_read	: out std_logic_vector(7 downto 0);
	start		: in std_logic;
	finished	: out std_logic;
	error_debug : out std_logic;
	buffer_debug: out std_logic_vector(7 downto 0)
);
end component;

component debounce is
  generic(
    clk_freq    : INTEGER;  --system clock frequency in Hz
    stable_time : INTEGER
	);         --time button must remain stable in ms
  port(
    clk     : in  STD_LOGIC;  --input clock
    reset_n : in  STD_LOGIC;  --asynchronous active low reset
    button  : in  STD_LOGIC;  --input signal to be debounced
    button_deb  : out STD_LOGIC); --debounced signal
end component;

begin
--HM0360 Setup Signal
HM_MCLK <= '0';	--To disable internal oscillator
HM_RTC <= '0'; 	--Must not be left floating
HM_CLK_SEL <= '0'; --Clock Selection Bit '0': Internal
HM_SHUTDOWN_N <= '1'; --HM Shutdown Active Low
HM_SLEEP_N <= '1'; --Sleep Mode bit Active Low
--Assignments to check Register Value
RD_content1_LED_n <= not(data_read(0));
RD_content2_LED_n <= not(data_read(1));
RD_content3_LED_n <= not(data_read(2));
RD_content4_LED_n <= not(data_read(3));
RD_content5_LED_n <= not(data_read(4));
RD_content6_LED_n <= not(data_read(5));
RD_content7_LED_n <= not(data_read(6));
RD_content8_LED_n <= not(data_read(7));
--Assignments to check Data Written into Register
--RD_content1_LED_n <= not(buffer_debug(0));
--RD_content2_LED_n <= not(buffer_debug(1));
--RD_content3_LED_n <= not(buffer_debug(2));
--RD_content4_LED_n <= not(buffer_debug(3));
--RD_content5_LED_n <= not(buffer_debug(4));
--RD_content6_LED_n <= not(buffer_debug(5));
--RD_content7_LED_n <= not(buffer_debug(6));
--RD_content8_LED_n <= not(buffer_debug(7));
RW_LED_n <= not(R_W);
debug_LED_n <= not(error_debug);
addr <= addr_PMU_CFG3;
R_W_button <= not(R_W_button_n);
start_button <= not(start_button_n);

HM0360_serial_I2C_master_comp: HM0360_serial_I2C_master
generic map(
system_clock_F => system_clock_F,
I2C_clock_F => I2C_clock_F,
slave_ID => slave_ID
)
port map(
reset_N => '1',
CLK	=> CLK,
SDA	=> SDA,
SCL	=> SCL,
addr => addr,
R_W	=> R_W,
data_write => data_write,
data_read => data_read,
start => start_button_deb,
finished => finished,
error_debug => error_debug,
buffer_debug => buffer_debug
);

debounce_R_W_button: debounce
generic map(
	clk_freq => system_clock_F,
	stable_time => stable_time
)
port map(
    clk => CLK,
    reset_n => '1',
    button => start_button,
    button_deb  => start_button_deb
);

debounce_start_button: debounce
generic map(
	clk_freq => system_clock_F,
	stable_time => stable_time
)
port map(
    clk => CLK,
    reset_n => '1',
    button => R_W_button,
    button_deb  => R_W_button_deb
	); --debounced signal


R_W_gen: process(all) is
begin
if rising_edge(R_W_button_deb) then 
	R_W <= not(R_W);
end if;
end process;

end Behavioral;