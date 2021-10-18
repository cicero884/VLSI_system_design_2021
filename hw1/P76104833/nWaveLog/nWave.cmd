wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 \
           {/home/zzhong/VLSI_system_design_2021/hw1/P76104833/build/top.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb"
wvRestoreSignal -win $_nWave1 \
           "/home/zzhong/practice/verilog/VLSI_system_design/hw1/P76104833/signal.rc" \
           -overWriteAutoAlias on
wvResizeWindow -win $_nWave1 0 0 1080 1833
wvResizeWindow -win $_nWave1 0 0 1080 1833
wvResizeWindow -win $_nWave1 1080 442 1920 1111
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomIn -win $_nWave1
wvSetCursor -win $_nWave1 282434.453455 -snap {("G6LLLL" 4)}
wvSetCursor -win $_nWave1 289168.754829 -snap {("G6LLLL" 4)}
wvResizeWindow -win $_nWave1 2060 1015 940 72
wvResizeWindow -win $_nWave1 1592 612 1292 598
wvSetCursor -win $_nWave1 269613.827220 -snap {("ID" 3)}
wvSetCursor -win $_nWave1 82995.486307 -snap {("ID" 3)}
