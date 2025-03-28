onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hdlTop/i2sTransmitterAgentBFM/i2sTransmitterDriverBFM/clk
add wave -noupdate /hdlTop/i2sTransmitterAgentBFM/i2sTransmitterDriverBFM/rst
add wave -noupdate /hdlTop/i2sTransmitterAgentBFM/i2sTransmitterDriverBFM/sclkOutput
add wave -noupdate -color Yellow /hdlTop/i2sTransmitterAgentBFM/i2sTransmitterDriverBFM/wsOutput
add wave -noupdate -color White /hdlTop/i2sTransmitterAgentBFM/i2sTransmitterDriverBFM/sd
add wave -noupdate /hdlTop/i2sTransmitterAgentBFM/i2sTransmitterDriverBFM/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {64 us}
