library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;

-- The image buffer must be implemented with a Block Ram

entity image_buffer is
port(
en_sample: in std_logic;						--Enable the signal on the data bus.
PCLK: in std_logic;
PADDR: in std_logic_vector(3 downto 0);
D: in std_logic_vector(7 downto 0);
data_out: out std_logic_vector(7 downto 0)
);
end image_buffer;

Architecture Behavioral of image_buffer is

type buffer_data_t is array(0 to 15) of std_logic_vector(7 downto 0);
signal buffer_data: buffer_data_t := (others => (others => '0'));


begin



buffer_fill_pr: process(PCLK) is
variable c: integer := 0;

begin
if falling_edge(PCLK) then
	if en_sample then
		buffer_data(c) <= D;
		c := c + 1;
	end if;
	if c = 10 then
		c := 0;
	end if;
end if;
end process;

data_out <= buffer_data(to_integer(unsigned(PADDR)));


end Behavioral;