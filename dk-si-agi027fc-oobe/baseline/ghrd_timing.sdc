#****************************************************************************
#
# SPDX-License-Identifier: MIT-0
# SPDX-FileCopyrightText: Copyright (C) 2025 Altera Corporation
#
#****************************************************************************
#
# Sample SDC for Agilex GHRD.
#
#****************************************************************************

set_time_format -unit ns -decimal_places 3

# 100MHz board input clock
create_clock -name MAIN_CLOCK -period 10 [get_ports fpga_clk_100]

set_false_path -no_synchronizer -to [get_registers {sys_rst_inst|altera_reset_synchronizer_int_chain[1]}]
# VDS: FROM/TO to avoid overriding IP's set_min/max_delay on rst_controller chain[1]
set_false_path -no_synchronizer -from [get_registers {sys_rst_inst|altera_reset_synchronizer_int_chain_out}] -to [get_registers {soc_inst|rst_controller|alt_rst_sync_uq1|altera_reset_synchronizer_int_chain[1]}]

#set_false_path -from [get_ports {reset_reset_n}]

# sourcing JTAG related SDC
source ./jtag.sdc

# FPGA IO port constraints
create_clock -name SGPIO_CLOCK -period 1MHz [get_ports fpga_sgpio_clk]
set_false_path -from [get_ports {fpga_button_pio[0]}] -to *
set_false_path -from [get_ports {fpga_button_pio[1]}] -to *
set_false_path -from [get_ports {fpga_sgpi}] -to *
set_false_path -from [get_ports {fpga_sgpio_sync}] -to *
set_false_path -from * -to [get_ports {fpga_sgpo}]
set_output_delay -clock SGPIO_CLOCK 1 [get_ports fpga_sgpo]



