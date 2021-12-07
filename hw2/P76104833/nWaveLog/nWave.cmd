wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 \
           {/home/zzhong/VLSI_system_design_2021/hw2/P76104833/build/top.fsdb}
wvSetCursor -win $_nWave1 3213001.383126
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP"
wvAddSignal -win $_nWave1 "/top_tb/TOP/clk"
wvSetPosition -win $_nWave1 {("G1" 0)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomIn -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper"
wvSetPosition -win $_nWave1 {("G2" 0)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/cpu_wrapper/read_state_M0\[31:0\]"
wvSetPosition -win $_nWave1 {("G2" 0)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/IM1"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/axi"
wvSetPosition -win $_nWave1 {("G3" 0)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/axi/ARADDR_M0\[31:0\]"
wvSetPosition -win $_nWave1 {("G3" 0)}
wvSetPosition -win $_nWave1 {("G3" 1)}
wvSetPosition -win $_nWave1 {("G3" 1)}
wvSetPosition -win $_nWave1 {("G4" 0)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G4" 0)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G4" 0)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/axi/ARADDR_S0\[31:0\]" \
           "/top_tb/TOP/axi/ARADDR_S\[0:2\]"
wvSetPosition -win $_nWave1 {("G4" 0)}
wvSetPosition -win $_nWave1 {("G4" 2)}
wvSetPosition -win $_nWave1 {("G4" 2)}
wvSelectSignal -win $_nWave1 {( "G4" 2 )} 
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvSetCursor -win $_nWave1 422.906942 -snap {("G4" 1)}
wvSetCursor -win $_nWave1 422.906942 -snap {("G4" 1)}
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvExpandBus -win $_nWave1 {("G4" 1)}
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G4" 3)}
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G4" 2)}
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G4" 0)}
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G4" 0)}
wvSetPosition -win $_nWave1 {("G3" 1)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/axi/direction_AR_M0\[2:0\]"
wvSetPosition -win $_nWave1 {("G3" 1)}
wvSetPosition -win $_nWave1 {("G3" 2)}
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSetRadix -win $_nWave1 -format Bin
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G4" 0)}
wvSetPosition -win $_nWave1 {("G3" 2)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/axi/direction_AR_S\[0:2\]"
wvSetPosition -win $_nWave1 {("G3" 2)}
wvSetPosition -win $_nWave1 {("G3" 3)}
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvExpandBus -win $_nWave1 {("G3" 3)}
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/IM1"
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G3" 6)}
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G3" 6)}
wvSetPosition -win $_nWave1 {("G4" 0)}
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G4" 0)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/IM1/read_state\[31:0\]"
wvSetPosition -win $_nWave1 {("G4" 0)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/axi/slave\[0\]"
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/axi/Arbiter_B_M1"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/axi"
wvSetPosition -win $_nWave1 {("G3" 4)}
wvSetPosition -win $_nWave1 {("G3" 3)}
wvSetPosition -win $_nWave1 {("G3" 2)}
wvSetPosition -win $_nWave1 {("G3" 3)}
wvSetPosition -win $_nWave1 {("G3" 4)}
wvSetPosition -win $_nWave1 {("G3" 5)}
wvSetPosition -win $_nWave1 {("G3" 6)}
wvSetPosition -win $_nWave1 {("G4" 0)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G4" 0)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G5" 0)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/axi/ARVALID_M0"
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G5" 1)}
wvSetPosition -win $_nWave1 {("G5" 1)}
wvSelectSignal -win $_nWave1 {( "G5" 1 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 0)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/axi/ARVALID_M0_S\[0:2\]"
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G5" 1)}
wvSelectSignal -win $_nWave1 {( "G5" 1 )} 
wvSelectSignal -win $_nWave1 {( "G5" 1 )} 
wvSelectSignal -win $_nWave1 {( "G5" 1 )} 
wvExpandBus -win $_nWave1 {("G5" 1)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 9563.153743 -snap {("G6" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/axi/slave\[0\]/Arbiter_AR_S"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/axi/slave\[0\]/mux_AR_S"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/axi/slave\[0\]/Arbiter_AR_S"
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 4)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 4)}
wvAddSignal -win $_nWave1 \
           "/top_tb/TOP/axi/slave\[0\]/Arbiter_AR_S/begin_sig\[1:0\]"
wvSetPosition -win $_nWave1 {("G5" 4)}
wvSetPosition -win $_nWave1 {("G5" 5)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 5)}
wvAddSignal -win $_nWave1 \
           "/top_tb/TOP/axi/slave\[0\]/Arbiter_AR_S/direction\[1:0\]"
wvSetPosition -win $_nWave1 {("G5" 5)}
wvSetPosition -win $_nWave1 {("G5" 6)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 6)}
wvAddSignal -win $_nWave1 \
           "/top_tb/TOP/axi/slave\[0\]/Arbiter_AR_S/priority_circle\[1:0\]"
wvSetPosition -win $_nWave1 {("G5" 6)}
wvSetPosition -win $_nWave1 {("G5" 7)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 7)}
wvAddSignal -win $_nWave1 \
           "/top_tb/TOP/axi/slave\[0\]/Arbiter_AR_S/transmitting_ending"
wvSetPosition -win $_nWave1 {("G5" 7)}
wvSetPosition -win $_nWave1 {("G5" 8)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G5" 8)}
wvSetPosition -win $_nWave1 {("G5" 7)}
wvSetPosition -win $_nWave1 {("G5" 8)}
wvAddSignal -win $_nWave1 \
           "/top_tb/TOP/axi/slave\[0\]/Arbiter_AR_S/begin_sig_2\[3:0\]"
wvSetPosition -win $_nWave1 {("G5" 8)}
wvSetPosition -win $_nWave1 {("G5" 9)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 9)}
wvAddSignal -win $_nWave1 \
           "/top_tb/TOP/axi/slave\[0\]/Arbiter_AR_S/direction_2\[3:0\]"
wvSetPosition -win $_nWave1 {("G5" 9)}
wvSetPosition -win $_nWave1 {("G5" 10)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G5" 10)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/axi/slave\[0\]/Arbiter_AR_S/transmitting"
wvSetPosition -win $_nWave1 {("G5" 10)}
wvSetPosition -win $_nWave1 {("G5" 11)}
wvSetCursor -win $_nWave1 12305.227784 -snap {("G6" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 4460.986126 -snap {("G6" 0)}
wvSelectSignal -win $_nWave1 {( "G5" 1 2 3 4 5 6 7 8 9 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetCursor -win $_nWave1 2332.809258 -snap {("G6" 0)}
wvSetCursor -win $_nWave1 8526.349628 -snap {("G6" 0)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/axi"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/axi/slave\[0\]"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/axi/slave\[0\]/Arbiter_AR_S"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/axi"
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 0)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/axi/RLAST_S0" \
           "/top_tb/TOP/axi/RLAST_S\[0:2\]"
wvSetPosition -win $_nWave1 {("G5" 0)}
wvSetPosition -win $_nWave1 {("G5" 2)}
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/IM1"
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 2)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/IM1/WLAST_S"
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G5" 3)}
wvSelectSignal -win $_nWave1 {( "G5" 3 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 2)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/IM1/RLAST_S"
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G5" 3)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 3)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/IM1/ARLEN_S\[3:0\]"
wvSetPosition -win $_nWave1 {("G5" 3)}
wvSetPosition -win $_nWave1 {("G5" 4)}
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/axi"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/IM1"
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 4)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/IM1/RREADY_S"
wvSetPosition -win $_nWave1 {("G5" 4)}
wvSetPosition -win $_nWave1 {("G5" 5)}
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/axi"
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 5)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/axi/direction_R_S\[0:2\]"
wvSetPosition -win $_nWave1 {("G5" 5)}
wvSetPosition -win $_nWave1 {("G5" 6)}
wvSelectSignal -win $_nWave1 {( "G5" 6 )} 
wvExpandBus -win $_nWave1 {("G5" 6)}
wvSetPosition -win $_nWave1 {("G5" 8)}
wvSetPosition -win $_nWave1 {("G5" 9)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 9)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/axi/RID_S0\[7:0\]"
wvSetPosition -win $_nWave1 {("G5" 9)}
wvSetPosition -win $_nWave1 {("G5" 10)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 9)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetPosition -win $_nWave1 {("G5" 10)}
wvSetPosition -win $_nWave1 {("G5" 9)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/axi/ARID_S0\[7:0\]"
wvSetPosition -win $_nWave1 {("G5" 9)}
wvSetPosition -win $_nWave1 {("G5" 10)}
wvSelectSignal -win $_nWave1 {( "G5" 10 )} 
wvSetRadix -win $_nWave1 -format Bin
wvSetCursor -win $_nWave1 1582.490491 -snap {("G3" 4)}
