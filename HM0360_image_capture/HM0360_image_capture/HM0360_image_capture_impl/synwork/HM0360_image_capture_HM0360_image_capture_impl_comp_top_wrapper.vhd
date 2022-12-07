--
-- Synopsys
-- Vhdl wrapper for top level design, written on Mon Nov 21 21:57:31 2022
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity wrapper_for_HM0360_Interface_top_level is
   port (
      CLK : in std_logic;
      SDA : in std_logic;
      SCL : out std_logic;
      init_config_button_n : in std_logic;
      trig_acq_button_n : in std_logic;
      HM_CP : in std_logic;
      HM_CN : in std_logic;
      HM_DP : in std_logic_vector(0 downto 0);
      HM_DN : in std_logic_vector(0 downto 0);
      HM_MCLK : out std_logic;
      HM_CLK_SEL : out std_logic;
      HM_RTC : out std_logic;
      HM_SHUTDOWN_N : out std_logic;
      HM_SLEEP_N : out std_logic;
      data_out_debug_n : out std_logic_vector(7 downto 0)
   );
end wrapper_for_HM0360_Interface_top_level;

architecture behavioral of wrapper_for_HM0360_Interface_top_level is

component HM0360_Interface_top_level
 port (
   CLK : in std_logic;
   SDA : inout std_logic;
   SCL : out std_logic;
   init_config_button_n : in std_logic;
   trig_acq_button_n : in std_logic;
   HM_CP : inout std_logic;
   HM_CN : inout std_logic;
   HM_DP : inout std_logic_vector (0 downto 0);
   HM_DN : inout std_logic_vector (0 downto 0);
   HM_MCLK : out std_logic;
   HM_CLK_SEL : out std_logic;
   HM_RTC : out std_logic;
   HM_SHUTDOWN_N : out std_logic;
   HM_SLEEP_N : out std_logic;
   data_out_debug_n : out std_logic_vector (7 downto 0)
 );
end component;

signal tmp_CLK : std_logic;
signal tmp_SDA : std_logic;
signal tmp_SCL : std_logic;
signal tmp_init_config_button_n : std_logic;
signal tmp_trig_acq_button_n : std_logic;
signal tmp_HM_CP : std_logic;
signal tmp_HM_CN : std_logic;
signal tmp_HM_DP : std_logic_vector (0 downto 0);
signal tmp_HM_DN : std_logic_vector (0 downto 0);
signal tmp_HM_MCLK : std_logic;
signal tmp_HM_CLK_SEL : std_logic;
signal tmp_HM_RTC : std_logic;
signal tmp_HM_SHUTDOWN_N : std_logic;
signal tmp_HM_SLEEP_N : std_logic;
signal tmp_data_out_debug_n : std_logic_vector (7 downto 0);

begin

tmp_CLK <= CLK;

tmp_SDA <= SDA;

SCL <= tmp_SCL;

tmp_init_config_button_n <= init_config_button_n;

tmp_trig_acq_button_n <= trig_acq_button_n;

tmp_HM_CP <= HM_CP;

tmp_HM_CN <= HM_CN;

tmp_HM_DP <= HM_DP;

tmp_HM_DN <= HM_DN;

HM_MCLK <= tmp_HM_MCLK;

HM_CLK_SEL <= tmp_HM_CLK_SEL;

HM_RTC <= tmp_HM_RTC;

HM_SHUTDOWN_N <= tmp_HM_SHUTDOWN_N;

HM_SLEEP_N <= tmp_HM_SLEEP_N;

data_out_debug_n <= tmp_data_out_debug_n;



u1:   HM0360_Interface_top_level port map (
		CLK => tmp_CLK,
		SDA => tmp_SDA,
		SCL => tmp_SCL,
		init_config_button_n => tmp_init_config_button_n,
		trig_acq_button_n => tmp_trig_acq_button_n,
		HM_CP => tmp_HM_CP,
		HM_CN => tmp_HM_CN,
		HM_DP => tmp_HM_DP,
		HM_DN => tmp_HM_DN,
		HM_MCLK => tmp_HM_MCLK,
		HM_CLK_SEL => tmp_HM_CLK_SEL,
		HM_RTC => tmp_HM_RTC,
		HM_SHUTDOWN_N => tmp_HM_SHUTDOWN_N,
		HM_SLEEP_N => tmp_HM_SLEEP_N,
		data_out_debug_n => tmp_data_out_debug_n
       );
end behavioral;
