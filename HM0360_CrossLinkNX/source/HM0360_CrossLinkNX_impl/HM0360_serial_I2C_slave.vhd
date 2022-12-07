library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity HM0360_serial_I2C_slave is
generic(
constant slave_ID: std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(16#24#,7))
);
port(
SDA: inout std_logic; 
SCL: in std_logic
);
end HM0360_serial_I2C_slave;

Architecture Behavioral of HM0360_serial_I2C_slave is
--FSM
type HM0360_device_FSM_state is (idle_s, ID_check_s, addr1_s, addr2_s, data_read_s, wait_ack_s, data_write_s, wait_stop_s);
signal pr_state, nx_state: HM0360_device_FSM_state := idle_s;
signal slave_ID_input, addr1, addr2: std_logic_vector(7 downto 0);
signal reg_addr: std_logic_vector(15 downto 0):=(others => '0');
signal data_out: std_logic_vector(7 downto 0):=(others => '0');
signal byte_received, byte_sent: std_logic:='0';			--byte_received: If a byte has been received an ACK signal must be send back to the master.
--PMU_CGF_3
signal PMU_CFG_3: std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(16#02#,8));
constant addr_PMU_CFG_3: std_logic_vector(15 downto 0):=std_logic_vector(to_unsigned(16#3024#,16));
signal device_buffer: std_logic_vector(7 downto 0) := (others => '0');
constant slave_ID_W: std_logic_vector(7 downto 0) := slave_ID & '0';
constant slave_ID_R: std_logic_vector(7 downto 0) := slave_ID & '1';
signal error: std_logic:='0';
signal R_W: std_logic:= '0';
begin
 

--FSM_prstate: process(SCL) is
--begin
--if SCL'event then
--	pr_state <= nx_state;
--end if;
--end process;


FSM_nxstate: process(all) is
variable c,p: integer := 0;

begin

case pr_state is
when idle_s =>
	SDA <= 'Z';
	if falling_edge(SCL)then
		if SDA = '0' then
			pr_state <= ID_check_s; --START CONDITION: If SDA is being low when SCL is pulled low
		end if;
	end if;
when ID_check_s =>
	--nx_state <= ID_check_s;
	if SCL = '1' and SDA'event then
		--nx_state <= addr1_s; --STOP CONDITION: SDA changes before the SDA has been clocked in the device (sampled)
	else
		if falling_edge(SCL) then 		--The bit is sampled at the falling edge of the clock
			if c < 8 then
				slave_ID_input(7-c) <= SDA;	--Sampling SDA
				c := c + 1;
			end if;
			if c = 8 then --8th bit has been sampled
				if slave_ID_input(7 downto 1) & SDA = slave_ID_W or slave_ID_input(7 downto 1) & SDA = slave_ID_R then
					SDA <= '0'; --ACK
					byte_received <= '1';
					error <= '0';
				else
					SDA <= '1'; --Error
					pr_state <= idle_s;
					error <= '1';
				end if;
			end if;
			if p = 8 then
				c := 0;
				p := 0;
				byte_received <= '0';
				if R_W = '1' then
					pr_state <= data_read_s;
					SDA <= data_out(7);
					c := 1;
					p := 1;
				else
					pr_state <= addr1_s;
					SDA <= 'Z'; -- The slave releases the SDA upon completion of the pulse from master
				end if;
			elsif p < 8 then
				p:=p+1;
			end if;
		end if;
	end if;
when addr1_s =>
	if SCL = '1' and SDA'event then
		--nx_state <= addr1_s; --STOP CONDITION: SDA changes before the SDA has been clocked in the device (sampled)
	else
		if falling_edge(SCL) then 		--The bit is sampled at the falling edge of the clock
			if c < 8 then
				addr1(7-c) <= SDA;	--Sampling SDA
				c := c + 1;
			end if;
			if c = 8 then --8th bit has been sampled
				SDA <= '0'; --ACK
				byte_received <= '1';
			--else
				--SDA <= '1'; --Error
				--nx_state <= idle_s;
			end if;
			if p = 8 then
				p := 0;
				c := 0;
				SDA <= 'Z';
				pr_state <= addr2_s;
				byte_received <= '0';
			elsif p < 8 then
				p := p + 1;
			end if;
		end if;
	end if;
when addr2_s => 
	if falling_edge(SCL) then
		if c < 8 then
			addr2(7-c) <= SDA;
			c := c + 1;
		end if;
		if c = 8 then
			byte_received <= '1';
			SDA <= '0';
		end if;
		if p = 8 then
			p := 0;
			SDA <= 'Z';
			R_W <= '0';
			c := 0;
			pr_state <= data_write_s;
			byte_received <= '0';
		elsif p < 8 then
			p:=p+1;
		end if;
	end if;
when data_write_s =>
	if c = 0 and SCL = '1' and SDA'event then
		--Read operation
		R_W <= '1';
		pr_state <= idle_s; --STOP CONDITION: SDA changes before the SDA has been clocked in the device (sampled)
		--nx_state <= addr1_s;
	end if;
	if c = 9 and SCL = '1' and SDA'event then --STOP CONDITION at end of writing operation
		pr_state <= idle_s;
		R_W <= '0';
	end if;
	if falling_edge(SCL) then
		if c < 8 then
			device_buffer(7-c) <= SDA;
			c := c + 1;
		end if;
		if c = 8 then
			byte_sent <= '1';
			SDA <= '0'; --ACK
			c := c +1;
		end if;
		if p = 8 then
			byte_sent <= '0';
			p := 0;
			SDA <= 'Z';
			c := 0;
			pr_state <= wait_stop_s;
			PMU_CFG_3 <= device_buffer;
		elsif p < 8 then
			p:=p+1;
		end if;
	end if;
when data_read_s =>
	--The SLAVE is sending data to master to be read.
	--The master had to release the SDA to high impedance. It released after the ACK was released.
	if falling_edge(SCL) then
		if c < 8 then
			SDA <= data_out(7-c);
			c := c + 1;
		end if;
		if c = 8 then --c = 8			
			
			--SDA <= 'Z';
		end if;
		if p = 8 then
			R_W <= '0';
			byte_sent <= '1';
			p := 0;
			c := 0;
			SDA <= 'Z';
			pr_state <= wait_ack_s;
		elsif p < 8 then
			p := p + 1;
		end if;
	end if;
when wait_ack_s =>
	if falling_edge(SCL) then
		byte_sent <= '0';
		if SDA = '0' then --sampling ACK
			pr_state <= wait_stop_s;
			error <= '0';
		else
			error <= '1';
		end if;
	end if;
when wait_stop_s =>
	if SCL = '1' and SDA'event then
		pr_state <= idle_s;--STOP CONDITION: SDA changes before the SDA has been clocked in the device (sampled)
	end if;
end case;
end process;


reg_addr <= addr1 & addr2;
data_gen: process(all) is 
begin
if reg_addr = addr_PMU_CFG_3 then
	data_out <= PMU_CFG_3;
end if;
end process;





end Behavioral;