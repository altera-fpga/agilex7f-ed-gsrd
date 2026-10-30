SUMMARY = "Altera SoCFPGA Bitstream"
DESCRIPTION = "Custom FPGA bitstream for SOC Development Kit"
SECTION = "bsp"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

python () {
    if not d.getVar('FPGA_ENABLE_CORE_PGM'):
        raise bb.parse.SkipRecipe("FPGA Enable Core Programming option is not set!")
}

SRC_URI:append = " \
    file://persona0.rbf \
    file://persona1.rbf \
"

do_install:append() {
    install -d ${D}${base_libdir}/firmware
    install -m 0644 ${UNPACKDIR}/persona0.rbf ${D}${base_libdir}/firmware/
    install -m 0644 ${UNPACKDIR}/persona1.rbf ${D}${base_libdir}/firmware/
}

FILES:${PN} += "${base_libdir}/firmware/persona0.rbf ${base_libdir}/firmware/persona1.rbf"
