#-- Lattice Semiconductor Corporation Ltd.
#-- Synplify OEM project file C:/Users/miche/Desktop/my_designs/HM0360_image_capture/HM0360_image_capture_impl/launch_synplify.tcl
#-- Written on Mon Nov 14 00:32:22 2022

project -close
set filename "C:/Users/miche/Desktop/my_designs/HM0360_image_capture/HM0360_image_capture_impl/HM0360_image_capture_impl_syn.prj"
project -new "$filename"
set create_new 1

#device options
set_option -technology LIFCL
set_option -part LIFCL_40
set_option -package CSBGA289C
set_option -speed_grade -8

if {$create_new == 1} {
	#-- add synthesis options
	#compilation/mapping options
	set_option -symbolic_fsm_compiler true
	set_option -resource_sharing true

	#use verilog standard option
	set_option -vlog_std v2001
	set_option -disable_io_insertion false

	#map options
	set_option -frequency 200
	set_option -maxfan 1000
	set_option -auto_constrain_io 0
	set_option -retiming false; set_option -pipe true
	set_option -force_gsr auto
	set_option -compiler_compatible 0
	
	
	set_option -default_enum_encoding default

	#timing analysis options
	
	

	#automatic place and route (vendor) options
	set_option -write_apr_constraint 1

	#synplifyPro options
	set_option -fix_gated_and_generated_clocks 0
	set_option -update_models_cp 0
	set_option -resolve_multiple_driver 0
	set_option -vhdl2008 1
	
	set_option -rw_check_on_ram 0
	set_option -seqshift_no_replicate 0
	
	#-- set any command lines input by customer
	
	set_option -dup false
}
#-- add_file options
add_file -verilog {C:/lscc/radiant/3.2/ip/pmi/pmi_lifcl.v}
add_file -vhdl -lib pmi {C:/lscc/radiant/3.2/ip/pmi/pmi_lifcl.vhd}
add_file -vhdl "C:/lscc/radiant/3.2/cae_library/synthesis/vhdl/lifcl.vhd"
add_file -vhdl -lib "work" "C:/Users/miche/Desktop/my_designs/HM0360_image_capture/source/HM0360_image_capture_impl/HM0360_Interface.vhd"
add_file -vhdl -lib "work" "C:/Users/miche/Desktop/my_designs/HM0360_image_capture/source/HM0360_image_capture_impl/counter.vhd"
add_file -vhdl -lib "work" "C:/Users/miche/Desktop/my_designs/HM0360_image_capture/source/HM0360_image_capture_impl/debounce.vhd"
add_file -vhdl -lib "work" "C:/Users/miche/Desktop/my_designs/HM0360_image_capture/source/HM0360_image_capture_impl/HM0360_serial_master.vhd"
add_file -vhdl -lib "work" "C:/Users/miche/Desktop/my_designs/HM0360_image_capture/source/HM0360_image_capture_impl/prescaler.vhd"
add_file -vhdl -lib "work" "C:/Users/miche/Desktop/my_designs/HM0360_image_capture/source/HM0360_image_capture_impl/I2C_module.vhd"
add_file -vhdl -lib "work" "C:/Users/miche/Desktop/my_designs/HM0360_image_capture/source/HM0360_image_capture_impl/configuration_module.vhd"
add_file -vhdl -lib "work" "C:/Users/miche/Desktop/my_designs/HM0360_image_capture/source/HM0360_image_capture_impl/trig_acq_module.vhd"
add_file -vhdl -lib "work" "C:/Users/miche/Desktop/my_designs/HM0360_image_capture/source/HM0360_image_capture_impl/HM0360_Interface_top_level.vhd"
add_file -vhdl -lib "work" "C:/Users/miche/Desktop/my_designs/HM0360_image_capture/source/HM0360_image_capture_impl/image_buffer.vhd"
#-- top module name
set_option -top_module {HM0360_Interface_top_level}
project -result_format "vm"
project -result_file {C:/Users/miche/Desktop/my_designs/HM0360_image_capture/HM0360_image_capture_impl/HM0360_image_capture_HM0360_image_capture_impl.vm}
project -save "$filename"
