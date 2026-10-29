//****************************************************************************
//
// SPDX-License-Identifier: MIT-0
// SPDX-FileCopyrightText: Copyright (C) 2025 Altera Corporation
//
//****************************************************************************
// This is a generated system top level RTL file.



module ghrd_agilex_top (
    //Additional refclk_bti to preserve Etile XCVR
    // Clock and Reset
    input wire fpga_clk_100,


    output wire [4-1:0] fpga_led_pio,

    //HPS
    // HPS EMIF
    output wire          emif_hps_mem_mem_ck_c,
    output wire          emif_hps_mem_mem_ck_t,
    output wire [  12:0] emif_hps_mem_mem_ca,
    output wire          emif_hps_mem_mem_cs_n,
    output wire          emif_hps_mem_mem_reset_n,
    output wire [ 4-1:0] emif_hps_mem_mem_dm_n,
    input  wire          emif_hps_mem_mem_alert_n,
    input  wire          emif_hps_oct_oct_rzqin,
    input  wire          emif_hps_noc_refclk_clk,
    output wire          emif_hps_noc_pll_lock_o_pll_lock_o,
    input  wire          emif_hps_ref_clk_clk,
    inout  wire [32-1:0] emif_hps_mem_mem_dq,
    inout  wire [ 4-1:0] emif_hps_mem_mem_dqs_c,
    inout  wire [ 4-1:0] emif_hps_mem_mem_dqs_t,
    input  wire          hps_jtag_tck,
    input  wire          hps_jtag_tms,
    output wire          hps_jtag_tdo,
    input  wire          hps_jtag_tdi,
    output wire          hps_sdmmc_CCLK,
    inout  wire          hps_sdmmc_CMD,
    inout  wire          hps_sdmmc_D0,
    inout  wire          hps_sdmmc_D1,
    inout  wire          hps_sdmmc_D2,
    inout  wire          hps_sdmmc_D3,
    inout  wire          hps_usb0_DATA0,
    inout  wire          hps_usb0_DATA1,
    inout  wire          hps_usb0_DATA2,
    inout  wire          hps_usb0_DATA3,
    inout  wire          hps_usb0_DATA4,
    inout  wire          hps_usb0_DATA5,
    inout  wire          hps_usb0_DATA6,
    inout  wire          hps_usb0_DATA7,
    input  wire          hps_usb0_CLK,
    output wire          hps_usb0_STP,
    input  wire          hps_usb0_DIR,
    input  wire          hps_usb0_NXT,
    output wire          hps_emac0_TX_CLK,
    input  wire          hps_emac0_RX_CLK,
    output wire          hps_emac0_TX_CTL,
    input  wire          hps_emac0_RX_CTL,
    output wire          hps_emac0_TXD0,
    output wire          hps_emac0_TXD1,
    input  wire          hps_emac0_RXD0,
    input  wire          hps_emac0_RXD1,
    output wire          hps_emac0_TXD2,
    output wire          hps_emac0_TXD3,
    input  wire          hps_emac0_RXD2,
    input  wire          hps_emac0_RXD3,
    inout  wire          hps_emac0_MDIO,
    output wire          hps_emac0_MDC,
    input  wire          hps_uart0_RX,
    output wire          hps_uart0_TX,
    inout  wire          hps_i2c1_SDA,
    inout  wire          hps_i2c1_SCL,
    inout  wire          hps_gpio1_io0,
    inout  wire          hps_gpio1_io1,
    inout  wire          hps_gpio1_io4,
    inout  wire          hps_gpio1_io5,
    inout  wire          hps_gpio1_io19,
    inout  wire          hps_gpio1_io20,
    inout  wire          hps_gpio1_io21,
    input  wire          hps_ref_clk,

    input wire fpga_reset_n
);

    wire system_clk_100;
    wire system_clk_100_internal;
    wire ninit_done;
    wire fpga_reset_n_debounced_wire;
    reg fpga_reset_n_debounced;
    wire src_reset_n;
    wire system_reset_n;
    wire system_reset_sync;
    wire h2f_reset;


    assign system_reset_n = fpga_reset_n & src_reset_n & ~h2f_reset & ~ninit_done;

    altera_reset_synchronizer #(
        .ASYNC_RESET(1),
        .DEPTH      (2)
    ) sys_rst_inst (
        .reset_in (~system_reset_n),
        .clk      (system_clk_100),
        .reset_out(system_reset_sync)
    );


    assign system_clk_100 = fpga_clk_100;

    assign system_clk_100_internal = system_clk_100;

    wire [4-2:0] fpga_led_internal;
    wire heartbeat_led;
    reg [22:0] heartbeat_count;
    assign heartbeat_led = ~heartbeat_count[22];

    assign fpga_led_pio = {heartbeat_led, fpga_led_internal};

    wire [31:0] f2h_irq1_irq;


    wire [43:0] stm_hw_events;

    assign stm_hw_events = {{28{1'b0}}, heartbeat_led, fpga_led_internal};





    assign f2h_irq1_irq = {32'b0};

    //Temporary disable src_reset_n
    assign src_reset_n = 1'b1;

    // Qsys Top module
    qsys_top soc_inst (
        //.src_prb_rst_sources_source             (src_reset_n),
        .clk_100_clk                              (system_clk_100_internal),
        .ninit_done_ninit_done                    (ninit_done),
        .led_pio_external_connection_in_port      (fpga_led_internal),
        .led_pio_external_connection_out_port     (fpga_led_internal),
        .agilex_hps_f2h_stm_hw_events_stm_hwevents(stm_hw_events),
        //Terminate the CS_JTAG.
        .agilex_hps_h2f_cs_ntrst                  (1'b1),
        .agilex_hps_h2f_cs_tck                    (1'b1),
        .agilex_hps_h2f_cs_tdi                    (1'b1),
        .agilex_hps_h2f_cs_tdo                    (),
        .agilex_hps_h2f_cs_tdoen                  (),
        .agilex_hps_h2f_cs_tms                    (1'b1),
        .emif_hps_noc_pll_lock_o_pll_lock_o       (emif_hps_noc_pll_lock_o_pll_lock_o),
        .emif_hps_noc_refclk_clk                  (emif_hps_noc_refclk_clk),
        .emif_hps_emif_mem_ck_0_mem_ck_c          (emif_hps_mem_mem_ck_c),
        .emif_hps_emif_mem_ck_0_mem_ck_t          (emif_hps_mem_mem_ck_t),
        .emif_hps_emif_mem_0_mem_ca               (emif_hps_mem_mem_ca),
        .emif_hps_emif_mem_0_mem_cs_n             (emif_hps_mem_mem_cs_n),
        .emif_hps_emif_mem_reset_n_mem_reset_n    (emif_hps_mem_mem_reset_n),
        .emif_hps_emif_mem_0_mem_dm_n             (emif_hps_mem_mem_dm_n),
        .emif_hps_emif_mem_0_mem_alert_n          (emif_hps_mem_mem_alert_n),
        .emif_hps_emif_oct_0_oct_rzqin            (emif_hps_oct_oct_rzqin),
        .emif_hps_emif_ref_clk_0_clk              (emif_hps_ref_clk_clk),
        .emif_hps_emif_mem_0_mem_dq               (emif_hps_mem_mem_dq),
        .emif_hps_emif_mem_0_mem_dqs_c            (emif_hps_mem_mem_dqs_c),
        .emif_hps_emif_mem_0_mem_dqs_t            (emif_hps_mem_mem_dqs_t),
        .hps_io_jtag_tck                          (hps_jtag_tck),
        .hps_io_jtag_tms                          (hps_jtag_tms),
        .hps_io_jtag_tdo                          (hps_jtag_tdo),
        .hps_io_jtag_tdi                          (hps_jtag_tdi),
        .hps_io_EMAC0_TX_CLK                      (hps_emac0_TX_CLK),
        .hps_io_EMAC0_RX_CLK                      (hps_emac0_RX_CLK),
        .hps_io_EMAC0_TX_CTL                      (hps_emac0_TX_CTL),
        .hps_io_EMAC0_RX_CTL                      (hps_emac0_RX_CTL),
        .hps_io_EMAC0_TXD0                        (hps_emac0_TXD0),
        .hps_io_EMAC0_TXD1                        (hps_emac0_TXD1),
        .hps_io_EMAC0_RXD0                        (hps_emac0_RXD0),
        .hps_io_EMAC0_RXD1                        (hps_emac0_RXD1),
        .hps_io_EMAC0_TXD2                        (hps_emac0_TXD2),
        .hps_io_EMAC0_TXD3                        (hps_emac0_TXD3),
        .hps_io_EMAC0_RXD2                        (hps_emac0_RXD2),
        .hps_io_EMAC0_RXD3                        (hps_emac0_RXD3),
        .hps_io_EMAC0_MDIO                        (hps_emac0_MDIO),
        .hps_io_EMAC0_MDC                         (hps_emac0_MDC),
        .hps_io_SDMMC_CCLK                        (hps_sdmmc_CCLK),
        .hps_io_SDMMC_CMD                         (hps_sdmmc_CMD),
        .hps_io_SDMMC_D0                          (hps_sdmmc_D0),
        .hps_io_SDMMC_D1                          (hps_sdmmc_D1),
        .hps_io_SDMMC_D2                          (hps_sdmmc_D2),
        .hps_io_SDMMC_D3                          (hps_sdmmc_D3),
        .hps_io_I2C1_SDA                          (hps_i2c1_SDA),
        .hps_io_I2C1_SCL                          (hps_i2c1_SCL),
        .hps_io_UART0_RX                          (hps_uart0_RX),
        .hps_io_UART0_TX                          (hps_uart0_TX),
        .hps_io_USB0_CLK                          (hps_usb0_CLK),
        .hps_io_USB0_STP                          (hps_usb0_STP),
        .hps_io_USB0_DIR                          (hps_usb0_DIR),
        .hps_io_USB0_NXT                          (hps_usb0_NXT),
        .hps_io_USB0_DATA0                        (hps_usb0_DATA0),
        .hps_io_USB0_DATA1                        (hps_usb0_DATA1),
        .hps_io_USB0_DATA2                        (hps_usb0_DATA2),
        .hps_io_USB0_DATA3                        (hps_usb0_DATA3),
        .hps_io_USB0_DATA4                        (hps_usb0_DATA4),
        .hps_io_USB0_DATA5                        (hps_usb0_DATA5),
        .hps_io_USB0_DATA6                        (hps_usb0_DATA6),
        .hps_io_USB0_DATA7                        (hps_usb0_DATA7),
        .hps_io_gpio1_io0                         (hps_gpio1_io0),
        .hps_io_gpio1_io1                         (hps_gpio1_io1),
        .hps_io_gpio1_io4                         (hps_gpio1_io4),
        .hps_io_gpio1_io5                         (hps_gpio1_io5),
        .hps_io_gpio1_io19                        (hps_gpio1_io19),
        .hps_io_gpio1_io20                        (hps_gpio1_io20),
        .hps_io_gpio1_io21                        (hps_gpio1_io21),
        .f2h_irq1_irq                             (f2h_irq1_irq),
        .hps_io_hps_osc_clk                       (hps_ref_clk),
        .h2f_reset_reset                          (h2f_reset),
        .reset_reset_n                            (~system_reset_sync)
    );


    always @(posedge system_clk_100_internal or posedge system_reset_sync) begin
        if (system_reset_sync) heartbeat_count <= 23'd0;
        else heartbeat_count <= heartbeat_count + 23'd1;
    end



endmodule


