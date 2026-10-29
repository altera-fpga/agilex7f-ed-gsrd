# Agilex 7 Baseline Hardware Reference Designs

This repository contains Baseline Hardware Reference Designs for Altera Agilex 7 System On Chip (SoC) FPGA.
This repository is part of the Baseline System Example Design, which provides a complete solution, including exercising soft IP in the fabric, booting to U-Boot, then Linux, and running sample Linux applications.

Refer to these links for more information.
- [HPS Baseline System Example Design User Guide: Agilex 7 F-Series SoC Development Kit](https://altera-fpga.github.io/latest/embedded-designs/agilex-7/f-series/soc/gsrd/ug-gsrd-agx7f-soc/)
- [HPS Baseline System Example Design User Guide: Agilex 7 F-Series FPGA Development Kit](https://altera-fpga.github.io/latest/embedded-designs/agilex-7/f-series/fpga/gsrd/ug-gsrd-agx7f-fpga/)
- [HPS Baseline System Example Design User Guide: Agilex 7 I-Series SoC Development Kit](https://altera-fpga.github.io/latest/embedded-designs/agilex-7/i-series/soc/gsrd/ug-gsrd-agx7i-soc/)
- [HPS Baseline System Example Design User Guide: Agilex 7 M-Series HBM2e Development Kit](https://altera-fpga.github.io/latest/embedded-designs/agilex-7/m-series/hbm2e/ug-gsrd-agx7m-hbm2e/)

The [designs](#designs) are stored in individual folders. Each design can be opened, modified and compiled by using Quartus Prime software.
Repository releases are tagged for each version of Quartus Prime Software. It is recommended to use the release for your version of Quartus Prime.
These designs demonstrate the system integration between Hard Processor System (HPS) and FPGA IPs.

## Baseline feature
This is applicable to all designs.
- Hard Processor System enablement and configuration
  - HPS Peripheral and I/O (eg, NAND, SD/MMC, EMAC, USB, SPI, I2C, UART, and GPIO — depends on the daughter card)
  - HPS Clock and Reset
  - HPS FPGA Bridge and Interrupt
- HPS EMIF configuration
- System integration with FPGA IPs
  - SYSID
  - Programmable I/O (PIO) IP for controlling DIPSW, PushButton, and LEDs
  - FPGA On-Chip Memory

## Advanced feature
This is only applicable if the feature is enabled.
- Partial Reconfiguration (PR)
- HPS Serial Gigabit Media Independent Interface (SGMII) with HPS EMAC and Triple-Speed Ethernet Intel FPGA IP (PHY)

## Dependency
* Altera Quartus Prime 26.3
* Supported Altera Development Kit
  - Agilex 7 FPGA F-Series Transceiver-SoC Development Kit DK-SI-AGF014EB
  - Agilex 7 FPGA F-Series Development Kit - 2F Tile Crypto DK-DEV-AGF023FA
  - Agilex 7 FPGA I-Series Transceiver-SoC Development Kit DK-SI-AGI027FC / DK-SI-AGI027FD
  - Agilex 7 FPGA M-Series Development Kit - HBM2e Edition DK-DEV-AGM039FES / DK-DEV-AGM039EA

## Tested platform for the hardware build flow
* SUSE Linux Enterprise Server 15 SP4

## Setup

Several tools are required to be in the path.

* Altera Quartus Prime 26.3
* Python 3.11.5 (only required when using command line to build)

### Example Setup for Altera Quartus Prime tools
This is recommended, when using command line to build.
```bash
export QUARTUS_ROOTDIR=~/alteraFPGA_pro/26.3/quartus
```
Note: Adapt the path above to where Quartus Prime is installed.

```bash
export PATH="$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/../qsys/bin:$QUARTUS_ROOTDIR/../niosv/bin:$QUARTUS_ROOTDIR/sopc_builder/bin:$QUARTUS_ROOTDIR/../questa_fe/bin:$QUARTUS_ROOTDIR/../syscon/bin:$QUARTUS_ROOTDIR/../riscfree/RiscFree:$PATH"
```

## Quick start

### Using command line

1. Choose a design under [designs](#designs) for your development kit.
2. Change to that design directory. Example:

```bash
cd dk-si-agf014eb-oobe/baseline
```

3. Follow the README in that directory for command-line build steps.

### Using Quartus GUI
- Launch Quartus.
- Open the project. Example: dk-si-agf014eb-oobe/baseline/top.qpf
- Click the play button to compile the design.
- The compiled sof can be found in output_files folder of the project path.

### Notes
- Command line and Quartus GUI should not be used intertwined.
- Mixing both design build flows might not generate some fileset correctly and fail the build.


## Designs

This section lists **every** shipped design in the repository, grouped by development kit.
Search here to find which platform folder hosts a design (for example `baseline`, `pr`, or
`sgmii`). Each bullet links to that design's README for build instructions and
functional detail; use the platform index link for devkit context and the design list on that
platform.

### Agilex 7 FPGA F-Series Transceiver-SoC Development Kit DK-SI-AGF014EB

Platform index: [dk-si-agf014eb-oobe](dk-si-agf014eb-oobe/README.md)

Refer to the individual README for details of each design.

* [dk-si-agf014eb-oobe/baseline](dk-si-agf014eb-oobe/baseline/README.md) :
  HPS Baseline System Example Design for the F-Series Transceiver-SoC Development Kit with HPS OOBE daughter card.
  This design boots from SD/MMC.

* [dk-si-agf014eb-oobe/pr](dk-si-agf014eb-oobe/pr/README.md) :
  HPS Partial Reconfiguration System Example Design for the F-Series Transceiver-SoC Development Kit with HPS OOBE daughter card.
  This design boots from SD/MMC.

* [dk-si-agf014eb-oobe/sgmii](dk-si-agf014eb-oobe/sgmii/README.md) :
  HPS SGMII System Example Design for the F-Series Transceiver-SoC Development Kit with HPS OOBE daughter card.
  This design enables SGMII with HPS EMAC and Triple-Speed Ethernet Intel FPGA IP.

Platform index: [dk-si-agf014eb-nand](dk-si-agf014eb-nand/README.md)

* [dk-si-agf014eb-nand/baseline](dk-si-agf014eb-nand/baseline/README.md) :
  HPS Baseline System Example Design with NAND Boot for the F-Series Transceiver-SoC Development Kit.
  This design boots from NAND.

Platform index: [dk-si-agf014eb-emmc](dk-si-agf014eb-emmc/README.md)

* [dk-si-agf014eb-emmc/baseline](dk-si-agf014eb-emmc/baseline/README.md) :
  HPS Baseline System Example Design with eMMC Boot for the F-Series Transceiver-SoC Development Kit.
  This design boots from eMMC.

### Agilex 7 FPGA I-Series Transceiver-SoC Development Kit

There are several kit revisions; identify them by ordering code.

Platform index: [dk-si-agi027fc-oobe](dk-si-agi027fc-oobe/README.md)

* [dk-si-agi027fc-oobe/baseline](dk-si-agi027fc-oobe/baseline/README.md) :
  HPS Baseline System Example Design for the I-Series Transceiver-SoC Development Kit DK-SI-AGI027FC.
  This design boots from SD/MMC.

Platform index: [dk-si-agi027fd-oobe](dk-si-agi027fd-oobe/README.md)

* [dk-si-agi027fd-oobe/baseline](dk-si-agi027fd-oobe/baseline/README.md) :
  HPS Baseline System Example Design for the I-Series Transceiver-SoC Development Kit DK-SI-AGI027FD.
  This design boots from SD/MMC.

### Agilex 7 FPGA M-Series Development Kit - HBM2e Edition

Platform index: [dk-dev-agm039fes-oobe](dk-dev-agm039fes-oobe/README.md)

* [dk-dev-agm039fes-oobe/baseline](dk-dev-agm039fes-oobe/baseline/README.md) :
  HPS Baseline System Example Design for the M-Series Development Kit DK-DEV-AGM039FES.
  HPS uses DDR5; HBM2E is not enabled.

Platform index: [dk-dev-agm039ea-oobe](dk-dev-agm039ea-oobe/README.md)

* [dk-dev-agm039ea-oobe/baseline](dk-dev-agm039ea-oobe/baseline/README.md) :
  HPS Baseline System Example Design for the M-Series Development Kit DK-DEV-AGM039EA.
  HPS uses HBM2e; DDR5 is not enabled.

### Agilex 7 FPGA F-Series Development Kit - 2F Tile Crypto DK-DEV-AGF023FA

Platform index: [dk-dev-agf023fa-oobe](dk-dev-agf023fa-oobe/README.md)

* [dk-dev-agf023fa-oobe/baseline](dk-dev-agf023fa-oobe/baseline/README.md) :
  HPS Baseline System Example Design for the F-Series Development Kit DK-DEV-AGF023FA.
  This design boots from SD/MMC.
