# Agilex 7 Golden Hardware Reference Design (GHRD)

The GHRD is part of the Golden System Reference Design (GSRD), which provides a complete solution, including exercising soft IP in the fabric, booting to U-Boot, then Linux, and running sample Linux applications.

Refer to the these links for more information on Agilex 7 GSRD.
- [F-Series SoC Development Kit GSRD](https://altera-fpga.github.io/latest/embedded-designs/agilex-7/f-series/soc/gsrd/ug-gsrd-agx7f-soc/)
- [F-Series FPGA Development Kit GSRD](https://altera-fpga.github.io/latest/embedded-designs/agilex-7/f-series/fpga/gsrd/ug-gsrd-agx7f-fpga/)
- [I-Series SoC Development Kit GSRD](https://altera-fpga.github.io/latest/embedded-designs/agilex-7/i-series/soc/gsrd/ug-gsrd-agx7i-soc/)
- [M-Series HBM2e Development Kit GSRD](https://altera-fpga.github.io/latest/embedded-designs/agilex-7/m-series/hbm2e/ug-gsrd-agx7m-hbm2e/)

This reference design demonstrating the following system integration between Hard Processor System (HPS) and FPGA IPs:
## Baseline feature
This is applicable to all designs.
- Hard Processor System enablement and configuration
  - HPS Peripheral and I/O (eg, NAND, SD/MMC, EMAC, USB, SPI, I2C, UART, and GPIO)
  - HPS Clock and Reset
  - HPS FPGA Bridge and Interrupt
- HPS EMIF configuration
- System integration with FPGA IPs
  - SYSID
  - Programmable I/O (PIO) IP for controlling DIPSW, PushButton, and LEDs)
  - FPGA On-Chip Memory
## Advanced feature
  - Partial Reconfiguration

## Dependency
* Altera Quartus Prime 26.1
* Supported Board
  - Altera Agilex 7 FPGA F-Series Transceiver-SoC Development Kit
  - Altera Agilex F-Series FPGA Development Kit
  - Altera Agilex 7 FPGA I-Series Transceiver-SoC Development Kit
  - Altera Agilex 7 FPGA M-Series Development Kit - HBM2e Edition

## Tested Platform for the GHRD Make flow
* SUSE Linux Enterprise Server 15 SP4

## Supported Designs
### Platform: Altera Agilex 7 FPGA F-Series Transceiver-SoC Development Kit
#### Baseline
This design boots from SD/MMC.
HPS EMIF ECC is enabled by default.

```bash
make agf014eb-si-devkit-oobe-baseline-all
```
#### NAND
This design boots from NAND.
HPS EMIF ECC is enabled by default.

```bash
make agf014eb-si-devkit-nand-baseline-all
```
#### Partial Reconfiguration (PR)
This design boots from SD/MMC and demonstrates partial reconfiguration.
HPS EMIF ECC is enabled by default.

```bash
make agf014eb-si-devkit-oobe-pr-all
```
#### EMMC
This design boots from EMMC.
HPS EMIF ECC is enabled by default.

```bash
make agf014eb-si-devkit-emmc-baseline-all
```
#### HPS Serial Gigabit Media Independent Interface (SGMII)
This design boots from SD/MMC and enabled SGMII with HPS EMAC and Triple-Speed Ethernet Intel FPGA IP (PHY).
HPS EMIF ECC is enabled by default.

```bash
make agf014eb-si-devkit-oobe-sgmii-all
```

### Platform: Altera Agilex 7 FPGA I-Series Transceiver-SoC Development Kit
Note: There are several versions for this Development Kit. They can be identified with the Ordering Code in brackets.
#### Baseline (DK-SI-AGI027FC)
This design boots from SD/MMC.
```bash
make agi027fc-si-devkit-oobe-baseline-all
```
#### Baseline (DK-SI-AGI027FD)
This design boots from SD/MMC.
**Note: This design successfully meets Quartus compilation and timing requirements, but has not yet been validated on hardware.**
```bash
make agi027fd-si-devkit-oobe-baseline-all
```

### Platform: Altera Agilex 7 FPGA M-Series Development Kit - HBM2e Edition
#### Baseline (DK-DEV-AGM039FES)
This design boots from SD/MMC.
It also intantiates External Memory Interfaces IP for Hard Processor System to access the DDR5 memory.
HPS uses **DDR5** as memory and the High Bandwidth Memory (HBM2E) is **not enabled**.
HPS EMIF ECC is **not enabled** for this design.
```bash
make agm039fes-soc-devkit-oobe-baseline-all
```

#### Baseline (DK-DEV-AGM039EA)
This design boots from from SD/MMC.
It also intantiates High Bandwidth Memory (HBM2E) Interface Agilex 7 IP to access the in-package HBM2e memory.
HPS uses **HBM2e** as memory and the DDR5 memory is **not enabled**.
HBM ECC is **enabled** for this design
```bash
make agm039ea-soc-devkit-oobe-baseline-all
```


### Platform: Altera Agilex 7 FPGA F-Series Development Kit - 2F Tile Crypto
#### Baseline (DK-DEV-AGF023FA)
This design boots from SD/MMC.
HPS EMIF ECC is enabled by default.

```bash
make agf023fa-soc-devkit-oobe-baseline-all
```

## Install location
After build, the design files (zip, sof and rbf) can be found in install/designs folder.