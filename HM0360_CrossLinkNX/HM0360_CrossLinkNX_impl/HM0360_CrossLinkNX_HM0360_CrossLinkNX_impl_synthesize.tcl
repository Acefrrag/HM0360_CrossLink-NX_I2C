if {[catch {

# define run engine funtion
source [file join {C:/lscc/radiant/3.2} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) 1
set para(prj_dir) "C:/Users/miche/Github_Repositories/HM0360_CrossLink-NX_I2C/HM0360_CrossLinkNX"
# synthesize IPs
# synthesize VMs
# synthesize top design
file delete -force -- HM0360_CrossLinkNX_HM0360_CrossLinkNX_impl.vm HM0360_CrossLinkNX_HM0360_CrossLinkNX_impl.ldc
run_engine_newmsg synthesis -f "HM0360_CrossLinkNX_HM0360_CrossLinkNX_impl_lattice.synproj"
run_postsyn [list -a LIFCL -p LIFCL-40 -t CSBGA289 -sp 8_High-Performance_1.0V -oc Commercial -top -w -o HM0360_CrossLinkNX_HM0360_CrossLinkNX_impl_syn.udb HM0360_CrossLinkNX_HM0360_CrossLinkNX_impl.vm] "C:/Users/miche/Github_Repositories/HM0360_CrossLink-NX_I2C/HM0360_CrossLinkNX/HM0360_CrossLinkNX_impl/HM0360_CrossLinkNX_HM0360_CrossLinkNX_impl.ldc"

} out]} {
   runtime_log $out
   exit 1
}
