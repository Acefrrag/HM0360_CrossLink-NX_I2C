library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity HM0360_Interface is
port(
--
CLK: in std_logic;						--CLK
SDA: inout std_logic;					--SDA
SCL: out std_logic;						--SCL
--
init_config: in std_logic;				--init_config
read_config: in std_logic;				--read_config
trig_acq: in std_logic;					--trig_acq
--
HM_CP: inout std_logic;						--HM_CP
HM_CN: inout std_logic;						--HM_CN
HM_DP: inout std_logic_vector(0 downto 0);	--HM_DP
HM_DN: inout std_logic_vector(0 downto 0);	--HM_DN
--
HM_MCLK: out std_logic;					--HM_MCLK
HM_CLK_SEL: out std_logic;				--HM_CLK_SEL
HM_RTC: out std_logic;					--HM_RTC
HM_SHUTDOWN_N: out std_logic;			--HM_SHUTDOWN
HM_SLEEP_N: out std_logic;				--HM_SLEEP_N
--debug
debug_forward: in std_logic;							--debug_forward		: Used to step forward when interfacing with the sensor. For Degugging
PADDR_debug: in std_logic_vector(3 downto 0);		--PADDR				: Address to select one of the pixel temporarily sotred within the buffer		
data_out_debug: out std_logic_vector(7 downto 0);	--data_out_debug	: one of the pixels stored 
dt_o_debug: out std_logic_vector(5 downto 0);		--dt_o_debug		: data type from CSI-2 DPHY packet header
config_finished: out std_logic;							--flag_debug		: flag debug to check progress in the configuration, acquisition of data.
state_read_config_debug: out std_logic
);
end HM0360_Interface;

Architecture Behavioral of HM0360_Interface is

