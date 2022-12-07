library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HM0360_Interface_top_level_tb is
--port
end HM0360_Interface_top_level_tb;
--
Architecture Behavioral of HM0360_Interface_top_level_tb is
--
signal CLK : std_logic := '1';
signal init_config_button_n: std_logic := '1';signal trig_acq_button_n: std_logic := '1';
-- 
signal HM_MCLK, HM_CLK_SEL, HM_RTC, HM_SHUTDOWN_N, HM_SLEEP_N: std_logic;
signal data_out_debug: std_logic_vector(7 downto 0);
signal flag_debug_n: std_logic;
-- 
signal SDA: std_logic;
signal SCL: std_logic;
-- 
signal HM_CP, HM_CN: std_logic;signal HM_DP, HM_DN: std_logic_vector(0 downto 0);
-- 
signal Mode_select_out: std_logic_vector(7 downto 0);
signal Mode_select_clear: std_logic:='0';


component HM0360_Interface_top_level is
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
end component;


component HM0360_device is
generic(
constant slave_ID: std_logic_vector(6 downto 0) --:= std_logic_vector(to_unsigned(16#24#,7))
);
port(
SDA: inout std_logic;								--SDA
SCL: in std_logic;									--SCL
Mode_select_out: out std_logic_vector(7 downto 0);	--Mode_select_out: This signal contains the contect of the MODE_SELECT register. It is used to inform the image streaming module haw many images to stream 
Mode_select_clear: in std_logic						--Mode_select_clear: This is a clear signal. Used to clear the content of the MODE_SELECT register, to simulate the behavior of the register.
);
end component;


begin


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


HM0360_Interface_top_level_comp: HM0360_Interface_top_level
port map(
	--
	CLK => CLK,
	--
	SDA => SDA,
	SCL => SCL,
	--
	init_config_button_n => init_config_button_n,
	trig_acq_button_n => trig_acq_button_n,
	--MIPI Interfaces
	HM_CP => HM_CP,
	HM_CN => HM_CN, 
	HM_DP => HM_DP,
	HM_DN => HM_DN,
	--
	--
	HM_MCLK => HM_MCLK,
	HM_CLK_SEL => HM_CLK_SEL,
	HM_RTC => HM_RTC, 
	HM_SHUTDOWN_N => HM_SHUTDOWN_N, 
	HM_SLEEP_N => HM_SLEEP_N,
	--debug
	data_out_debug_n => data_out_debug,
	flag_debug_n => flag_debug_n
);


CLK_gen: process is

begin
wait for 1_851 ps; --270 MHz clock 1.851 ns 1851 us --27MHz clock 18.518 18518 us
CLK <= not(CLK);
end process;

config_button_gen: process is 
begin
wait for 1 ns; --0.01 us
init_config_button_n <= '1';
wait for 10 ns; --0.1 us
init_config_button_n <= '0';
wait for 1 us;
init_config_button_n <= '1';
wait for 25 us;
init_config_button_n <= '0';
wait for 10 ns; -- the slow CLK has a frequency of 10 MHz, that is a period of 
init_config_button_n <= '1';
wait for 10 ns;
init_config_button_n <= '0';
wait for 10 ns;
init_config_button_n <= '1';
wait;
end process;

trig_acq_button_gen: process is

begin
--wait for 10 us; --wait for configuration to finish
--trig_acq_button <= '1';
--wait for 100 ns;
--trig_acq_button <= '0';
wait;

end process;

end Behavioral;