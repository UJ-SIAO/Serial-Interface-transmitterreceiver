onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/s2/clk
add wave -noupdate /tb/s2/rst
add wave -noupdate /tb/s2/RB2_RW
add wave -noupdate /tb/s2/RB2_A
add wave -noupdate /tb/s2/RB2_D
add wave -noupdate /tb/s2/RB2_Q
add wave -noupdate /tb/s2/sen
add wave -noupdate /tb/s2/sd
add wave -noupdate /tb/s2/S2_done
add wave -noupdate -radix binary /tb/s2/recive_data0
add wave -noupdate /tb/s2/recive_data1
add wave -noupdate /tb/s2/recive_data2
add wave -noupdate /tb/s2/recive_data3
add wave -noupdate -radix binary /tb/s2/recive_data4
add wave -noupdate /tb/s2/recive_data5
add wave -noupdate /tb/s2/recive_data6
add wave -noupdate /tb/s2/recive_data7
add wave -noupdate -radix unsigned /tb/s2/bits_cnt
add wave -noupdate /tb/s2/package_cnt
add wave -noupdate /tb/s2/finish_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18850000 ps} 0}
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
WaveRestoreZoom {0 ps} {22102500 ps}
