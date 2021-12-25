# Clear the environment
clear -all
# Analyze design files
analyze -sv ../src/data_array_wrapper.sv
analyze -sv ../src/tag_array_wrapper.sv
analyze -sv ../sim/data_array/data_array_rtl.sv
analyze -sv ../sim/tag_array/tag_array_rtl.sv
analyze -sv +incdir+../include ../src/L1C_data.sv
# Analyze SVA file
analyze -sv ../sva/cache_props.sva
# Elaborate design and properties
elaborate -top L1C_data
# Set up Clock and Reset
clock clk
reset -expression {rst}
#Prove all properties
set_engine_mode {Hp Ht B D Tri}
prove -all
