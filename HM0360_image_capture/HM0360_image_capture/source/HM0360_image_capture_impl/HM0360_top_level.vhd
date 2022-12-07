library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HM0360_top_level is
port(
	CLK: in std_logic;
	init_config_button: in std_logic;
	trig_acq_button: in std_logic;
	PADDR_debug: in std_logic_vector(18 downto 0);
	data_out_debug: out std_logic_vector(7 downto 0)
);
end HM0360_top_level;

Architecture Behavioral of HM0360_top_level is

signal SDA: std_logic := 'Z';
signal SCL: std_logic;
signal PCLKO: std_logic;
signal D: std_logic_vector(7 downto 0);
signal HM_HSYNC, HM_FSYNC:std_logic;
signal HM_MCLK, HM_CLK_SEL, HM_RTC, HM_SHUTDOWN_N, HM_SLEEP_N: std_logic;
signal enable, streamed: std_logic;
signal Mode_select_clear: std_logic;
signal Mode_select_out: std_logic_vector(7 downto 0);
constant pic_filename: string := "C:\Users\miche\Desktop\my_designs\HM0360_image_capture\scripts\pic_file.txt";
signal init_config_deb, trig_acq_deb: std_logic;

component debounce_2 is
  GENERIC(
    clk_freq    : INTEGER;  --system clock frequency in Hz
    stable_time : real
);    --time button must remain stable in ms
  PORT(
    clk     : IN  STD_LOGIC;  --input clock
    reset_n : IN  STD_LOGIC;  --asynchronous active low reset
    button  : IN  STD_LOGIC;  --input signal to be debounced
    button_deb  : OUT STD_LOGIC); --debounced signal
end component;

component HM0360_Interface is
port(
CLK: in std_logic;
SDA: inout std_logic;
SCL: out std_logic;
--
init_config: in std_logic;
trig_acq: in std_logic;
--
PCLK: in std_logic;
D: in std_logic_vector(7 downto 0);
--
HM_HSYNC: in std_logic;
HM_FSYNC: in std_logic;
--
HM_MCLK: out std_logic;
HM_CLK_SEL: out std_logic;
HM_RTC: out std_logic;
HM_SHUTDOWN_N: out std_logic;
HM_SLEEP_N: out std_logic;
--debug
PADDR_debug: in std_logic_vector(18 downto 0);
data_out_debug: out std_logic_vector(7 downto 0)
);
end component;

component pic_source is
generic(
	pic_filename: string
);	
port(
	PCLKO: out std_logic;
	D: out std_logic_vector(7 downto 0);
	enable: in std_logic;
	HSYNC: out std_logic;
	FSYNC: out std_logic;
	streamed: out std_logic
);
end component;

component HM0360_device is
generic(
constant slave_ID: std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(16#24#,7))
);
port(
SDA: inout std_logic;
SCL: in std_logic;
Mode_select_out: out std_logic_vector(7 downto 0);
Mode_select_clear: in std_logic
);
end component;

component enable_pic_source_logic is
port(
Mode_select:in std_logic_vector(7 downto 0);
Mode_select_clear: out std_logic;
streamed: in std_logic;
enable: out std_logic
);

end component;

begin

debounce_init_config: debounce_2
  GENERIC map(
    clk_freq  => 27_000_000,  --system clock frequency in Hz
    stable_time => real(0.01)         --time button must remain stable in ms
)
  PORT map(
    clk     => CLK,  --input clock
    reset_n => '1',  --asynchronous active low reset
    button => init_config_button,  --input signal to be debounced
    button_deb => init_config_deb); --debounced signal


debounce_acq_trig: debounce_2
  GENERIC map(
    clk_freq  => 27_000_000,  --system clock frequency in Hz
    stable_time => real(0.01))         --time button must remain stable in ms
  PORT map(
    clk     => CLK,  --input clock
    reset_n => '1',  --asynchronous active low reset
    button => trig_acq_button,  --input signal to be debounced
    button_deb => trig_acq_deb); --debounced signal


HM0360_Interface_comp: HM0360_Interface
port map(
CLK => CLK,
SDA => SDA,
SCL => SCL,
--
init_config => init_config_deb,
trig_acq => trig_acq_deb,
--
PCLK => PCLKO,
D => D,
--
HM_HSYNC => HM_HSYNC,
HM_FSYNC => HM_FSYNC,
--
HM_MCLK => HM_MCLK,
HM_CLK_SEL => HM_CLK_SEL,
HM_RTC => HM_RTC,
HM_SHUTDOWN_N => HM_SHUTDOWN_N,
HM_SLEEP_N => HM_SLEEP_N,
--debug
PADDR_debug => PADDR_debug,
data_out_debug => data_out_debug
);

enable_pic_source_logic_comp: enable_pic_source_logic
port map(
Mode_select => Mode_select_out,
Mode_select_clear => Mode_select_clear,
streamed => streamed,
enable => enable
);

HM0360_device_comp: HM0360_device
generic map(
slave_ID => std_logic_vector(to_unsigned(16#24#,7))
)
port map(
SDA => SDA, 
SCL => SCL,
Mode_select_out => Mode_select_out,
Mode_select_clear => Mode_select_clear
);

pic_source_comp: pic_source
generic map(
	pic_filename => pic_filename
)
port map(
	PCLKO => PCLKO,
	D => D,
	enable => enable,
	HSYNC => HM_HSYNC,
	FSYNC => HM_FSYNC,
	streamed => streamed
);





end Behavioral;


