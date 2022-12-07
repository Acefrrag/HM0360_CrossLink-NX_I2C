onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Debounced Buttons}
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/init_config_deb
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/trig_acq_deb
add wave -noupdate -divider HM0360_Interface
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/CLK
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/SDA
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/SCL
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/init_config
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/trig_acq
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/PCLK
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/D
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/HM_HSYNC
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/HM_FSYNC
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/data_out
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/trig_finished
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/config_finished
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/PADDR_debug
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/data_out_debug
add wave -noupdate -divider Slave
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_device_comp/SDA
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_device_comp/SCL
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_device_comp/Mode_select_out
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_device_comp/Mode_select_clear
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_device_comp/pr_state
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_device_comp/nx_state
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_device_comp/reg_addr
add wave -noupdate -radix hexadecimal /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_device_comp/addr_PMU_CFG_3
add wave -noupdate -radix hexadecimal /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_device_comp/addr_PMU_CFG_7
add wave -noupdate -radix hexadecimal /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_device_comp/addr_MODE_SELECT
add wave -noupdate -radix hexadecimal /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_device_comp/addr_OPFM_CNTR
add wave -noupdate -radix binary /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_device_comp/PMU_CFG_3
add wave -noupdate -radix binary /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_device_comp/PMU_CFG_7
add wave -noupdate -radix binary /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_device_comp/MODE_SELECT
add wave -noupdate -radix binary /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_device_comp/OPFM_CNTR
add wave -noupdate -divider {Picture feeder logic}
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/enable_pic_source_logic_comp/Mode_select
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/enable_pic_source_logic_comp/Mode_select_clear
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/enable_pic_source_logic_comp/streamed
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/enable_pic_source_logic_comp/enable
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/enable_pic_source_logic_comp/streaming3_I2C
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/enable_pic_source_logic_comp/mode_select_reset
add wave -noupdate -divider {Pic Source}
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/pic_source_comp/PCLKO
add wave -noupdate -radix unsigned /hm0360_top_level_tb/HM0360_top_level_comp/pic_source_comp/D
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/pic_source_comp/enable
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/pic_source_comp/HSYNC
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/pic_source_comp/FSYNC
add wave -noupdate /hm0360_top_level_tb/HM0360_top_level_comp/pic_source_comp/streamed
add wave -noupdate -divider {Image Buffer}
add wave -noupdate -group {Image Buffer} -childformat {{/hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/image_buffer_comp/buffer_data(0) -radix unsigned} {/hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/image_buffer_comp/buffer_data(1) -radix unsigned}} -expand -subitemconfig {/hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/image_buffer_comp/buffer_data(0) {-radix unsigned} /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/image_buffer_comp/buffer_data(1) {-radix unsigned}} /hm0360_top_level_tb/HM0360_top_level_comp/HM0360_Interface_comp/image_buffer_comp/buffer_data
add wave -noupdate -group {Image Source} -expand -subitemconfig {/hm0360_top_level_tb/HM0360_top_level_comp/pic_source_comp/img(0) -expand} /hm0360_top_level_tb/HM0360_top_level_comp/pic_source_comp/img
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {25654108328 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 598
configure wave -valuecolwidth 144
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
WaveRestoreZoom {25651476151 ps} {25656563849 ps}
