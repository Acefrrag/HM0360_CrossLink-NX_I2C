library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trig_acq_module is
port(
CLK					: in std_logic;
trig_acq			: in std_logic;
finished_reg_op		: in std_logic;
data_write			: out std_logic_vector(7 downto 0);
addr				: out std_logic_vector(15 downto 0);
start				: out std_logic
);
end trig_acq_module;

Architecture Behavioral of trig_acq_module is

type FSM_state_t is (idle_s, wait_s, trig_acq_s, cleanup_s);
signal pr_state, nx_state: FSM_state_t := idle_s;

begin

FSM_pr_state: process(CLK) is

begin
if rising_edge(CLK) then
	pr_state <= nx_state;
end if;
end process;

FSM_nx_state: process(all) is

begin
case (pr_state) is
when idle_s =>
	if trig_acq = '1' then
		nx_state <= wait_s;
	end if;
when wait_s =>
	nx_state <= trig_acq_s;
when trig_acq_s =>
	if finished_reg_op = '1' then
		nx_state <= cleanup_s;
	else
		nx_state <= trig_acq_s;
	end if;
when cleanup_s =>
	if trig_acq = '1' then
		nx_state <= cleanup_s;
	else
		nx_state <= idle_s;
	end if;
end case;

end process;

FSM_output: process(all) is

begin
case (pr_state) is
when idle_s =>
	start <= '0';
	addr <= (others => '0');
	data_write <= (others => '0');
when wait_s =>
	start <= '0';
	addr <= std_logic_vector(to_unsigned(16#0100#, 16));
	data_write <= std_logic_vector(to_unsigned(16#03#, 8));
when trig_acq_s =>
	if finished_reg_op = '1' then
		start <= '0';
	else
		start <= '1';
	end if;
	addr <= std_logic_vector(to_unsigned(16#0100#, 16));
	data_write <= std_logic_vector(to_unsigned(16#03#, 8));
when cleanup_s =>
	start <= '0';
	addr <= (others => '0');
	data_write <= (others => '0');
end case;

end process;

end Behavioral;