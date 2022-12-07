library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HM0360_top_level_tb is

end HM0360_top_level_tb;

Architecture Behavioral of HM0360_top_level_tb is

constant slave_ID: std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(16#24#,7));

signal CLK: std_logic := '0';
signal SDA: std_logic;
signal SCL: std_logic;
signal start_button_n: std_logic := '1';
signal R_W_button_n: std_logic := '1';
signal RD_content1_LED, RD_content2_LED, RD_content3_LED, RD_content4_LED, RD_content5_LED, RD_content6_LED, RD_content7_LED, RD_content8_LED :std_logic;
signal RD_content1_LED_n, RD_content2_LED_n, RD_content3_LED_n, RD_content4_LED_n, RD_content5_LED_n, RD_content6_LED_n, RD_content7_LED_n, RD_content8_LED_n :std_logic;
signal RW_LED, RW_LED_n: std_logic;
signal HM_MCLK, HM_CLK_SEL, HM_RTC, HM_SHUTDOWN_N, HM_SLEEP_N: std_logic;
signal start_button, RW_button: std_logic;

component HM0360_top_level is
port(
CLK: in std_logic;
R_W_button_n: in std_logic;
SDA: inout std_logic;
SCL: inout std_logic;
start_button_n: in std_logic;
RD_content1_LED_n: out std_logic;
RD_content2_LED_n: out std_logic;
RD_content3_LED_n: out std_logic;
RD_content4_LED_n: out std_logic;
RD_content5_LED_n: out std_logic;
RD_content6_LED_n: out std_logic;
RD_content7_LED_n: out std_logic;
RD_content8_LED_n: out std_logic;
RW_LED_n: out std_logic;
HM_MCLK: out std_logic;
HM_CLK_SEL: out std_logic;
HM_RTC: out std_logic;
HM_SHUTDOWN_N: out std_logic;
HM_SLEEP_N: out std_logic
); 
end component;

component HM0360_serial_I2C_slave is
generic(
constant slave_ID: std_logic_vector(6 downto 0)
);
port(
SDA: inout std_logic;
SCL: inout std_logic
);
end component;



begin

RD_content1_LED <= not(RD_content1_LED_n);
RD_content2_LED <= not(RD_content2_LED_n);
RD_content3_LED <= not(RD_content3_LED_n);
RD_content4_LED <= not(RD_content4_LED_n);
RD_content5_LED <= not(RD_content5_LED_n);
RD_content6_LED <= not(RD_content6_LED_n); 
RD_content7_LED <= not(RD_content7_LED_n); 
RD_content8_LED <= not(RD_content8_LED_n);
RW_LED <= not(RW_LED_n);
start_button <= not(start_button_n);
RW_button <= not(R_W_button_n);


HM0360_top_level_comp: HM0360_top_level 
port map(
CLK => CLK,
SDA => SDA,
SCL => SCL,
R_W_button_n =>  R_W_button_n,
start_button_n => start_button_n,
RD_content1_LED_n => RD_content1_LED_n,
RD_content2_LED_n => RD_content2_LED_n,
RD_content3_LED_n => RD_content3_LED_n,
RD_content4_LED_n => RD_content4_LED_n,
RD_content5_LED_n => RD_content5_LED_n,
RD_content6_LED_n => RD_content6_LED_n,
RD_content7_LED_n => RD_content7_LED_n,
RD_content8_LED_n => RD_content8_LED_n,
RW_LED_n => RW_LED_n,
HM_MCLK => HM_MCLK,
HM_CLK_SEL => HM_CLK_SEL,
HM_RTC => HM_RTC,
HM_SHUTDOWN_N => HM_SHUTDOWN_N,
HM_SLEEP_N => HM_RTC
);

HM0360_slave_comp: HM0360_serial_I2C_slave
generic map(
slave_ID => slave_ID
)
port map(
SDA => SDA,
SCL => SCL
);

CLK_gen: process is
begin
wait for 18_500 ps;
CLK <= not(CLK);
end process;


start_gen: process is
begin
wait for 2 ms;
start_button_n <= '0';
wait for 11 ms;
start_button_n <= '1';
wait for 11 ms;
start_button_n <= '0';
wait for 11 ms;
start_button_n <= '1';
wait for 11 ms;
start_button_n <= '0';
wait for 11 ms;
start_button_n <= '1';
wait for 11 ms;
start_button_n <= '0';
wait for 11 ms;
start_button_n <= '1';
wait for 11 ms;
start_button_n <= '0';
wait for 11 ms;
start_button_n <= '1';
wait for 11 ms;
start_button_n <= '0';
wait for 11 ms;
start_button_n <= '1';
wait for 11 ms;
start_button_n <= '0';
wait for 11 ms;
start_button_n <= '1';
wait for 11 ms;
start_button_n <= '0';
wait for 11 ms;
start_button_n <= '1';
wait for 11 ms;
start_button_n <= '0';
wait;
end process;

R_W_gen: process is
begin
--
wait for 100 ns;
-- RW bit goes high after 11 ms.
-- Remember RW transitions every time the button is pressed
R_W_button_n <= '0';
wait;
end process;


end Behavioral;