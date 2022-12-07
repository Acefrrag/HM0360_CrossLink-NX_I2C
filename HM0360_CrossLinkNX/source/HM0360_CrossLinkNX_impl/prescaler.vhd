library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.std_logic_unsigned.all;

entity prescaler is
generic(
	constant input_frequency: natural := 27_000_000; 		--input_frequency: input frequency in Hz
	constant output_frequency: natural := 100_000 			--output_frequenct: output frequency in Hz
);
port(
	CLK_IN: in std_logic;
	CLK_OUT: out std_logic;
	shifted_CLK_OUT: out std_logic
);
end prescaler;

Architecture Behavioral of prescaler is

constant end_value: natural := natural(ceil(real(input_frequency)/real(output_frequency)/real(4))); --Number of system clock cycles in 1/4 of SCL

component counter is
generic(
	constant end_value: natural
);
port(
	CLK_IN: in std_logic;
	CLK_OUT: out std_logic;
	shifted_CLK_OUT: out std_logic
);
end component;

begin

counter_comp: counter
generic map(
	end_value => end_value
)
port map(
	CLK_IN => CLK_IN,
	CLK_OUT => CLK_OUT,
	shifted_CLK_OUT => shifted_CLK_OUT
);



end Behavioral;