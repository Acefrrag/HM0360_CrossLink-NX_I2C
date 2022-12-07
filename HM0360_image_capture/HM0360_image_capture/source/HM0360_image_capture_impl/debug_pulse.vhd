library ieee;
use ieee.std_logic_1164.all;

entity debounce_pulse is
  GENERIC(
    clk_freq    : INTEGER := 27_000_000;  --system clock frequency in Hz
    stable_time : real := real(0.01)      --time button must remain stable in ms
);         
  PORT(
    clk     : IN  STD_LOGIC;  --input clock
    reset_n : IN  STD_LOGIC;  --asynchronous active low reset
    button  : IN  STD_LOGIC;  --input signal to be debounced
    button_deb  : OUT STD_LOGIC --debounced signal
); 
End debounce_pulse;

Architecture Behavioral of debounce_pulse is

begin



end Behavioral;