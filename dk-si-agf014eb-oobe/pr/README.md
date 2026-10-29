# HPS Partial Reconfiguration System Example Design for Agilex 7 FPGA F-Series Transceiver-SoC Development Kit (OOBE / SD/MMC)

HPS Partial Reconfiguration System Example Design for the Agilex 7 FPGA F-Series Transceiver-SoC Development Kit with OOBE daughter card.

## Description

<p>This design is a Baseline Hardware Reference Design for Altera Agilex 7 System On Chip (SoC) FPGA.

</p><p>This design is part of the Baseline System Example Design, which provides a complete solution, including exercising soft IP in the fabric, booting to U-Boot, then Linux, and running sample Linux applications.
Refer to the <a href="https://altera-fpga.github.io/latest/embedded-designs/agilex-7/f-series/soc/gsrd/ug-gsrd-agx7f-soc/">HPS Baseline System Example Design User Guide: Agilex 7 F-Series SoC Development Kit</a> for more information.

</p><p>This design boots from SD/MMC and demonstrates partial reconfiguration. HPS EMIF ECC is enabled by default.

</p><h2>Baseline feature
</h2><p>This design demonstrates the following system integration between Hard Processor System (HPS) and FPGA IPs:
<ul><li>Hard Processor System (HPS) enablement and configuration
<ul><li>HPS Peripheral and I/O (NAND, SD/MMC, EMAC, USB, SPI, I2C, UART, and GPIO — depends on the daughter card)
</li><li>HPS Clock and Reset
</li><li>HPS FPGA Bridge and Interrupt
</li></ul></li><li>HPS EMIF configuration
</li><li>System integration with FPGA IPs
<ul><li>System ID (SYSID)
</li><li>Programmable I/O (PIO) IP for controlling DIPSW, PushButton, and LEDs
</li><li>FPGA On-Chip Memory
</li></ul></li></ul>
</p><h3>Partial Reconfiguration feature</h3><p>This design includes a PR region in the FPGA fabric with two personas (base and alternate revision).</p>

## Project Details

- **Family**: Agilex 7
- **Quartus Version**: 26.3
- **Development Kit**: Agilex 7 FPGA F-Series Transceiver-SoC Development Kit (P-Tile and E-Tile) DK-SI-AGF014EB
- **Device Part**: AGFB014R24B2E2V
- **Category**: HPS
- **Source**: Quartus Prime Pro
- **URL**: https://github.com/altera-fpga/agilex7-ed-hps-baseline
- **Design Package**: dk-si-agf014eb-oobe-pr.zip
- **Documentations**: https://altera-fpga.github.io/latest/embedded-designs/agilex-7/f-series/soc/gsrd/ug-gsrd-agx7f-soc/

## Documentations

- **Title**: HPS Baseline System Example Design User Guide: Agilex 7 F-Series SoC Development Kit
- **URL**: https://altera-fpga.github.io/latest/embedded-designs/agilex-7/f-series/soc/gsrd/ug-gsrd-agx7f-soc/

