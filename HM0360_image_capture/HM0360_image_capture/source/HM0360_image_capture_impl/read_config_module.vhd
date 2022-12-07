library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity read_config_module is
port(
	CLK: in std_logic;				--CLK				:System Clock
	read_config: in std_logic;		--read_conf			:Read Configuration bit. This trigger the reading from the register list 
	finished_reg_op: in std_logic;	--finished_reg_op	:Register operation finished bit. Is st to '1' when the singl register operation(for this module it's all read op) has been completed
	addr: out std_logic_vector(15 downto 0);			--addr				:addr to read from
	start : out std_logic;			--start				:Start bit. This sends out the register operation command
	--debug
	debug_go_to_nx: in std_logic;	--debug_go_to_nx	: Used to move to the next read_configuration step
	state_debug: out std_logic
);
end read_config_module;

Architecture Behavioral of read_config_module is

type read_state_s is (idle_s, wait0_s, set_number_frames_s, wait1_s, select_I2C_s, wait2_s, clock_gating_s, PLL_predivider1_s, PLL_predivider2_s, PLL_postdivider_s, wait3_s, wait4_s, wait5_s, cleanup_s);
signal pr_state, nx_state: read_state_s := idle_s;
signal slow_CLK, slow_CLK_shifted: std_logic;
--Registers' signals and constants
--
constant PLL_POST_DIV_D_addr : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(16#3118#, 16));
signal PLL_POST_DIV_D : std_logic_vector(7 downto 0) := (others => '0');
--
constant PLL1CFG_A_addr: std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(16#3500#, 16));
signal PLL1CFG_A: std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#04#, 8));
--
constant PLL3CFG_A_addr: std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(16#3502#, 16));
signal PLL3CFG_A: std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#18#, 8));
--
constant addr_PMU_CFG_3: std_logic_vector(15 downto 0):=std_logic_vector(to_unsigned(16#3024#,16));
signal PMU_CFG_3: std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#02#,8));
--
constant addr_PMU_CFG_7: std_logic_vector(15 downto 0):=std_logic_vector(to_unsigned(16#3028#,16));
signal PMU_CFG_7: std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#01#,8));
--
constant addr_MODE_SELECT: std_logic_vector(15 downto 0):=std_logic_vector(to_unsigned(16#0100#,16));
signal MODE_SELECT: std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#00#,8));
-- 
constant addr_OPFM_CNTR: std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(16#1014#,16));
signal OPFM_CNTR: std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#0F#,8));
--
constant enable_debug: std_logic := '1';
signal state_CLK: std_logic;
signal state_debug_internal: std_logic := '0';

component prescaler is
generic(
	constant input_frequency: natural; 		--input_frequency: input frequency in Hz
	constant output_frequency: natural 			--output_frequenct: output frequency in Hz
);
port(
	CLK_IN: in std_logic;
	CLK_OUT: out std_logic;
	shifted_CLK_OUT: out std_logic
);
end component;
begin

state_CLK <= debug_go_to_nx when enable_debug = '1' else
			slow_CLK;


prescaler_0_5s: prescaler
generic map(
	input_frequency => 27_000_000,
	output_frequency => 2 
)
port map(
	CLK_IN => CLK,
	CLK_OUT => slow_CLK,
	shifted_CLK_OUT => slow_CLK_shifted
);

pr_state_pr: process(state_CLK) is
begin
if rising_edge(state_CLK) then 
	pr_state <= nx_state; 
end if;
end process;

nx_state_pr: process(all) is
begin
case pr_state is
when idle_s =>
	if read_config = '1' then
		nx_state <= wait0_s;
	end if;
	state_debug_internal <= '0';
when wait0_s =>
	if finished_reg_op = '0' then
		nx_state <= set_number_frames_s;
	end if;
	state_debug_internal <= '1';
when set_number_frames_s =>
	if finished_reg_op = '1' then
		nx_state <= wait1_s;
	end if;
	state_debug_internal <= '0';when wait1_s =>
	if finished_reg_op = '0' then
		nx_state <= select_I2C_s;
	end if;when select_I2C_s =>
	if finished_reg_op = '1' then
		nx_state <= wait2_s;
	end if;when wait2_s =>
	if finished_reg_op = '0' then
		nx_state <= clock_gating_s;
	end if;when clock_gating_s =>
	if finished_reg_op = '1' then
		nx_state <= wait3_s;
	end if;
when wait3_s =>
	if finished_reg_op = '0' then
		nx_state <= PLL_predivider1_s;
	end if;when PLL_predivider1_s =>
	if finished_reg_op = '1' then
		nx_state <= wait4_s;
	end if;
when wait4_s =>
	if finished_reg_op = '0' then
		nx_state <= PLL_predivider2_s;
	end if;
when PLL_predivider2_s =>
	if finished_reg_op = '1' then
		nx_state <= wait5_s;
	end if;
when wait5_s =>
	if finished_reg_op = '0' then
		nx_state <= PLL_postdivider_s;
	end if;
when PLL_postdivider_s =>
	if finished_reg_op = '1' then
		nx_state <= cleanup_s;
	end if;
when cleanup_s =>
	if read_config = '1' then
		nx_state <= cleanup_s;
	else
		nx_state <= idle_s;
	end if;
end case;
end process;

output_pr: process(all) is
begin
case pr_state is
when idle_s =>
	start <= '0';
	addr <= (others => '0');
when wait0_s =>
	start <= '0';
	addr <= addr_PMU_CFG_7;
when set_number_frames_s =>
	if finished_reg_op = '1' then
		--start <= '0';
	else
		start <= '1';
	end if;
	addr <= addr_PMU_CFG_7;
when wait1_s =>
	start <= '0';
	addr <= addr_PMU_CFG_3;
when select_I2C_s =>
	if finished_reg_op = '1' then
		--start <= '0';
	else
		start <= '1';
	end if;
	addr <= addr_PMU_CFG_3;
when wait2_s =>
	start <= '0';
	addr <= addr_OPFM_CNTR;
when clock_gating_s =>
	if finished_reg_op = '1' then
		--start <= '0';
	else
		start <= '1';
	end if;
	addr <= addr_OPFM_CNTR;
when wait3_s =>
	start <= '0';
	addr <= PLL1CFG_A_addr;
when PLL_predivider1_s =>
	if finished_reg_op = '1' then
		--start <= '0';
	else
		start <= '1';
	end if;
	addr <= PLL1CFG_A_addr;
when wait4_s =>
	start <= '0';
	addr <= PLL3CFG_A_addr;
when PLL_predivider2_s =>
	if finished_reg_op = '1' then
		--start <= '0';
	else
		start <= '1';
	end if;
	addr <= PLL3CFG_A_addr;
when wait5_s =>
	start <= '0';
	addr <= PLL_POST_DIV_D_addr;
when PLL_postdivider_s =>
	if finished_reg_op = '1' then
		--start <= '0';
	else
		start <= '1';
	end if;
	addr <= PLL_POST_DIV_D_addr;
when cleanup_s =>
	start <= '0';
	addr <= (others => '0');
end case;
end process;



end Behavioral;