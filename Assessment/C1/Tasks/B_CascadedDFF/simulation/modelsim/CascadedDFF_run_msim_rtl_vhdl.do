transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {D:/GitHub/ELEC241-Students/Assessment/C1/Tasks/B_CascadedDFF/elec241_shift_register.vhd}

do "D:/GitHub/ELEC241-Students/Assessment/C1/Tasks/B_CascadedDFF/simulation/modelsim/setup.do"
