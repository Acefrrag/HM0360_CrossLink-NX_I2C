library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debounce_2_tb is

end debounce_2_tb;

Architecture Behavioral of debounce_2_tb is

signal button: std_logic := '1';
signal reset_n: std_logic := '1';
signal button_deb: std_logic;
signal CLK: std_logic := '0';

component debounce_2 is
  GENERIC(
    clk_freq    : INTEGER;  --system clock frequency in Hz
    stable_time : real --time button must remain stable in ms
	);         
  PORT(
    clk     : IN  STD_LOGIC;  --input clock
    reset_n : IN  STD_LOGIC;  --asynchronous active low reset
    button  : IN  STD_LOGIC;  --input signal to be debounced
    button_deb  : OUT STD_LOGIC); --debounced signal
end component;

begin

debounce_2_comp: debounce_2
generic map(
	clk_freq => 27_000_000,
	stable_time => real(0.01)
)
port map(
	clk => CLK,
	reset_n => reset_n,
	button => button,
	button_deb => button_deb
);

CLK_gen: process is
begin
wait for 18500 ps;
CLK <= not(CLK);
end process;

end Behavioral;
