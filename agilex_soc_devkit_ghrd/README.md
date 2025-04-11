# Agilex Golden Hardware Reference Design (GHRD)

The GHRD is part of the Golden System Reference Design (GSRD), which provides a complete solution, including exercising soft IP in the fabric, booting to U-Boot, then Linux, and running sample Linux applications.

## Build Steps
1) Customize the GHRD settings in Makefile. Only necessary when the defaults are not suitable.
2) Generate the Quartus Project and source files.
   - Use target from [Supported Designs](#supported-designs)
3) Compile Quartus Project and generate the configuration file
   - $ `make sof` or $ `make all`

## Supported Designs
### Platform: Intel Agilex 7 FPGA F-Series Transceiver-SoC Development Kit
There are **4 LED outputs**, **4 DIP switch inputs** and **4 push-button inputs** on the Development Kit, which are connected fpga pin.
#### Baseline
This design boots from SD/MMC.
```bash
make generate-agf014eb-si-devkit-oobe-baseline
```
#### NAND
This design boots from NAND.
```bash
make generate-agf014eb-si-devkit-nand-baseline
```
#### Partial Reconfiguration (PR)
This design boots from SD/MMC and demonstrates partial reconfiguration.
```bash
make generate-agf014eb-si-devkit-oobe-pr
```
### Platform: Altera Agilex F-Series FPGA Development Kit
There are **4 LED outputs** on the Development Kit, which are connected fpga pin.
#### Baseline
This design boots from SD/MMC.
```bash
make generate-agf027f1es-soc-devkit-oobe-baseline
```

### Platform: Intel Agilex 7 FPGA I-Series Transceiver-SoC Development Kit
There are **8 LED outputs**, **8 DIP switch inputs** and **2 push-button inputs** on the Development Kit, which are connected fpga pin.<br>
Note: There are several versions for this Development Kit. They can be identified with the Ordering Code in brackets.
#### Baseline (DK-SI-AGI027FC)
This design boots from SD/MMC.
```bash
make generate-agi027fc-si-devkit-oobe-baseline
```

### Platform: Intel Agilex 7 FPGA M-Series Development Kit - HBM2e Edition
There are **4 LED outputs** on the Development Kit, which are connected fpga pin.
#### Baseline
This design boots from SD/MMC.
```bash
make generate-agm039fes-soc-devkit-oobe-baseline
```

## GHRD Overview

### Hard Processor System (HPS)
The GHRD HPS configuration matches the board schematic. Refer to [Agilex 7 Hard Processor System Technical Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/683567/current) and [Intel Agilex 7 Hard Processor System Component Reference Manual](https://www.intel.com/content/www/us/en/docs/programmable/683581/current) for more information on HPS configuration.

### HPS External Memory Interfaces (EMIF)
The GHRD HPS EMIF configuration matches the board schematic. Refer to
[External Memory Interfaces Agilex 7 F-Series and I-Series FPGA IP User Guide](https://www.intel.com/content/www/us/en/docs/programmable/683216/current) for more information on HPS EMIF configuration.

### HPS-to-FPGA Address Map for all designs
The MPU region provide windows of 4 GB into the FPGA slave address space. The lower 1.5 GB of this space is mapped to two separate addresses - firstly from 0x8000_0000 to 0xDFFF_FFFF and secondly from 0x20_0000_0000 to 0x20_5FFF_FFFF. The following table lists the offset of each peripheral from the HPS-to-FPGA bridge in the FPGA portion of the SoC.

Refer to [Intel Agilex 7 Hard Processor System Address Map and Register Definitions](https://www.intel.com/content/www/us/en/programmable/hps/agilex7/hps.html) for details.

| Peripheral | Address Offset | Size (bytes) | Attribute |
| :-- | :-- | :-- | :-- |
| ocm | 0x0 | 256K | On-chip RAM as scratch pad |

### System peripherals
The the memory map of system peripherals in the FPGA portion of the SoC as viewed by the MPU (Cortex-A53), which starts at the lightweight HPS-to-FPGA base address of 0xF900_0000, is listed in the following table.

Note: 
- All interrupt sources are also connected to an interrupt latency counter (ILC) module in the system, which enables System Console to be aware of the interrupt status of each peripheral in the FPGA portion of the SoC.
- Each Development Kit have different number of LED outputs, push button inputs and DIP switch inputs. They are documented in individual platform of [Supported Designs](#supported-designs).

#### Lightweight HPS-to-FPGA Address Map for all designs
| Peripheral | Address Offset | Size (bytes) | Attribute | Interrupt Num |
| :-- | :-- | :-- | :-- | :-- |
| sysid | 0x0000_0000 | 8 | Unique system ID   | None |
| led_pio | 0x0000_1080 | 16 | LED outputs   | None |
| button_pio | 0x0000_1060 | 16 | Push button inputs | 1 |
| dipsw_pio | 0x0000_1070	 | 16 | DIP switch inputs | 0 |
| ILC | 0x0000_1100 | 256 | Interrupt latency counter | None |

Note:
- The most significant bit of the LED is used in GHRD top module as heartbeat led. This LED blinks when the fpga design is loaded. Users will not be able to control this LED with HPS software, for example U-Boot or Linux.

#### Lightweight HPS-to-FPGA Address Map for (PR) design
A PR region was created in the FPGA fabric, with the following associated IP
PR Freeze Controller(frz_ctrl_0) - to help control the PR
Avalon-MM PR Freeze Bridge(frz_bdg_0) - to help isolate the IP in the PR region during the PR process

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

### JTAG master interfaces
The GHRD JTAG master interfaces allows you to access peripherals in the FPGA with System Console, through the JTAG master module. This access does not rely on HPS software drivers.

Refer to this [Guide](https://www.intel.com/content/www/us/en/docs/programmable/683819/current/analyzing-and-debugging-designs-with-84752.html) for information about system console.

### Interrupt Num
The Interrupt Num in this readme are FPGA IRQ. They have offset of 17 when mapped to Generic Interrupt Controller (GIC) in device tree structure(dts). Refer to F2H FPGA Interrupt[0] in [GIC Interrupt Map for the SoC HPS](intel.com/content/www/us/en/docs/programmable/683567/24-3/hard-processor-system-technical-reference.html).
Number 49 is shown for F2H FPGA Interrupt[0] as the first 32 IRQ is reserved. (49 - 32 = 17).

## Binaries location
After build, the design files (sof and rbf) can be found in output_files folder.
