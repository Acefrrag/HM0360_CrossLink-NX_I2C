onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider TB
add wave -noupdate /hm0360_interface_top_level_tb/CLK
add wave -noupdate /hm0360_interface_top_level_tb/data_out_debug
add wave -noupdate /hm0360_interface_top_level_tb/flag_debug_n
add wave -noupdate /hm0360_interface_top_level_tb/HM_CLK_SEL
add wave -noupdate /hm0360_interface_top_level_tb/HM_CN
add wave -noupdate /hm0360_interface_top_level_tb/HM_CP
add wave -noupdate /hm0360_interface_top_level_tb/HM_DN
add wave -noupdate /hm0360_interface_top_level_tb/HM_DP
add wave -noupdate /hm0360_interface_top_level_tb/HM_MCLK
add wave -noupdate /hm0360_interface_top_level_tb/HM_RTC
add wave -noupdate /hm0360_interface_top_level_tb/HM_SHUTDOWN_N
add wave -noupdate /hm0360_interface_top_level_tb/HM_SLEEP_N
add wave -noupdate /hm0360_interface_top_level_tb/init_config_button_n
add wave -noupdate /hm0360_interface_top_level_tb/Mode_select_clear
add wave -noupdate /hm0360_interface_top_level_tb/Mode_select_out
add wave -noupdate /hm0360_interface_top_level_tb/SCL
add wave -noupdate /hm0360_interface_top_level_tb/SDA
add wave -noupdate /hm0360_interface_top_level_tb/trig_acq_button_n
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {176970 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 fs} {1 ns}
