set_svf top.svf
# Force multicore
set_host_options -max_cores 16

# Read all Files
set top top
read_file -autoread -top ${top} -recursive {../src} -library model
current_design ${top}
link

# Setting Clock Constraits
source -echo -verbose ../script/DC.sdc

# High fanout threshold
set high_fanout_net_threshold 0
report_net_fanout -high_fanout

uniquify
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]
 
set_structure -timing true
 
check_design

# Synthesize (high effort)
compile -map_effort high 
compile -map_effort high -inc

# Ultra
#compile_ultra 
#compile_ultra -inc

current_design [get_designs ${top}]
 
remove_unconnected_ports -blast_buses [get_cells -hierarchical *]
 
set bus_inference_style {%s[%d]}
set bus_naming_style {%s[%d]}
set hdlout_internal_busses true
change_names -hierarchy -rule verilog
define_name_rules name_rule -allowed {a-z A-Z 0-9 _}   -max_length 255 -type cell
define_name_rules name_rule -allowed {a-z A-Z 0-9 _[]} -max_length 255 -type net
define_name_rules name_rule -map {{"\\*cell\\*" "cell"}}
define_name_rules name_rule -case_insensitive
change_names -hierarchy -rules name_rule

write -format ddc  -hierarchy -output "${top}_syn.ddc"
write_sdf -version 2.0 -context verilog  -load_delay net ../syn/${top}_syn.sdf
write_sdc -version 2.0 "${top}_syn.sdc"
write_file -format verilog -hierarchy -output ../syn/${top}_syn.v
report_area > area.log
report_timing > timing.log
report_power > power.log
report_qor > ${top}_syn.qor

# exit