signal data_out: std_logic_vector(7 downto 0); 
signal trig_finished: std_logic; 
--CSI2_DPHY signals 
signal sync_clk_i: std_logic; 
signal sync_rst_i: std_logic; 
signal clk_byte_o : std_logic; 
signal clk_byte_hs_o : std_logic; 
signal clk_byte_fr_i : std_logic; 
signal bd_o : std_logic_vector(7 downto 0); 
signal payload_en_o : std_logic; 
signal payload_o : std_logic_vector(7 downto 0); 
signal dt_o : std_logic_vector (5 downto 0); 
signal vc_o : std_logic_vector (1 downto 0); 
signal wc_o : std_logic_vector(15 downto 0); 
signal ecc_o : std_logic_vector(7 downto 0); 
constant ref_dt_i : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(16#24#,6)); --DATA_TYPE RGB888
signal sp_en_o : std_logic; 
signal lp_en_o : std_logic; 
signal lp_av_en_o : std_logic; 
--Dump Signals.
signal clk_byte_fr_i_shifted: std_logic;
constant ref_dt_code: std_logic_vector(5 downto 0) := (others => '0');
constant tx_rdy_i: std_logic := '1';
constant pd_dphy_i: std_logic := '0';
signal ready_o: std_logic;
signal hs_sync_o: std_logic;
signal data_read: std_logic_vector(7 downto 0);

 
component I2C_module is
--This module is responsible for configuration and acqusition command to the device.
port(
CLK: in std_logic;
init_conf: in std_logic;
read_config: in std_logic;
trig_acq: in std_logic;
SDA: inout std_logic;
SCL: out std_logic;
debug_forward: in std_logic;
config_finished: out std_logic;
trig_finished: out std_logic;
data_read: out std_logic_vector(7 downto 0);
state_read_config_debug: out std_logic
);
end component;

component prescaler is
--Clock divider module used to generate a 6Mhz clock
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


component image_buffer is
--This is a buffer used to store some pixels
port(
en_sample: in std_logic;
PCLK: in std_logic;
PADDR: in std_logic_vector(3 downto 0);
D: in std_logic_vector(7 downto 0);
data_out: out std_logic_vector(7 downto 0)
);
end component;

component PLL_sync_clk is
--This creates the "sync_clk_i" 60 MHz used by the CSI2_SPHY module
port(
	clki_i: in std_logic;
	clkop_o: out std_logic
);
end component;

--component HM0360_CSI2_DPHY is
----This is THE IP module generated I am trying to interface with
--port(
    --sync_clk_i: in std_logic; 
    --sync_rst_i :in std_logic; 
    --clk_byte_o :out std_logic; 
    --clk_byte_hs_o :out std_logic; 
    --clk_lp_ctrl_i :in std_logic; 
    --clk_byte_fr_i :in std_logic; 
    --reset_n_i :in std_logic; 
    --reset_lp_n_i :in std_logic; 
    --reset_byte_n_i :in std_logic; 
    --reset_byte_fr_n_i :in std_logic; 
    --clk_p_io: inout std_logic; 
    --clk_n_io: inout std_logic; 
    --d_p_io: inout std_logic_vector(0 downto 0); 
    --d_n_io: inout std_logic_vector(0 downto 0); 
    --bd_o : out std_logic_vector(7 downto 0); 
    --payload_en_o :out std_logic; 
    --payload_o :out std_logic_vector(7 downto 0); 
    --dt_o :out std_logic_vector (5 downto 0); 
    --vc_o :out std_logic_vector (1 downto 0); 
    --wc_o :out std_logic_vector(15 downto 0); 
    --ecc_o :out std_logic_vector(7 downto 0); 
    --ref_dt_i :in std_logic_vector(5 downto 0);
    --tx_rdy_i :in std_logic; 
    --sp_en_o :out std_logic; 
    --lp_en_o :out std_logic; 
    --lp_av_en_o :out std_logic;
	--ready_o: out std_logic;
	--hs_sync_o: out std_logic;
	--lp_d_rx_p_o: out std_logic;
    --lp_d_rx_n_o: out std_logic
--);
--end component;


begin

--Setup Wiring
HM_MCLK <= '0';	--To disable internal oscillator
HM_RTC <= '0'; 	--Must not be left floating
HM_CLK_SEL <= '0'; --Clock Selection Bit '0': Internal
HM_SHUTDOWN_N <= '1'; --HM Shutdown Active Low
HM_SLEEP_N <= '1'; --Sleep Mode bit Active Low
--MIPI Wiring Setup
sync_rst_i <= '0'; 
--Debug signals
data_out_debug <= data_read;


prescaler_6MHz: prescaler --6MHz generator
generic map(
	input_frequency => 27_000_000, 		--input_frequency: input frequency in Hz
	output_frequency => 6_000_000		--output_frequenct: output frequency in Hz
)
port map(
	CLK_IN => CLK,
	CLK_OUT => clk_byte_fr_i,
	shifted_CLK_OUT => clk_byte_fr_i_shifted
);

PLL_sync_clk_comp: PLL_sync_clk --60 Mhz generator
port map(
	clki_i => CLK,
	clkop_o => sync_clk_i
);

--HM0360_CSI2_DPHY_comp: HM0360_CSI2_DPHY
--port map(
    --sync_clk_i => sync_clk_i,--X
    --sync_rst_i => sync_rst_i, --X
    --clk_byte_o => clk_byte_o, --X
    --clk_byte_hs_o => clk_byte_hs_o , --X
    --clk_lp_ctrl_i => clk_byte_fr_i, ----X Same as clk_byte_fr_i
    --clk_byte_fr_i => clk_byte_fr_i, ---X
    --reset_n_i => '1',  --X
    --reset_lp_n_i => '1', --X
    --reset_byte_n_i => '1', --X
    --reset_byte_fr_n_i => '1', --X
    --clk_p_io => HM_CP, --X
    --clk_n_io => HM_CN, --X
    --d_p_io => HM_DP,--d_p_io, --X
    --d_n_io => HM_DN,--d_n_io, --X
    --bd_o => bd_o, 
    --payload_en_o => payload_en_o, --X
    --payload_o => payload_o, --X
    --dt_o => dt_o, --X
    --vc_o => vc_o,  --X
    --wc_o => wc_o, --X
    --ecc_o => ecc_o,  --X
    --ref_dt_i => ref_dt_i, --X
    --tx_rdy_i => tx_rdy_i, --X
    --sp_en_o => sp_en_o, --X
    --lp_en_o => lp_en_o, --X
    --lp_av_en_o => lp_av_en_o --X
--);

--prescaler_flag_debug: prescaler
--generic map(
	--input_frequency => 27_000_000, 		--input_frequency: input frequency in Hz
	--output_frequency => 2		--output_frequenct: output frequency in Hz
--)
--port map(
	--CLK_IN => CLK,
	--CLK_OUT => clk_byte_fr_i,
	--shifted_CLK_OUT => clk_byte_fr_i_shifted
--);


I2C_module_comp: I2C_module
port map(
CLK => CLK,
init_conf => init_config,
trig_acq => trig_acq,
read_config => read_config,
SDA => SDA,
SCL => SCL,
config_finished => config_finished,
trig_finished => trig_finished,
data_read => data_read,
state_read_config_debug => state_read_config_debug,
debug_forward => debug_forward
);
image_buffer_comp: image_buffer
port map(
PCLK => clk_byte_o,
en_sample => payload_en_o,
PADDR => PADDR_debug,
D => payload_o,
data_out => data_out
);


dt_o_debug_pr: process(CLK) is

begin
if rising_edge(CLK) then
if payload_en_o = '1' then
	dt_o_debug <= dt_o;
end if;
end if;

end process;





end Behavioral;