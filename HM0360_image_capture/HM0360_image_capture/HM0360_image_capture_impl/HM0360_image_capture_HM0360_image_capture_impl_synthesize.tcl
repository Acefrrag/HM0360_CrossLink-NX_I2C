if {[catch {

# define run engine funtion
source [file join {C:/lscc/radiant/3.2} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) 1
set para(prj_dir) "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture"
# synthesize IPs
# synthesize VMs
# propgate constraints
file delete -force -- HM0360_image_capture_HM0360_image_capture_impl_cpe.ldc
run_engine_newmsg cpe -f "HM0360_image_capture_HM0360_image_capture_impl.cprj" "HM0360_CSI2_DPHY.cprj" "PLL_sync_clk.cprj" -a "LIFCL"  -o HM0360_image_capture_HM0360_image_capture_impl_cpe.ldc
# synthesize top design
file delete -force -- HM0360_image_capture_HM0360_image_capture_impl.vm HM0360_image_capture_HM0360_image_capture_impl.ldc
run_engine_newmsg synthesis -f "HM0360_image_capture_HM0360_image_capture_impl_lattice.synproj"
run_postsyn [list -a LIFCL -p LIFCL-40 -t CSBGA289 -sp 8_High-Performance_1.0V -oc Commercial -top -w -o HM0360_image_capture_HM0360_image_capture_impl_syn.udb HM0360_image_capture_HM0360_image_capture_impl.vm] "C:/Users/miche/Desktop/my_designs/HM0360/HM0360_image_capture/HM0360_image_capture_impl/HM0360_image_capture_HM0360_image_capture_impl.ldc"

} out]} {
   runtime_log $out
   exit 1
}
