library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HM0360_serial_tb is
--port
end HM0360_serial_tb;

Architecture Behavioral of HM0360_serial_tb is

signal CLK, finished: std_logic:='0';
signal R_W: std_logic:='1';
signal SDA: std_logic := '1';
signal SCL: std_logic := '0';
signal start: std_logic := '1';
signal data_write, data_read: std_logic_vector(7 downto 0):=(others => '0');
signal addr: std_logic_vector(15 downto 0) := (others => '0');
signal reset_n: std_logic := '1';



component HM0360_serial_master is
generic(
	constant system_clock_F : natural;
	constant Two_Wire_F: natural;
	constant slave_ID: std_logic_vector(6 downto 0)
);
port(
	reset_n		:in std_logic;
	CLK			: in std_logic;
	SDA			: inout std_logic;
	SCL			: out std_logic;
	addr		: in std_logic_vector(15 downto 0);
	R_W			: in std_logic;
	data_write	: in std_logic_vector(7 downto 0);
	data_read	: out std_logic_vector(7 downto 0);
	start: in std_logic;
	finished: out std_logic
);
end component;

component HM0360_device is
generic(
constant slave_ID: std_logic_vector(6 downto 0)
);
port(
SDA: inout std_logic;
SCL: in std_logic
);
end component;

begin

reset_n <= '1';

HM0360_device_comp: HM0360_device
generic map(
slave_ID => std_logic_vector(to_unsigned(16#24#,7))
)
port map(
SDA => SDA,
SCL => SCL
);


HM0360_serial_master_comp: HM0360_serial_master
generic map(
	system_clock_F => 27_000_000,
	Two_Wire_F => 100_000,
	slave_ID => std_logic_vector(to_unsigned(16#24#,7))
)
port map(
	reset_n => reset_n,
	CLK	=> CLK,
	SDA	=> SDA,
	SCL	=> SCL,
	addr => addr,
	R_W	 => R_W,
	data_write => data_write,
	data_read => data_read,
	start => start,
	finished => finished
);

sys_clk_gen1: process is
begin
wait for 37 ns;
CLK <= not(CLK);
end process;

addr <= std_logic_vector(to_unsigned(16#0324#,16));

read_write_gen: process is
begin
wait for 100_000 ns;
R_W <= '0';
wait for 2_030_000 ns;
R_W <= '1';
--wait for 100_000 ns;
--R_W <= '0';
wait;
end process;

start_gen: process is
begin
wait for 20_000 ns;--wait for two SCL cycles
start <= '1';
wait for 60_000 ns;
start <= '0';
wait for 1_000_000 ns;
start <= '1';
wait for 60_000 ns;
start <= '0';
wait for 1_000_000 ns;
start <= '1';
wait for 60_000 ns;
start <= '0';
wait;
end process;

addr_gen: process is
begin
wait for 1_080_000 ns;
data_write <= std_logic_vector(to_unsigned(16#11#,8));
wait;
end process;



end Behavioral;