lappend auto_path "C:/lscc/radiant/3.2/scripts/tcl/simulation"
package require simulation_generation
set ::bali::simulation::Para(DEVICEPM) {je5d00}
set ::bali::simulation::Para(DEVICEFAMILYNAME) {LIFCL}
set ::bali::simulation::Para(PROJECT) {HM0360_image_capture}
set ::bali::simulation::Para(PROJECTPATH) {C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture}
set ::bali::simulation::Para(FILELIST) {"C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/HM0360_CSI2_DPHY/rtl/HM0360_CSI2_DPHY.v" "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/source/HM0360_image_capture_impl/debounce.vhd" "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/source/HM0360_image_capture_impl/enable_pic_source_logic.vhd" "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/source/HM0360_image_capture_impl/image_buffer.vhd" "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/source/HM0360_image_capture_impl/counter.vhd" "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/source/HM0360_image_capture_impl/prescaler.vhd" "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/source/HM0360_image_capture_impl/read_config_module.vhd" "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/source/HM0360_image_capture_impl/configuration_module.vhd" "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/source/HM0360_image_capture_impl/trig_acq_module.vhd" "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/source/HM0360_image_capture_impl/HM0360_serial_master.vhd" "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/source/HM0360_image_capture_impl/I2C_module.vhd" "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/PLL_sync_clk/rtl/PLL_sync_clk.v" "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/source/HM0360_image_capture_impl/HM0360_Interface.vhd" "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/source/HM0360_image_capture_impl/debounce_2.vhd" "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/source/HM0360_image_capture_impl/gen_config_command.vhd" "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/source/HM0360_image_capture_impl/HM0360_Interface_top_level.vhd" "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/source/HM0360_image_capture_impl/HM0360_device.vhd" "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/source/HM0360_image_capture_impl/HM0360_Interface_top_level_tb.vhd" }
set ::bali::simulation::Para(GLBINCLIST) {}
set ::bali::simulation::Para(INCLIST) {"none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none"}
set ::bali::simulation::Para(WORKLIBLIST) {"work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" }
set ::bali::simulation::Para(COMPLIST) {"VERILOG" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VERILOG" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" "VHDL" }
set ::bali::simulation::Para(LANGSTDLIST) {"" "VHDL_2008" "VHDL_2008" "VHDL_2008" "VHDL_2008" "VHDL_2008" "VHDL_2008" "VHDL_2008" "VHDL_2008" "VHDL_2008" "VHDL_2008" "" "VHDL_2008" "VHDL_2008" "VHDL_2008" "VHDL_2008" "VHDL_2008" "VHDL_2008" }
set ::bali::simulation::Para(SIMLIBLIST) {pmi_work ovi_lifcl}
set ::bali::simulation::Para(MACROLIST) {}
set ::bali::simulation::Para(SIMULATIONTOPMODULE) {HM0360_Interface_top_level_tb}
set ::bali::simulation::Para(SIMULATIONINSTANCE) {}
set ::bali::simulation::Para(LANGUAGE) {VHDL}
set ::bali::simulation::Para(SDFPATH)  {}
set ::bali::simulation::Para(INSTALLATIONPATH) {C:/lscc/radiant/3.2}
set ::bali::simulation::Para(MEMPATH) {C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/HM0360_CSI2_DPHY;C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/PLL_sync_clk}
set ::bali::simulation::Para(UDOLIST) {}
set ::bali::simulation::Para(ADDTOPLEVELSIGNALSTOWAVEFORM)  {1}
set ::bali::simulation::Para(RUNSIMULATION)  {1}
set ::bali::simulation::Para(SIMULATIONTIME)  {100}
set ::bali::simulation::Para(SIMULATIONTIMEUNIT)  {ns}
set ::bali::simulation::Para(ISRTL)  {1}
set ::bali::simulation::Para(HDLPARAMETERS) {}
::bali::simulation::ModelSim_Run
