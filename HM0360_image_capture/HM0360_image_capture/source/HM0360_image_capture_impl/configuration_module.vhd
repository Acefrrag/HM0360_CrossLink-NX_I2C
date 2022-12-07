library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity configuration_module is
port(
CLK				: in std_logic;
init_config		: in std_logic;
finished_reg_op	: in std_logic;
data_write		: out std_logic_vector(7 downto 0);
addr			: out std_logic_vector(15 downto 0);
start			: out std_logic;
config_finished	: out std_logic
);
end configuration_module;

Architecture Behavioral of configuration_module is

type FSM_state_t is (idle_s, wait0_s, set_number_frames_s, wait1_s, select_I2C_s, wait2_s, clock_gating_s, PLL_predivider1_s, PLL_predivider2_s, PLL_postdivider_s, wait3_s, wait4_s, wait5_s, cleanup_s);
signal pr_state, nx_state: FSM_state_t := idle_s;
--Register List and values to be written
constant addr_PMU_CFG_3: std_logic_vector(15 downto 0):=std_logic_vector(to_unsigned(16#3024#,16));
constant PMU_CFG_3_1: std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#00#,8));
constant addr_PMU_CFG_7: std_logic_vector(15 downto 0):=std_logic_vector(to_unsigned(16#3028#,16));
constant PMU_CFG_7_1: std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#01#,8));
constant addr_OPFM_CNTR: std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(16#1014#,16));
constant OPFM_CNTR_1: std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#07#,8));
constant PLL_POST_DIV_D_addr : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(16#3118#, 16));
constant PLL_POST_DIV_D_1 : std_logic_vector(7 downto 0) := (others => '0');
constant PLL1CFG_A_addr: std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(16#3500#, 16));
constant PLL1CFG_A_1: std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#04#, 8));
constant PLL3CFG_A_addr: std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(16#3502#, 16));
constant PLL3CFG_A_1: std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#18#, 8));
--Miscellaneous
signal config_finished_internal: std_logic := '0';
begin

FSM_pr_state: process(CLK) is
begin
if rising_edge(CLK) then
	pr_state <= nx_state;
end if;
end process;

FSM_nx_state: process(all) is

begin

case pr_state is
when idle_s =>
	if init_config = '1' then
		nx_state <= wait0_s;
	end if;
when wait0_s =>
	if finished_reg_op = '0' then
		nx_state <= set_number_frames_s;
	else
		nx_state <= wait0_s;
	end if;
when set_number_frames_s =>
	if finished_reg_op = '1' then
		nx_state <= wait1_s;
	end if;
when wait1_s =>
	if finished_reg_op = '0' then
		nx_state <= select_I2C_s;
	else
		nx_state <= wait1_s;
	end if;
when select_I2C_s =>
	if finished_reg_op = '1' then
		nx_state <= wait2_s;
	end if;
when wait2_s =>
	if finished_reg_op = '0' then
		nx_state <= clock_gating_s;
	else
		nx_state <= wait2_s;
	end if;
when clock_gating_s =>
	if finished_reg_op = '1' then
		nx_state <= wait3_s;
	end if;
when wait3_s =>
	if finished_reg_op = '0' then
		nx_state <= PLL_predivider1_s;
	else
		nx_state <= wait3_s;
	end if;
when PLL_predivider1_s =>
	if finished_reg_op = '1' then
		nx_state <= wait4_s;
	end if;
when wait4_s =>
	if finished_reg_op = '0' then
		nx_state <= PLL_predivider2_s;
	else
		nx_state <= wait4_s;
	end if;
when PLL_predivider2_s =>
	if finished_reg_op = '1' then
		nx_state <= wait5_s;
	end if;
when wait5_s =>
	if finished_reg_op = '0' then
		nx_state <= PLL_postdivider_s;
	else
		nx_state <= wait5_s;
	end if;
when PLL_postdivider_s =>
	if finished_reg_op = '1' then
		nx_state <= cleanup_s;
	end if;
when cleanup_s =>
	if init_config = '1' then
		nx_state <= cleanup_s;
	else
		nx_state <= idle_s;
	end if;
end case;

end process;

FSM_output: process(all) is

begin

case pr_state is
when idle_s =>
	start <= '0';
	addr <= (others => '0');
	data_write <= (others => '0');
	config_finished_internal <= '0';
when wait0_s =>
	start <= '0';
	addr <= std_logic_vector(to_unsigned(16#3028#, 16));
	data_write <= std_logic_vector(to_unsigned(16#01#, 8));
when set_number_frames_s =>
	if finished_reg_op = '1' then
		start <= '0';
	else
		start <= '1';
	end if;
	addr <= std_logic_vector(to_unsigned(16#3028#, 16));
	data_write <= std_logic_vector(to_unsigned(16#01#, 8));
when wait1_s =>
	start <= '0';
	addr <= std_logic_vector(to_unsigned(16#3024#, 16));
	data_write <= std_logic_vector(to_unsigned(16#00#, 8));
when select_I2C_s =>
	if finished_reg_op = '1' then
		start <= '0';
	else
		start <= '1';
	end if;
	addr <= std_logic_vector(to_unsigned(16#3024#, 16));
	data_write <= std_logic_vector(to_unsigned(16#00#, 8));
when wait2_s =>
	start <= '0';
	addr <= std_logic_vector(to_unsigned(16#1014#, 16));
	data_write <= std_logic_vector(to_unsigned(16#07#, 8));
when clock_gating_s =>
	if finished_reg_op = '1' then
		start <= '0';
	else
		start <= '1';
	end if;
	addr <= std_logic_vector(to_unsigned(16#1014#, 16));
	data_write <= std_logic_vector(to_unsigned(16#07#, 8));
when wait3_s =>
	start <= '0';
	addr <= PLL1CFG_A_addr;
	data_write <= PLL1CFG_A_1;
when PLL_predivider1_s =>
	if finished_reg_op = '1' then
		start <= '0';
	else
		start <= '1';
	end if;
	addr <= PLL1CFG_A_addr;
	data_write <= PLL1CFG_A_1;
when wait4_s =>
	start <= '0';
	addr <= PLL3CFG_A_addr;
	data_write <= PLL3CFG_A_1;
when PLL_predivider2_s =>
	if finished_reg_op = '1' then
		start <= '0';
	else
		start <= '1';
	end if;
	addr <= PLL3CFG_A_addr;
	data_write <= PLL3CFG_A_1;
when wait5_s =>
	start <= '0';
	addr <= PLL_POST_DIV_D_addr;
	data_write <= PLL_POST_DIV_D_1;
when PLL_postdivider_s =>
	if finished_reg_op = '1' then
		start <= '0';
	else
		start <= '1';
	end if;
	addr <= PLL_POST_DIV_D_addr;
	data_write <= PLL_POST_DIV_D_1;
when cleanup_s =>
	start <= '0';
	addr <= (others => '0');
	data_write <= (others => '0');
	config_finished_internal <= '1';
end case;

end process;

config_finished <= config_finished_internal;

end Behavioral;