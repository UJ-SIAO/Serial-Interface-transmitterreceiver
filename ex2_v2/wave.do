onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/s1/clk
add wave -noupdate /tb/s1/rst
add wave -noupdate /tb/s1/RB1_RW
add wave -noupdate /tb/s1/RB1_A
add wave -noupdate /tb/s1/RB1_Q
add wave -noupdate /tb/s1/RB1_D
add wave -noupdate /tb/s1/sen
add wave -noupdate /tb/s1/sd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5046080 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {16537054 ps}
