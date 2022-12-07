library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
	
entity pic_source is
generic(
	pic_filename: string := "C:\Users\miche\Desktop\my_designs\HM0360_image_capture\scripts\pic_file.txt"
);	
port(
	PCLKO: out std_logic;
	D: out std_logic_vector(7 downto 0);
	enable: in std_logic;
	HSYNC: out std_logic;
	FSYNC: out std_logic;
	streamed: out std_logic
);
end pic_source;

Architecture Behavioral of pic_source is

--Signals
type img_t is array (natural range <>, natural range <>) of std_logic_vector;
constant vertical_size: integer := 656;
constant horizontal_size: integer := 496;

impure function create_image (filename: string) return img_t is

file pic_file_handle: text;
variable row: line;
variable pixel: bit_vector(7 downto 0);
variable i: integer := 0;
variable img_content: img_t(0 to vertical_size-1, 0 to horizontal_size-1)(7 downto 0);
begin
file_open(pic_file_handle, filename, read_mode);
for i in 0 to vertical_size-1 loop
	for j in 0 to horizontal_size-1 loop
		readline(pic_file_handle, row);
		read(row, pixel);
		img_content(i,j) := To_StdLogicVector(pixel);
	end loop;
end loop;
file_close(pic_file_handle);
return img_content;

end function;

--Signals
signal img: img_t(0 to vertical_size-1, 0 to horizontal_size-1)(7 downto 0) := create_image(pic_filename);
signal PCLKO_internal: std_logic :='0';
signal HSYNC_internal, FSYNC_internal: std_logic := '0';
signal streamed_internal: std_logic := '0';




begin

PCLKO <= PCLKO_internal;
HSYNC <= HSYNC_internal;
FSYNC <= FSYNC_internal;
streamed <= streamed_internal;

PCLKO_gen: process is

begin
wait for 60 ns;
PCLKO_internal <= not(PCLKO_internal);
end process;




feeder_pr: process(PCLKO_internal) is 
variable i, j:integer := 0;
constant num_cycles: integer := 10;
variable i_wait, j_wait: integer := num_cycles;
variable HSYNC_variable, FSYNC_variable: std_logic := '0';
begin
if rising_EDGE(PCLKO_internal) then
	if enable = '1' then
		streamed_internal <= '0';
		if j_wait = num_cycles then
			HSYNC_variable := '1';
			if i_wait = num_cycles then
				D <= img(vertical_size-1-i,j);	
				FSYNC_variable := '1';
				j := j + 1;
				
			else
				i_wait := i_wait + 1;
			end if;
		else
			j_wait := j_wait + 1;
		end if;
		if HSYNC_variable = '0' or FSYNC_variable = '0' then
			D <= (others => '0');
		end if;
	end if;
end if;
if falling_edge(PCLKO_internal) then
	if j = horizontal_size then
		HSYNC_variable := '0';
		j_wait := 0;
		j := 0;
		i := i + 1;
	end if;
	if i = vertical_size then
		FSYNC_variable := '0';
		i_wait := 0;
		i := 0;
		j := 0;
		streamed_internal <= '1';
	end if;
end if;
HSYNC_internal <= HSYNC_variable;
FSYNC_internal <= FSYNC_variable;

end process;

end Behavioral;