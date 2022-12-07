onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB /debounce_2_tb/button
add wave -noupdate -group TB /debounce_2_tb/reset_n
add wave -noupdate -group TB /debounce_2_tb/button_deb
add wave -noupdate -group TB /debounce_2_tb/CLK
add wave -noupdate -group Debounce /debounce_2_tb/debounce_2_comp/clk
add wave -noupdate -group Debounce /debounce_2_tb/debounce_2_comp/reset_n
add wave -noupdate -group Debounce /debounce_2_tb/debounce_2_comp/button
add wave -noupdate -group Debounce /debounce_2_tb/debounce_2_comp/button_deb
add wave -noupdate -group Debounce /debounce_2_tb/debounce_2_comp/button_deb_internal
add wave -noupdate -group Debounce /debounce_2_tb/debounce_2_comp/flipflops
add wave -noupdate -group Debounce /debounce_2_tb/debounce_2_comp/counter_set
add wave -noupdate -group Debounce /debounce_2_tb/debounce_2_comp/count_value
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7016241 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 356
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
WaveRestoreZoom {0 ps} {63 us}
