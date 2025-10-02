quit -sim
vlib work 
vlog top.v top_tb.v 
vlog Quadrant_Handler.v 
vlog cordic_rotation.v 
vlog {.\Look-Up Table\lut.v}
vsim work.top_tb
add wave *
add wave -position insertpoint  \
sim:/top_tb/DUT/cordic_algorithm_rotation/x_start \
sim:/top_tb/DUT/cordic_algorithm_rotation/y_start \
sim:/top_tb/DUT/cordic_algorithm_rotation/angle \
sim:/top_tb/DUT/cordic_algorithm_rotation/sine \
sim:/top_tb/DUT/cordic_algorithm_rotation/cosine \
sim:/top_tb/DUT/cordic_algorithm_rotation/valid_out \
sim:/top_tb/DUT/cordic_algorithm_rotation/iteration_counter \
sim:/top_tb/DUT/cordic_algorithm_rotation/x \
sim:/top_tb/DUT/cordic_algorithm_rotation/y \
sim:/top_tb/DUT/cordic_algorithm_rotation/z \
sim:/top_tb/DUT/cordic_algorithm_rotation/e_i
add wave -position insertpoint  \
sim:/top_tb/DUT/Quadrant_Handler_block/sine_in \
sim:/top_tb/DUT/Quadrant_Handler_block/cosine_in \
sim:/top_tb/DUT/Quadrant_Handler_block/angle_in \
sim:/top_tb/DUT/Quadrant_Handler_block/sine_out \
sim:/top_tb/DUT/Quadrant_Handler_block/cosine_out \
sim:/top_tb/DUT/Quadrant_Handler_block/angle_out
run -all