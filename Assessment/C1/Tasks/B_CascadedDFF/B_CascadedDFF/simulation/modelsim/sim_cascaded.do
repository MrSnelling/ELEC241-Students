vcom -work work DFF.vhd
vcom -93 -work work elec241_shift_register.vhd
vcom -work work elec241_shift_register_test.vht
vsim work.elec241_shift_register_test
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Inputs /elec241_shift_register_test/C
add wave -noupdate -expand -group Inputs /elec241_shift_register_test/DIn
add wave -noupdate -expand -group Internal -color Yellow /elec241_shift_register_test/DOut
add wave -noupdate -expand -group Internal -color Yellow /elec241_shift_register_test/Y
add wave -noupdate -expand -group Output -color {Dark Orchid} -expand -subitemconfig {/elec241_shift_register_test/Q(0) {-color {Dark Orchid}} /elec241_shift_register_test/Q(1) {-color {Dark Orchid}} /elec241_shift_register_test/Q(2) {-color {Dark Orchid}}} /elec241_shift_register_test/Q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1115 ps} 0}
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
WaveRestoreZoom {0 ps} {1155 ps}
run -all