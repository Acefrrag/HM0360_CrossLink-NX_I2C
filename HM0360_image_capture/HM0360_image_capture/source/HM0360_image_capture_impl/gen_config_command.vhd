library ieee;
use ieee.std_logic_1164.all;

entity gen_config_command is

port(
	CLK: in std_logic;
	init_config_seq: in std_logic; 		--init_config_seq: Initialization Configuration Sequence
	read_config: out std_logic;
	init_config: out std_logic
);
end gen_config_command;

Architecture Behavioral of gen_config_command is

signal slow_CLK: std_logic;
signal slow_CLK_shifted: std_logic;
signal c: natural := 0;
signal reset_c: std_logic := '0';

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

begin

prescaler_comp: prescaler 
generic map(
	input_frequency => 27_000_000,
	output_frequency => 1
)
port map(
	CLK_IN => CLK,
	CLK_OUT => slow_CLK,
	shifted_CLK_OUT => slow_CLK_shifted
);

gen_command_pr: process(all) is
variable count_slow_CLK_cycles: integer := 0;
begin
if rising_edge(slow_CLK) then
	case c is
	when 0 =>
		read_config <= '0';
		init_config <= '0';
		reset_c <= '0';     
	when 1 =>
		read_config <= '0';
		init_config <= '1';
		reset_c <= '1';
	when 2 =>
		read_config <= '1';
		init_config <= '0';
		reset_c <= '1';
	when others =>
		read_config <= '0';
		init_config <= '0';
		reset_c <= '1';
	end case;
end if;
end process;
 
counter_button: process(reset_c, init_config_seq) is

begin

if reset_c = '1' then
	c <= 0;
elsif rising_edge(init_config_seq) then
	c <= c + 1; 
end if;

end process;



end Behavioral;