## Hard Processor System (HPS)
This design's HPS configuration matches the board schematic.
Refer to [Agilex 7 Hard Processor System Technical Reference Manual](https://docs.altera.com/r/docs/683567/current) and [Agilex 7 Hard Processor System Component Reference Manual](https://docs.altera.com/r/docs/683581/current) for more information on HPS configuration.

## HPS External Memory Interfaces (EMIF)
This design's HPS EMIF configuration matches the board schematic.
Refer to [External Memory Interfaces Agilex 7 F-Series and I-Series FPGA IP User Guide](https://docs.altera.com/r/docs/683216/current) for more information on HPS EMIF configuration.

## HPS-to-FPGA Address Map
The MPU region provides windows of 4 GB into the FPGA slave address space. The lower 1.5 GB of this space is mapped to two separate addresses — firstly from 0x8000_0000 to 0xDFFF_FFFF and secondly from 0x20_0000_0000 to 0x20_5FFF_FFFF. The following table lists the offset of each peripheral from the HPS-to-FPGA bridge in the FPGA portion of the SoC.

Refer to [Agilex 7 Hard Processor System Address Map and Register Definitions](https://docs.altera.com/v/u/resources/747593/agilextm-7-fpga-hard-processor-system-hps-address-map-and-definitions-register-map) for details.

| Peripheral | Address Offset | Size (bytes) | Attribute |
| :-- | :-- | :-- | :-- |
| ocm | 0x0 | 256K | On-chip RAM as scratch pad |

## System peripherals
The memory map of system peripherals in the FPGA portion of the SoC as viewed by the MPU (Cortex-A53), which starts at the lightweight HPS-to-FPGA base address of 0xF900_0000, is listed in the following table.

Note:
- All interrupt sources are also connected to an interrupt latency counter (ILC) module in the system, which enables System Console to be aware of the interrupt status of each peripheral in the FPGA portion of the SoC.

There are **4 LED outputs**, **4 DIP switch inputs**, and **4 push-button inputs** connected to FPGA pins on this development kit.

#### Lightweight HPS-to-FPGA Address Map

| Peripheral | Address Offset | Size (bytes) | Attribute | Interrupt Num |
| :-- | :-- | :-- | :-- | :-- |
| sysid | 0x0000_0000 | 8 | Unique system ID   | None |
| led_pio | 0x0000_1080 | 16 | LED outputs   | None |
| button_pio | 0x0000_1060 | 16 | Push button inputs | 1 |
| dipsw_pio | 0x0000_1070 | 16 | DIP switch inputs | 0 |
| ILC | 0x0000_1100 | 256 | Interrupt latency counter | None |

Note:
- The most significant bit of the LED is used in the design top module as heartbeat LED. This LED blinks when the FPGA design is loaded. Users will not be able to control this LED with HPS software, for example U-Boot or Linux.


#### Lightweight HPS-to-FPGA Address Map for Partial Reconfiguration (PR)
A PR region was created in the FPGA fabric, with the following associated IP:
- PR Freeze Controller (frz_ctrl_0) — to help control the PR
- Avalon-MM PR Freeze Bridge (frz_bdg_0) — to help isolate the IP in the PR region during the PR process

The base revision of the project (persona 0) has the following in the PR region, accessed via frz_bdg_0:
- SysID located at 0xF900_0800: with id=0xcafeface
- OCRAM located at 0xF900_0900

An alternate revision of the project (persona 1) contains the following in the PR region:
- SysID located at 0xF900_0900: with id=0xfacecafe
- OCRAM located at 0xF900_0800

| Peripheral | Address Offset | Size (bytes) | Attribute | Interrupt Num |
| :-- | :-- | :-- | :-- | :-- |
| frz_ctrl_0 | 0x0000_0450 | 16 | freeze controller CSR | 11 |
| frz_bdg_0 | 0x0000_0800 | 3K | freeze bridge CSR | None |

## JTAG master interfaces
The JTAG master interfaces allow you to access peripherals in the FPGA with System Console, through the JTAG master module. This access does not rely on HPS software drivers.

Refer to this [Guide](https://docs.altera.com/r/docs/683819/26.1/quartus-prime-pro-edition-user-guide-debug-tools/analyzing-and-debugging-designs-with-system-console) for information about System Console.

## Interrupt Num
The Interrupt Num in this readme are FPGA IRQ. They have offset of 17 when mapped to Generic Interrupt Controller (GIC) in device tree structure (dts). Refer to F2H FPGA Interrupt[0] in [GIC Interrupt Map for the SoC HPS](https://docs.altera.com/r/docs/683567/25.3.1/agilextm-7-hard-processor-system-technical-reference-manual/gic-interrupt-map-for-the-soc-hps).
Number 49 is shown for F2H FPGA Interrupt[0] as the first 32 IRQ is reserved. (49 - 32 = 17).

## Hardware build

From **this design directory**, generate, prepare, and compile the design with Quartus on `PATH`:

```bash
make build
```

Alternatively, open `top.qpf` in Quartus Prime and run a full compilation. Bitstreams and the core RBF are written to `output_files/` when the build completes.

## Binaries location
After build, the design files (sof and rbf) can be found in the `output_files/` folder.

## Yocto Build Setup Guide
1. Refer to [Yocto Linux Build Instructions](software/yocto_linux/README.md#yocto-build) file and follow the steps to build Yocto.

After build, the binaries can be found in the `software/yocto_linux_sd` or `software/yocto_linux_qspi` folder.
