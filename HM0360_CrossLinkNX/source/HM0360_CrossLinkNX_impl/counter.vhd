library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

entity counter is
generic(
	constant end_value: natural := 10
);
port(
	CLK_IN: in std_logic;				--input clock
	CLK_OUT: out std_logic;				--output clock
	shifted_CLK_OUT: out std_logic		--90 phase shifted output clock
);
end counter;

Architecture Behavioral of counter is

signal CLK_OUT_int, shifted_CLK_OUT_int: std_logic := '0';

begin
CLK_OUT <= CLK_OUT_int;
shifted_CLK_OUT <= shifted_CLK_OUT_int;
count_pr: process(CLK_IN) is
variable c:natural := 0;
begin

if rising_edge(CLK_IN) then
	c := c + 1;
	case c is
	when 0 to end_value - 1 =>
		CLK_OUT_int <= '0';
		shifted_CLK_OUT_int <= '0';
	when end_value to 2*end_value - 1 =>
		CLK_OUT_int <= '0';
		shifted_CLK_OUT_int <= '1';
	when 2*end_value to 3*end_value - 1 =>
		CLK_OUT_int <= '1';
		shifted_CLK_OUT_int <= '1';
	when 3*end_value to 4*end_value - 1 =>
		CLK_OUT_int <= '1';
		shifted_CLK_OUT_int <= '0';
	when others => --4*end_value
		c := 0;
	end case;
end if;
end process;



end Behavioral;