library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity I2C_module is
port(
CLK: in std_logic;
SDA: inout std_logic;
SCL: out std_logic;
init_conf: in std_logic; 
read_config: in std_logic;
trig_acq: in std_logic;
config_finished: out std_logic;		--config_finished	:this bit goes high when the configuration has been carried out successfully
trig_finished: out std_logic;		--trig_finished		:this bit goes high when the acquisition of a frama has been carried out successfully
data_read: out std_logic_vector(7 downto 0);
--
debug_forward: in std_logic;
state_read_config_debug: out std_logic
);
end I2C_module;

Architecture Behavioral of I2C_module is

type operation_t is (no_op, config_op, read_config_op, acq_op);
signal operation: operation_t := no_op; 

constant system_clock_F: natural := 27_000_000;
constant Two_Wire_F: natural := 1_000_000;
constant slave_ID: std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(16#24#, 7));

signal addr: std_logic_vector(15 downto 0);
signal data_write: std_logic_vector(7 downto 0);
signal start	: std_logic;
signal error		: std_logic;
signal error_debug	: std_logic;
signal buffer_debug: std_logic_vector(7 downto 0);

signal data_write_conf, data_write_acq: std_logic_vector(7 downto 0);
signal addr_conf, addr_acq: std_logic_vector(15 downto 0);
signal start_conf, start_acq: std_logic;
signal mul_sel: std_logic := '0';

signal finished_reg_op: std_logic;
signal R_W: std_logic:='0';
signal data_read_internal: std_logic_vector(7 downto 0);

signal start_read_conf: std_logic;
signal addr_read_conf: std_logic_vector(15 downto 0);



component HM0360_serial_master is
generic(
	constant system_clock_F: natural;
	constant Two_Wire_F: natural ;
	constant slave_ID: std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(16#24#, 7))
);
port(
	reset_n		: in std_logic;
	CLK			: in std_logic;
	SDA			: inout std_logic;
	SCL			: out std_logic;
	addr		: in std_logic_vector(15 downto 0);
	R_W			: in std_logic;
	data_write	: in std_logic_vector(7 downto 0);
	data_read	: out std_logic_vector(7 downto 0);
	start		: in std_logic;
	finished	: out std_logic;
	error		: out std_logic;
	error_debug	: out std_logic;
	buffer_debug: out std_logic_vector(7 downto 0)
);
end component;

component configuration_module is
port(
CLK				: in std_logic;
init_config		: in std_logic;
finished_reg_op	: in std_logic;
data_write		: out std_logic_vector(7 downto 0);
addr			: out std_logic_vector(15 downto 0);
start			: out std_logic;
config_finished	: out std_logic
);
end component;

component trig_acq_module is
port(
CLK	: in std_logic;
trig_acq: in std_logic;
finished_reg_op: in std_logic;
data_write: out std_logic_vector(7 downto 0);
addr		: out std_logic_vector(15 downto 0);
start		: out std_logic
);
end component;

component read_config_module is
port(
	CLK: in std_logic;
	read_config: in std_logic;
	finished_reg_op: in std_logic;
	addr: out std_logic_vector(15 downto 0); 
	start : out std_logic;
	debug_go_to_nx: in std_logic;
	state_debug: out std_logic
);
end component;


begin

HM0360_serial_master_comp: HM0360_serial_master
generic map(
	system_clock_F => system_clock_F,
	Two_Wire_F => Two_Wire_F,
	slave_ID => slave_ID
)
port map(
	reset_n	=> '1',
	CLK	=> CLK,
	SDA	=> SDA,
	SCL	=> SCL,
	addr => addr,
	R_W	=> R_W,
	data_write => data_write,
	data_read => data_read_internal,
	start => start,
	finished => finished_reg_op,
	error => error,
	error_debug	=> error_debug,
	buffer_debug => buffer_debug
);

trig_acq_module_comp: trig_acq_module
port map(
CLK => CLK,
trig_acq => trig_acq,
finished_reg_op => finished_reg_op,
data_write => data_write_acq,
addr => addr_acq,
start => start_acq
);

configuration_module_comp: configuration_module
port map(
CLK => CLK,
init_config => init_conf,
finished_reg_op => finished_reg_op, 
data_write => data_write_conf,
addr => addr_conf,
start => start_conf,
config_finished => config_finished
);

read_config_module_comp: read_config_module
port map(
	CLK => CLK,
	read_config => read_config,
	finished_reg_op => finished_reg_op,
	addr => addr_read_conf,
	start => start_read_conf,
	state_debug => state_read_config_debug,
	debug_go_to_nx => debug_forward
);


mux_I2C: process(all) is

begin

if init_conf = '1' then
	operation <= config_op;
elsif read_config = '1' then
	operation <= read_config_op;
elsif trig_acq = '1' then
	operation <= acq_op;
else --no_op
	
end if;
end process;

I2C_internal_driver: process(all) is  
begin
case operation is
when config_op =>
R_W <= '0';
addr <= addr_conf;
data_write <= data_write_conf;
start <= start_conf;
data_read <= (others => '0');
when read_config_op =>
R_W <= '1';
addr <= addr_read_conf;
data_write <= (others => '0');
start <= start_read_conf;
data_read <=  data_read_internal;
when acq_op =>
R_W <= '0';
addr <= addr_acq;
data_write <= data_write_acq;
start <= start_acq;
data_read <= (others => '0');
when others =>
addr <= (others => '0');
data_write <= (others => '0');
start <= '0';
data_read <= (others => '0');
end case;

end process;

end Behavioral;