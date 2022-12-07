library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HM0360_serial_I2C_master is 
generic(
	constant system_clock_F : natural := 27_000_000;											--system_clock_F: This is the frequency of the system clock (natural number)
	constant I2C_clock_F: natural := 500_000;													--I2C_clock_F	: This is the SCL frequency
	constant slave_ID: std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(16#24#, 7))	--slave_ID		: slave address to which the operation will be sent out
);
port(
	reset_n		: in std_logic;						--reset_n		: It resets the communication
	CLK			: in std_logic;						--CLK			: System clock
	SDA			: inout std_logic;					--SDA			: SDA (Serial Data) signal
	SCL			: out std_logic;					--SCL			: SCL 
	addr		: in std_logic_vector(15 downto 0);	--addr			: Address to the register to write into/read from
	R_W			: in std_logic;						--R_W			: Read/Write signal. '0' Write Operation is selected. '1' Read Operation is selected
	data_write	: in std_logic_vector(7 downto 0);	--data_write	: Byte to write
	data_read	: out std_logic_vector(7 downto 0);	--data_read		: Byte read from the register 
	start		: in std_logic;						--start			: Start bit to trigger the transaction
	finished	: out std_logic;					--finished		: Finsihed bit to Ackoneledge the desired transaction has been successfully terminated
	--Debug
	error_debug	: out std_logic;
	buffer_debug: out std_logic_vector(7 downto 0)
);
end HM0360_serial_I2C_master;


Architecture Behavioral of HM0360_serial_I2C_master is

type HM0360_FSM_state is (idle_s, start_s, ID_check_s, wait_ack0_s, addr1_s, wait_ack1_s, addr2_s, wait_ack2_s, give_stop_s, give_ack_s, data_read_s, data_write_s, wait_ack3_s, idle_cleanup_s);
signal data_read_internal: std_logic_vector(7 downto 0) := (others => '0');
signal pr_state: HM0360_FSM_state := idle_s;
signal DATA_CLK, DATA_CLK_pr: std_logic := '0';
signal SCL_pr: std_logic := '0';
signal SDA_pr: std_logic := 'Z';
signal R_W_internal: std_logic:='0';
signal rd_flag: std_logic := '0';
signal SCL_CLK: std_logic := '0';
signal error_debug_internal: std_logic := '0';
signal buffer_debug_internal: std_logic_vector(7 downto 0):=(others => '0');
signal retry_transaction: std_logic := '0';	--retru_transaction: This signal is used to repeat a transaction if the previous transaction was not successfull(NO ACK bit received)
signal error: std_logic;
component prescaler is
generic(
	constant input_frequency: natural; 		--input_frequency: input frequency in Hz
	constant output_frequency: natural 		--output_frequenct: output frequency in Hz
);
port(
	CLK_IN: in std_logic;
	CLK_OUT: out std_logic;
	shifted_CLK_OUT: out std_logic
);
end component;

begin

SCL <= SCL_CLK;
data_read <= data_read_internal;
error_debug <= retry_transaction;
buffer_debug <= buffer_debug_internal;

prescaler_comp: prescaler
generic map(
	input_frequency => system_clock_F,
	output_frequency => I2C_clock_F
)
port map(
	CLK_IN => CLK,
	CLK_OUT => SCL_CLK,
	shifted_CLK_OUT => DATA_CLK
);

CLK_prev_pr: process(CLK) is
begin
if rising_edge(CLK) then
	DATA_CLK_pr <=  DATA_CLK;
	SCL_pr <= SCL_CLK;
	SDA_pr <= SDA;
end if;
end process;

FSM_process: process(CLK, reset_n) is
variable c: natural := 0;
variable c_debug: natural := 0;
begin
	if reset_n = '0' then
		pr_state <= idle_s;
		finished <= '0';
		c := 0;
		SDA <= '1';
		rd_flag <= '0';
	--idle_s, start_s, ID_check_s, wait_ack0_s, addr1_s, wait_ack1_s, addr2_s, wait_ack2_s,
	--give_stop_s, give_ack_s, data_read_s, data_write_s, wait_ack3_s);
	elsif rising_edge(CLK) then
		if DATA_CLK = '1' and DATA_CLK_pr = '0' then 	-- rising_edge DATA_CLK
			case pr_state is
			when idle_s =>
				R_W_internal <= R_W;
			when start_s =>
			when ID_check_s =>
				if c < 7 then
					SDA <= slave_ID(6-c);
				elsif c = 7 then
					SDA <= rd_flag; 
				end if;
				c := c + 1;
			when wait_ack0_s => 
			when addr1_s =>
				if c < 8 then
					SDA <= addr(15-c);
					c := c + 1;
				end if;
			when wait_ack1_s =>
			when addr2_s =>
				if c < 8 then
					SDA <= addr(7-c);
					c := c + 1;
				end if;
			when wait_ack2_s =>
			when give_stop_s =>
			when give_ack_s =>
				SDA <= '0';
			when data_read_s => 
			when data_write_s =>
				if c < 8 then
					SDA <= data_write(7-c);
					c := c + 1;
				end if;
			when wait_ack3_s =>
			when idle_cleanup_s =>
			end case;
		elsif DATA_CLK = '0' and DATA_CLK_pr = '1' then -- falling edge DATA_CLK
			case pr_state is
			when idle_s =>
				if start = '1' or rd_flag = '1' or retry_transaction = '1' then
					finished <= '0';
					pr_state <= start_s;
					SDA <= '0';
					retry_transaction <= '0';
				else
					pr_state <= idle_s;
				end if;
			when start_s =>
			when ID_check_s =>
				--buffer_debug(7-c_debug) <= SDA;
				--c_debug := c_debug + 1;
				--if c_debug = 8 then
				--	c_debug := 0;
				--end if;
			when wait_ack0_s => 
			when addr1_s =>
				--buffer_debug_internal(7-c_debug) <= SDA;
				--c_debug := c_debug + 1;
				--if c_debug = 8 then
				--	c_debug := 0;
				--end if;
			when wait_ack1_s =>
			when addr2_s =>
				buffer_debug_internal(7-c_debug) <= SDA;
				c_debug := c_debug + 1;
				if c_debug = 8 then
					c_debug := 0;
				end if;
			when wait_ack2_s =>
			when give_stop_s =>
				SDA <= '1';--STOP CONDITION
				finished <= '0';
				if R_W_internal = '1' then
					rd_flag <= '1';
					pr_state <= idle_s;
				else
					rd_flag <= '0';
					pr_state <= idle_cleanup_s; --cycle if start button is still pressed
				end if;
			when give_ack_s =>
			when data_read_s =>
			when data_write_s =>
			when wait_ack3_s =>
			when idle_cleanup_s =>
				if start = '1' then
					pr_state <= idle_cleanup_s;
				else
					pr_state <= idle_s;
				end if;
			end case;
		elsif SCL_pr ='1' and SCL_CLK = '0' then 				--falling edge SCL
			case pr_state is
			when idle_s =>
			when start_s =>
				pr_state <= ID_check_s;
			when ID_check_s =>
				if c = 8 then
					c := 0;
					SDA <= 'Z';
					pr_state <= wait_ack0_s;
				end if;
			when wait_ack0_s =>
				if SDA_pr = '0' then --sampling ACK
					if rd_flag = '1' then
						pr_state <= data_read_s;
						rd_flag <= '0';
					else 
						pr_state <= addr1_s;
					end if;
					error <= '0';
				else
					error <= '1';
					error_debug_internal <= '1'; -- This goes high during a read operation
					--if rd_flag = '0' then --If I put this We read all ones from the the register(maybe because SDA stays high
					--	error_debug_internal <= '1';
					--end if;
					--error_debug_internal <= '1' when rd_flag = '0'; --Also this produces the same
					--Under a NOT ACK condition the slave must give a stop condition
					--The same transaction will be repeated.
					pr_state <= give_stop_s;
					R_W_internal <= '0';
					retry_transaction <= '1';
				end if;
			when addr1_s =>
				if c = 8 then
					SDA <= 'Z'; --master has to release SDA
					c := 0;
					pr_state <= wait_ack1_s; --master will now wait for ack
				end if;
			when wait_ack1_s =>
				if SDA_pr = '0' then --sampling ACK
					pr_state <= addr2_s;
					error <= '0';
				else
					error <= '1';
					pr_state <= give_stop_s;
					R_W_internal <= '0';
					retry_transaction <= '1';
				end if;
			when addr2_s =>
				if c = 8 then
					SDA <= 'Z'; --master has to release SDA
					c := 0;
					pr_state <= wait_ack2_s; --master will now wait for ack
				end if;
			when wait_ack2_s =>
				if SDA_pr = '0' then --sampling ACK, also the slave will release the SDA at the very same time
					--SDA <= '1'; --The SDA is now driven back from the master
					error <= '0';
					if R_W_internal = '1' then
						SDA <= '0'; --getting ready to give a stop condition
						pr_state <= give_stop_s;
					else --R_W = '0'
						pr_state <= data_write_s;
					end if;
				else
					error <= '1';
					pr_state <= give_stop_s;
					R_W_internal <= '0';
					retry_transaction <= '1';
				end if;
			when give_stop_s =>
			when give_ack_s =>
				R_W_internal <= '0';
				pr_state <= give_stop_s;
				finished <= '1';
			when data_read_s =>
				if c < 8 then
					data_read_internal(7-c) <= SDA_pr;
					c := c + 1;
				end if;
				if c = 8 then
						--The slave released SDA as soon as it has been sampled which is now driven by the master by setting it to high
						pr_state <= give_ack_s;
						c := 0;
						SDA <= '1';
				end if;
			when data_write_s =>
				if c = 8 then
					SDA <= 'Z'; --master has to release SDA
					c := 0;
					pr_state <= wait_ack3_s; --master will now wait for ack
				end if;
			when wait_ack3_s =>
				if SDA_pr = '0' then --sampling ACK, also the slave will release the SDA at the very same time
					finished <= '1';
					SDA <= '0'; --The SDA is now driven back from the master
					error <= '0';
					pr_state <= give_stop_s;
				else
					error <= '1';
					pr_state <= give_stop_s;
					R_W_internal <= '0';
					retry_transaction <= '1';
				end if;
			when idle_cleanup_s =>
			end case;
		elsif SCL_pr = '0' and SCL_CLK = '1' then 				--rising edge SCL
			case pr_state is
			when idle_s =>
				SDA <= '1';
			when start_s =>
				SDA <= '0';
			when ID_check_s =>
			when wait_ack0_s => 
			when addr1_s =>
			when wait_ack1_s =>
			when addr2_s =>
			when wait_ack2_s =>
			when give_stop_s =>
			when give_ack_s =>
			when data_read_s =>
			when data_write_s =>
			when wait_ack3_s =>
			when idle_cleanup_s =>
			end case;
		end if;
	end if;
end process;
	


end Behavioral;