#****************************************************************************
#
# SPDX-License-Identifier: MIT-0
# SPDX-FileCopyrightText: Copyright (C) 2025 Altera Corporation
#
#****************************************************************************
#
# Sample SDC for Agilex HPS SGMII GHRD.
#
#****************************************************************************

set_false_path -from * -to [get_keepers {*|sgmii_debug_status_pio|altera_avalon_pio_inst|d1_data_in[*]}]
set_false_path -from * -to [get_keepers {*|sgmii_debug_status_pio|altera_avalon_pio_inst|readdata[*]}]

# False path to COL for duplex SGMII Mode
set_false_path -from [get_keepers -no_duplicates {soc_inst|*|altera_eth_tse_inst|i_tse_pcs_0|altera_tse_top_1000_base_x_inst|U_SGMII|U_COL|state}] -to [get_keepers -no_duplicates {soc_inst|agilex_hps|*|s2f_module~soc_hps_wrapper/s0_b_28__vio_lab_core_periphery__clk[*].reg}]

# The PCS clock (external) and hps_emac1_gtx_clk (HPS generated clock) are logically exclusive to each other through a clock multiplexer
set_clock_groups -logically_exclusive -group [get_clocks {PCS_CLOCK}] -group [get_clocks {hps_emac1_gtx_clk}]

set_output_delay -clock MAIN_CLOCK 5 [get_ports {emac1_phy_rst_n}]