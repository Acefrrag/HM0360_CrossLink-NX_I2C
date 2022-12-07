library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity HM0360_Interface_top_level is
port(
	--
	CLK: in std_logic;					--CLK: System clock 27 Mhz Oscillator
	--
	SDA: inout std_logic;				--SDA: I2C Serial Data
	SCL: out std_logic;					--SCL: I2C SCL
	--
	command_button_n: in std_logic;		--init_config_button_n: button signal to send several commands. 1 click => configuration, 2 clicks => read configuration, 3 clicks => acquisition of image
	--MIPI Interfaces
	HM_CP: inout std_logic;						--HM_CP: Positive Clock MIPI Interface
	HM_CN: inout std_logic;						--HM_CN: Negative Clock MIPI Interface
	HM_DP: inout std_logic_vector(0 downto 0);	--HM_DP: Data Positive MIPI Interface
	HM_DN: inout std_logic_vector(0 downto 0);	--HM_DN: Data Negative MIPI Interface
	--
	HM_MCLK: out std_logic;						--HM_MCLK		: Master Clock Pin. Connected to GND to enable internal oscillator
	HM_CLK_SEL: out std_logic;					--HM_CLK_SEL	: Clock Select Pin
	HM_RTC: out std_logic;						--HM_RTC		: Real Time Clock Pin
	HM_SHUTDOWN_N: out std_logic;				--HM_SHUTDOWN_N	: Shutdown Pin
	HM_SLEEP_N: out std_logic;					--SLEEP_N		: Sleep Pin
	--debug
	debug_button_n: in std_logic;						--debug_button_n	  : button signal to debug the code
	data_out_debug_n: out std_logic_vector(7 downto 0);	
	flag_debug_1_n: out std_logic;
	flag_debug_2_n: out std_logic
);
end HM0360_Interface_top_level;

Architecture Behavioral of HM0360_Interface_top_level is

