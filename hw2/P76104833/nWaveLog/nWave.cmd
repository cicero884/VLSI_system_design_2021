wvSetOptions -win $_nWave1 -snap off
wvResizeWindow -win $_nWave1 3000 560 1920 1039
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 \
           {/home/zzhong/VLSI_system_design_2021/hw2/P76104833/build/top.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/DM1"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/IM1"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/axi"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP"
wvAddSignal -win $_nWave1 "/top_tb/TOP/clk"
wvSetPosition -win $_nWave1 {("G1" 0)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/DM1"
wvSetPosition -win $_nWave1 {("G2" 0)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/DM1/read_state\[31:0\]"
wvSetPosition -win $_nWave1 {("G2" 0)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/IM1"
wvSetPosition -win $_nWave1 {("G3" 0)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G3" 0)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvAddSignal -win $_nWave1 "/top_tb/TOP/IM1/read_state\[31:0\]"
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G2" 2)}
wvZoom -win $_nWave1 0.000000 111756.569848
wvSetCursor -win $_nWave1 21099.269411
wvSetCursor -win $_nWave1 9969.984447
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 15070.906722
wvSetCursor -win $_nWave1 1391.160621
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/IM1"
wvZoomIn -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/DM1"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/IM1"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/cpu_wrapper"
wvGetSignalSetScope -win $_nWave1 "/top_tb/TOP/axi"
wvSelectGroup -win $_nWave1 {G2}
wvSetCursor -win $_nWave1 9544.907591
wvExit
