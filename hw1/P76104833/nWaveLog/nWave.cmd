wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 \
           {/home/zzhong/VLSI_system_design_2021/hw1/P76104833/build/top.fsdb}
wvRestoreSignal -win $_nWave1 \
           "/home/zzhong/practice/verilog/VLSI_system_design/hw1/P76104833/signal.rc" \
           -overWriteAutoAlias on
wvResizeWindow -win $_nWave1 1080 442 1920 1111
wvSelectGroup -win $_nWave1 {MEM/MEM-1}
wvSelectSignal -win $_nWave1 {( "MEM/MEM-1" 1 )} 
wvSetSearchMode -win $_nWave1 -value 
wvSetSearchMode -win $_nWave1 -value 8222
wvSearchNext -win $_nWave1
wvSearchNext -win $_nWave1
wvSearchNext -win $_nWave1
wvSearchPrev -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvSetCursor -win $_nWave1 9007371.948626 -snap {("EX" 8)}
wvSetCursor -win $_nWave1 8997489.648713 -snap {("EX" 1)}
wvSetCursor -win $_nWave1 8998666.112988 -snap {("MEM" 3)}
wvSetSearchMode -win $_nWave1 -anyChange
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/CPU1/dm_control"
wvSetPosition -win $_nWave1 {("EX" 23)}
wvSetPosition -win $_nWave1 {("G6LLLL" 0)}
wvSetPosition -win $_nWave1 {("MEM" 5)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 0)}
wvSetPosition -win $_nWave1 {("MEM" 5)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/CPU1/dm_control/rb_data_out\[31:0\]"
wvSetPosition -win $_nWave1 {("MEM" 5)}
wvSetPosition -win $_nWave1 {("MEM" 6)}
wvSetPosition -win $_nWave1 {("MEM" 5)}
wvSetPosition -win $_nWave1 {("MEM" 6)}
wvSetPosition -win $_nWave1 {("MEM" 6)}
wvSetPosition -win $_nWave1 {("MEM" 6)}
wvSetPosition -win $_nWave1 {("MEM" 6)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvSetCursor -win $_nWave1 8997489.648713 -snap {("EX" 23)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvSetCursor -win $_nWave1 8999671.455187 -snap {("MEM" 6)}
wvSetCursor -win $_nWave1 8998730.283767 -snap {("MEM" 6)}
wvSetCursor -win $_nWave1 8997511.038972 -snap {("MEM-1" 2)}
wvSetCursor -win $_nWave1 8998537.771431 -snap {("MEM-1" 2)}
wvSetCursor -win $_nWave1 8999671.455187 -snap {("MEM-1" 1)}
wvGetSignalOpen -win $_nWave1
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 1)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 2)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 3)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/CPU1/dm_control/rb_data_in\[31:0\]"
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 3)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 4)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 3)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 4)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 4)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 4)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 4)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvSetCursor -win $_nWave1 9000805.138943 -snap {("MEM-1" 4)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/CPU1"
wvSetPosition -win $_nWave1 {("MEM" 5)}
wvSetPosition -win $_nWave1 {("MEM" 6)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 4)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 3)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 2)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 1)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 0)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/CPU1/funct3_mem\[2:0\]"
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 0)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 1)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 0)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 1)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 1)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 1)}
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 1)}
wvScrollDown -win $_nWave1 6
wvSetPosition -win $_nWave1 {("MEM/MEM-1" 0)}
wvSetPosition -win $_nWave1 {("MEM" 5)}
wvSetPosition -win $_nWave1 {("MEM" 4)}
wvSetPosition -win $_nWave1 {("MEM" 3)}
wvSetPosition -win $_nWave1 {("MEM" 2)}
wvSetPosition -win $_nWave1 {("MEM" 1)}
wvSetPosition -win $_nWave1 {("MEM" 0)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("MEM" 0)}
wvSetPosition -win $_nWave1 {("MEM" 1)}
wvSetPosition -win $_nWave1 {("MEM" 1)}
wvSetPosition -win $_nWave1 {("MEM" 1)}
wvSetPosition -win $_nWave1 {("MEM" 1)}
wvSelectSignal -win $_nWave1 {( "ID" 17 )} 
wvSetPosition -win $_nWave1 {("ID" 17)}
wvExpandBus -win $_nWave1 {("ID" 17)}
wvSetPosition -win $_nWave1 {("MEM" 1)}
wvScrollUp -win $_nWave1 11
wvSelectSignal -win $_nWave1 {( "ID" 17 )} 
wvSetPosition -win $_nWave1 {("ID" 17)}
wvCollapseBus -win $_nWave1 {("ID" 17)}
wvSetPosition -win $_nWave1 {("ID" 17)}
wvSetPosition -win $_nWave1 {("ID" 17)}
wvSetPosition -win $_nWave1 {("ID" 17)}
wvSetPosition -win $_nWave1 {("ID" 17)}
wvSetPosition -win $_nWave1 {("MEM" 1)}
wvSelectSignal -win $_nWave1 {( "MEM" 1 )} 
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvSetCursor -win $_nWave1 8999671.455187 -snap {("EX" 8)}
wvSetCursor -win $_nWave1 8998430.820133 -snap {("EX" 8)}
wvSetCursor -win $_nWave1 8999607.284408 -snap {("EX" 8)}
wvSelectSignal -win $_nWave1 {( "MEM/MEM-1" 1 )} 
wvSetSearchMode -win $_nWave1 -value 8222
wvSetSearchMode -win $_nWave1 -value 8202
wvSearchPrev -win $_nWave1
wvSearchNext -win $_nWave1
wvSearchNext -win $_nWave1
wvSelectSignal -win $_nWave1 {( "MEM" 5 )} 
wvSetSearchMode -win $_nWave1 -value 8222
wvSearchNext -win $_nWave1
wvSearchNext -win $_nWave1
wvSelectSignal -win $_nWave1 {( "MEM" 5 )} 
wvSearchPrev -win $_nWave1
wvSearchPrev -win $_nWave1
wvSelectSignal -win $_nWave1 {( "MEM" 3 )} 
wvSelectSignal -win $_nWave1 {( "MEM" 5 )} 
wvSearchNext -win $_nWave1
wvSearchNext -win $_nWave1
wvSearchNext -win $_nWave1
wvSearchNext -win $_nWave1
wvSelectSignal -win $_nWave1 {( "MEM/MEM-1" 1 )} 
wvSearchNext -win $_nWave1
wvSearchNext -win $_nWave1
wvSearchNext -win $_nWave1
wvSearchNext -win $_nWave1
wvSearchPrev -win $_nWave1
wvSearchNext -win $_nWave1
wvSelectSignal -win $_nWave1 {( "MEM" 2 )} 
wvSelectSignal -win $_nWave1 {( "MEM" 7 )} 
wvSelectSignal -win $_nWave1 {( "MEM/MEM-1" 1 )} 
wvSearchPrev -win $_nWave1
wvExit
