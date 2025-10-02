quit -sim 
vlib work 
vlog cordic_rotation_tb.v cordic_rotation.v 
vlog {.\Look-Up Table\lut.v}
vsim work.cordic_rotation_tb
add wave *
add wave -position insertpoint  \
sim:/cordic_rotation_tb/DUT/look_up_table/raddr \
sim:/cordic_rotation_tb/DUT/look_up_table/data_out \
sim:/cordic_rotation_tb/DUT/look_up_table/mem
add wave -position insertpoint  \
sim:/cordic_rotation_tb/DUT/iteration_counter \
sim:/cordic_rotation_tb/DUT/x \
sim:/cordic_rotation_tb/DUT/y \
sim:/cordic_rotation_tb/DUT/z \
sim:/cordic_rotation_tb/DUT/e_i
add wave -position insertpoint  \
sim:/cordic_rotation_tb/DUT/angle_out
add wave -position insertpoint  \
sim:/cordic_rotation_tb/DUT/interval
run -all