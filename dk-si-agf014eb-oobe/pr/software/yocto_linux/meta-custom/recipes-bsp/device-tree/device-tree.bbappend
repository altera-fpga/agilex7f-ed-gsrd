FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://agilex7_pr_fpga_static_region.dts \
    file://agilex7_pr_persona0.dts \
    file://agilex7_pr_persona1.dts \
"

PR_DTBO_FILES = "agilex7_pr_fpga_static_region agilex7_pr_persona0 agilex7_pr_persona1"

# Base device-tree.bb leaves do_install empty; compile PR overlays here.
do_compile() {
    for dts in ${PR_DTBO_FILES}; do
        dtc -@ -I dts -O dtb -o ${B}/${dts}.dtbo ${UNPACKDIR}/${dts}.dts
    done
}

do_install:append() {
    install -d ${D}/boot/devicetree
    for dtbo in ${PR_DTBO_FILES}; do
        install -m 0644 ${B}/${dtbo}.dtbo ${D}/boot/devicetree/
    done
}

FILES:${PN} += "/boot/devicetree/*.dtbo"
