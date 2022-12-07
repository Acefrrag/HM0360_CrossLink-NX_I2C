onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/CLK
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/data_out_debug
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/flag_debug_n
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/HM_CLK_SEL
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/HM_CN
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/HM_CP
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/HM_DN
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/HM_DP
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/HM_MCLK
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/HM_RTC
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/HM_SHUTDOWN_N
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/HM_SLEEP_N
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/init_config_button_n
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/Mode_select_clear
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/Mode_select_out
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/SCL
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/SDA
add wave -noupdate -expand -group TB /hm0360_interface_top_level_tb/trig_acq_button_n
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/CLK
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/SDA
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/SCL
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/init_config_button_n
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/init_config_button
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/trig_acq_button_n
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/trig_acq_button
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/init_config_deb
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/read_config
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/init_config
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/trig_acq_deb
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM_CP
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM_CN
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM_DP
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM_DN
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM_MCLK
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM_CLK_SEL
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM_RTC
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM_SHUTDOWN_N
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM_SLEEP_N
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/data_out_debug_n
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/flag_debug_n
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/data_out_debug
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/mux_data_out_debug
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/dt_o_debug
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/flag_debug
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/PADDR_debug
add wave -noupdate -group {Top level} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/choice_dout
add wave -noupdate -group init_config_command_gen -label CLK /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/gen_config_command_comp/CLK
add wave -noupdate -group init_config_command_gen -label init_config_seq /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/gen_config_command_comp/init_config_seq
add wave -noupdate -group init_config_command_gen -label read_config /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/gen_config_command_comp/read_config
add wave -noupdate -group init_config_command_gen -label init_config /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/gen_config_command_comp/init_config
add wave -noupdate -group init_config_command_gen -label slow_CLK /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/gen_config_command_comp/slow_CLK
add wave -noupdate -group init_config_command_gen -label slow_CLK_shifted /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/gen_config_command_comp/slow_CLK_shifted
add wave -noupdate -group init_config_command_gen -label c /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/gen_config_command_comp/c
add wave -noupdate -group init_config_command_gen -label reset_c /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/gen_config_command_comp/reset_c
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/CLK
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/SDA
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/SCL
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/init_conf
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/read_config
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/trig_acq
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/config_finished
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/trig_finished
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/data_read
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/operation
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/addr
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/data_write
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/start
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/error
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/error_debug
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/buffer_debug
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/data_write_conf
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/data_write_acq
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/addr_conf
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/addr_acq
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/start_conf
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/start_acq
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/mul_sel
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/finished_reg_op
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/R_W
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/data_read_internal
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/start_read_conf
add wave -noupdate -group I2C_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/addr_read_conf
add wave -noupdate -group configuration_module -label CLK /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/configuration_module_comp/CLK
add wave -noupdate -group configuration_module -label init_config /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/configuration_module_comp/init_config
add wave -noupdate -group configuration_module -label finished_ref_op /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/configuration_module_comp/finished_reg_op
add wave -noupdate -group configuration_module -label data_wrte /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/configuration_module_comp/data_write
add wave -noupdate -group configuration_module -label addr /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/configuration_module_comp/addr
add wave -noupdate -group configuration_module -label start /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/configuration_module_comp/start
add wave -noupdate -group configuration_module -label config_finished /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/configuration_module_comp/config_finished
add wave -noupdate -group configuration_module -label pr_state /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/configuration_module_comp/pr_state
add wave -noupdate -group configuration_module -label nx_state /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/configuration_module_comp/nx_state
add wave -noupdate -group configuration_module -label config_finished_internal /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/configuration_module_comp/config_finished_internal
add wave -noupdate -group read_configuration_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/read_config_module_comp/CLK
add wave -noupdate -group read_configuration_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/read_config_module_comp/read_config
add wave -noupdate -group read_configuration_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/read_config_module_comp/finished_reg_op
add wave -noupdate -group read_configuration_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/read_config_module_comp/addr
add wave -noupdate -group read_configuration_module -label start /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/read_config_module_comp/start
add wave -noupdate -group read_configuration_module -label pr_state /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/read_config_module_comp/pr_state
add wave -noupdate -group read_configuration_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/read_config_module_comp/nx_state
add wave -noupdate -group read_configuration_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/read_config_module_comp/slow_CLK
add wave -noupdate -group read_configuration_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/read_config_module_comp/slow_CLK_shifted
add wave -noupdate -group read_configuration_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/read_config_module_comp/PLL_POST_DIV_D
add wave -noupdate -group read_configuration_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/read_config_module_comp/PLL1CFG_A
add wave -noupdate -group read_configuration_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/read_config_module_comp/PLL3CFG_A
add wave -noupdate -group read_configuration_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/read_config_module_comp/PMU_CFG_3
add wave -noupdate -group read_configuration_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/read_config_module_comp/PMU_CFG_7
add wave -noupdate -group read_configuration_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/read_config_module_comp/MODE_SELECT
add wave -noupdate -group read_configuration_module /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/read_config_module_comp/OPFM_CNTR
add wave -noupdate -group device_slave -label SDA /hm0360_interface_top_level_tb/HM0360_device_comp/SDA
add wave -noupdate -group device_slave -label SCL /hm0360_interface_top_level_tb/HM0360_device_comp/SCL
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/Mode_select_out
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/Mode_select_clear
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/pr_state
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/nx_state
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/slave_ID_input
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/addr1
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/addr2
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/reg_addr
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/data_out
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/byte_received
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/byte_sent
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/PMU_CFG_3
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/PMU_CFG_7
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/MODE_SELECT
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/OPFM_CNTR
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/PLL_POST_DIV_D
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/PLL1CFG_A
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/PLL3CFG_A
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/device_buffer
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/error
add wave -noupdate -group device_slave /hm0360_interface_top_level_tb/HM0360_device_comp/R_W
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/reset_n
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/CLK
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/SDA
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/SCL
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/addr
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/R_W
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/data_write
add wave -noupdate -group {Serial Master} -radix hexadecimal /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/data_read
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/start
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/finished
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/error
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/error_debug
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/buffer_debug
add wave -noupdate -group {Serial Master} -label data_read -radix hexadecimal /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/data_read_internal
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/pr_state
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/DATA_CLK
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/DATA_CLK_pr
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/SCL_pr
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/SDA_pr
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/R_W_internal
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/rd_flag
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/SCL_CLK
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/error_debug_internal
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/buffer_debug_internal
add wave -noupdate -group {Serial Master} /hm0360_interface_top_level_tb/HM0360_Interface_top_level_comp/HM0360_Interface_comp/I2C_module_comp/HM0360_serial_master_comp/finished_internal
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 4} {0 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 818
configure wave -valuecolwidth 112
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 fs} {662901750 ps}
