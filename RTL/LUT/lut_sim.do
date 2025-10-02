quit -sim
vlib work
vlog lut.v lut_tb.v 
vsim work.lut_tb
add wave * 
add wave -position insertpoint  \
sim:/lut_tb/DUT/mem
run -all