vsim work.controllerdatapath_vhd_tst
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {Clock and Reset} /controllerdatapath_vhd_tst/CLK
add wave -noupdate -expand -group {Clock and Reset} /controllerdatapath_vhd_tst/RESET
add wave -noupdate -expand -group {Select, Enable and Data} -color {Light Blue} /controllerdatapath_vhd_tst/EN_ACC
add wave -noupdate -expand -group {Select, Enable and Data} -color {Light Blue} /controllerdatapath_vhd_tst/EN_R1
add wave -noupdate -expand -group {Select, Enable and Data} -color {Light Blue} /controllerdatapath_vhd_tst/EN_R2
add wave -noupdate -expand -group {Select, Enable and Data} -color {Light Blue} /controllerdatapath_vhd_tst/SEL_ACC
add wave -noupdate -expand -group {Select, Enable and Data} -color {Light Blue} /controllerdatapath_vhd_tst/SEL_R1
add wave -noupdate -expand -group {Select, Enable and Data} -color {Light Blue} /controllerdatapath_vhd_tst/SEL_R2
add wave -noupdate -expand -group {Select, Enable and Data} -color {Light Blue} /controllerdatapath_vhd_tst/SEL_SUM
add wave -noupdate -expand -group {Select, Enable and Data} -color {Light Blue} /controllerdatapath_vhd_tst/DATA
add wave -noupdate -expand -group Outputs -color Goldenrod /controllerdatapath_vhd_tst/ACC
add wave -noupdate -expand -group Outputs -color Goldenrod /controllerdatapath_vhd_tst/R1
add wave -noupdate -expand -group Outputs -color Goldenrod /controllerdatapath_vhd_tst/R2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {866 ps}

run -all