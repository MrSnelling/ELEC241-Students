vcom -work work binary_counter.vhd
vcom -work work seven_seg_decode.vhd
vcom -work work seven_seg_decode_test.vht
vsim work.seven_seg_decode_test
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Inputs -expand /seven_seg_decode_test/X
add wave -noupdate -expand -group {Enable and Reset} -color {Light Steel Blue} /seven_seg_decode_test/E
add wave -noupdate -expand -group {Enable and Reset} -color {Light Steel Blue} /seven_seg_decode_test/R
add wave -noupdate -expand -group Output -color Firebrick -expand -subitemconfig {/seven_seg_decode_test/Y(0) {-color Firebrick -height 15} /seven_seg_decode_test/Y(1) {-color Firebrick -height 15} /seven_seg_decode_test/Y(2) {-color Firebrick -height 15} /seven_seg_decode_test/Y(3) {-color Firebrick -height 15} /seven_seg_decode_test/Y(4) {-color Firebrick -height 15} /seven_seg_decode_test/Y(5) {-color Firebrick -height 15} /seven_seg_decode_test/Y(6) {-color Firebrick -height 15}} /seven_seg_decode_test/Y
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6348 ps} 0}
quietly wave cursor active 1
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {6720 ps}
run -all