signal command_deb, debug_deb: std_logic;
constant PADDR_debug: std_logic_vector(3 downto 0):=std_logic_vector(to_unsigned(16#5#,4));
signal data_out_debug: std_logic_vector(7 downto 0):= (others => '0');
signal command_button, debug_button: std_logic;
--
constant choice_dout: std_logic := '1'; --'0' for data type selection '1' for pixel selection
signal mux_data_out_debug: std_logic_vector(7 downto 0);
signal dt_o_debug: std_logic_vector(5 downto 0);
signal flag_debug, flag_debug_hold: std_logic;
--
signal read_config: std_logic;
signal init_config: std_logic;
signal state_read_config_debug: std_logic;
signal flag_debug_hold_n: std_logic;
signal config_finished: std_logic;
--
signal CLK_PLL: std_logic;

component prescaler is
generic(
	constant input_frequency: natural; 		--input_frequency: input frequency in Hz
	constant output_frequency: natural		--output_frequenct: output frequency in Hz
);
port(
	CLK_IN: in std_logic;
	CLK_OUT: out std_logic;
	shifted_CLK_OUT: out std_logic
);
end component;

component debounce_2 is
  GENERIC(
    clk_freq    : INTEGER;  --system clock frequency in Hz
    stable_time : real);         --time button must remain stable in ms
  PORT(
    clk     : IN  STD_LOGIC;  		--input clock
    reset_n : IN  STD_LOGIC;  		--asynchronous active low reset
    button  : IN  STD_LOGIC;  		--input signal to be debounced
    button_deb  : OUT STD_LOGIC); 	--debounced signal
end component;

component sample_and_hold is
port(
	CLK: in std_logic;
	pulse_in: in std_logic;
	held_pulse: out std_logic
);
end component;

component HM0360_Interface is
port(
CLK: in std_logic;
SDA: inout std_logic;
SCL: out std_logic;
--
read_config: in std_logic;
init_config: in std_logic;
trig_acq: in std_logic;
--
HM_CP: inout std_logic;
HM_CN: inout std_logic;
HM_DP: inout std_logic_vector(0 downto 0);
HM_DN: inout std_logic_vector(0 downto 0);
--
--
HM_MCLK: out std_logic;
HM_CLK_SEL: out std_logic;
HM_RTC: out std_logic;
HM_SHUTDOWN_N: out std_logic;
HM_SLEEP_N: out std_logic;
--debug
debug_forward: in std_logic;
PADDR_debug: in std_logic_vector(3 downto 0);
data_out_debug: out std_logic_vector(7 downto 0);
dt_o_debug:out std_logic_vector(5 downto 0);
config_finished: out std_logic;
state_read_config_debug: out std_logic
);
end component;

component gen_config_command is
port(
	CLK: in std_logic;
	init_config_seq: in std_logic;
	read_config: out std_logic;
	init_config: out std_logic
);	
end component;

component PLL_sync_clk is
    port(
        clki_i: in std_logic;
        clkop_o: out std_logic
    );
end component;

begin
data_out_debug_n <= not(mux_data_out_debug);
command_button <= not(command_button_n);
debug_button <= not(debug_button_n);
--flag_debug_1--

flag_debug_hold_n <= not(flag_debug_hold);
flag_debug_1_n <= flag_debug_hold_n;
--flag_debug_2 
flag_debug_2_n <= not(state_read_config_debug);
--flag_debug_hold_n2 <= '1'; 

gen_config_command_comp: gen_config_command
port map(
	CLK => CLK,
	init_config_seq => command_deb,
	read_config => read_config,
	init_config => init_config
);

debounce_command: debounce_2 
  generic map(
    clk_freq  => 27_000_000,  		--system clock frequency in Hz
    stable_time => real(100))         		--time button must remain stable in ms (it can be decimal) 0.1 us
  PORT map(
    clk     => CLK,  				--input clock
    reset_n => '1', 				--asynchronous active low reset
    button => command_button,  	--input signal to be debounced
    button_deb => command_deb);	--debounced signal


debounce_acq_trig: debounce_2
  GENERIC map(
    clk_freq  => 27_000_000,  		--system clock frequency in Hz
    stable_time => real(100))         		--time button must remain stable in ms
  PORT map(
    clk     => CLK,  				--input clock
    reset_n => '1',  				--asynchronous active low reset
    button => debug_button,  	--input signal to be debounced
    button_deb => debug_deb);	--debounced signal
	
PLL_sync_comp: PLL_sync_clk port map(
    clki_i=>CLK,
    clkop_o=>CLK_PLL
);
	
sample_and_hold_comp: sample_and_hold
port map(
	CLK => CLK,
	pulse_in => config_finished,
	held_pulse => flag_debug_hold 
);

HM0360_Interface_comp: HM0360_Interface
port map(
CLK => CLK,
SDA => SDA,
SCL => SCL,
--
init_config => init_config,
read_config => read_config,
trig_acq => '0',
--
HM_CP => HM_CP,
HM_CN => HM_CN,
HM_DP => HM_DP,
HM_DN => HM_DN,

--
HM_MCLK => HM_MCLK,
HM_CLK_SEL => HM_CLK_SEL,
HM_RTC => HM_RTC,
HM_SHUTDOWN_N => HM_SHUTDOWN_N,
HM_SLEEP_N => HM_SLEEP_N,
--debug
debug_forward => debug_deb,
PADDR_debug => PADDR_debug,
data_out_debug => data_out_debug,
dt_o_debug => dt_o_debug,
config_finished => config_finished,
state_read_config_debug => state_read_config_debug
);



choice_dout_pr: process(data_out_debug, dt_o_debug) is 
--This process select which kind of output display with LED.
--dt_o_debug		:  	data type from the header CSI-2 DPHY packet
--data_out_debug	:	one of the pixels stored in the temporary buffer
begin
if choice_dout = '0' then
	mux_data_out_debug <= '0' & '0' & dt_o_debug;
else --'1'
	mux_data_out_debug <= data_out_debug;
end if;

end process;


end Behavioral;