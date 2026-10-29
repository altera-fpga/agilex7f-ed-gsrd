# Agilex 7 FPGA F-Series Transceiver-SoC Development Kit (DK-SI-AGF014EB) — HPS OOBE

Platform folder `dk-si-agf014eb-oobe` contains designs for the Agilex 7 FPGA F-Series Transceiver-SoC Development Kit (DK-SI-AGF014EB) with the HPS Out of Box Experience (OOBE) daughter card.

Refer to the [HPS Baseline System Example Design User Guide: Agilex 7 F-Series SoC Development Kit](https://altera-fpga.github.io/latest/embedded-designs/agilex-7/f-series/soc/gsrd/ug-gsrd-agx7f-soc/) for more information.

## Designs

| Design | Description |
|--------|-------------|
| [baseline](baseline/README.md) | Baseline design; boots from SD/MMC. HPS EMIF ECC is enabled by default. |
| [pr](pr/README.md) | Partial Reconfiguration design; boots from SD/MMC. |
| [sgmii](sgmii/README.md) | SGMII design; boots from SD/MMC with HPS EMAC and Triple-Speed Ethernet Intel FPGA IP. |
