library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity enable_pic_source_logic is
port(
Mode_select:in std_logic_vector(7 downto 0);
Mode_select_clear: out std_logic;
streamed: in std_logic;
enable: out std_logic
);
end enable_pic_source_logic;

Architecture Behavioral of enable_pic_source_logic is

constant streaming3_I2C: std_logic_vector(7 downto 0) := '0'&'0'&'0'&'0'&'0'&'0'&'1'&'1';
constant mode_select_reset: std_logic_vector(7 downto 0) := (others => '0');
begin

logic: process(all) is

begin
if Mode_select = streaming3_I2C then
	enable <= '1';
elsif Mode_select = mode_select_reset then
	enable <= '0';
else
	enable <= '0';
end if;

if streamed = '1' then
	Mode_select_clear <= '1';
else
	Mode_select_clear <= '0';
end if;
	
end process;
end Behavioral;