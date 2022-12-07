--Engineer: Michele Pio Fragasso
--Description


library ieee;
use ieee.std_logic_1164.all;

entity sample_and_hold is
port(
	CLK: in std_logic;
	pulse_in: in std_logic;
	held_pulse: out std_logic
);
end sample_and_hold;

Architecture Behavioral of sample_and_hold is

signal slow_CLK, slow_CLK_shifted: std_logic;
signal reset_sample, sample: std_logic;

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

sample_pr: process(reset_sample, CLK) is
begin
if reset_sample = '1' then
	sample <= '0';
elsif rising_edge(CLK) then
		if pulse_in = '1' then
			sample <= '1'; 
		end if;
end if;
end process;

held_pulse_pr: process(slow_CLK) is
begin
if rising_edge(slow_CLK) then

	if sample = '1' then
		held_pulse <= '1';
		reset_sample <= '1';
	else
		held_pulse <= '0';
		reset_sample <= '0';
	end if;
end if;
end process;




end Behavioral;
			   
		