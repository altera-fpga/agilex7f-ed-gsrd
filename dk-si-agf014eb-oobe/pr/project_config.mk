# Define the Quartus project name
PROJECT_NAME := top

#Define the Quartus revision names
REVISION_NAMES := \
	pr \
	alternate_persona

# Define the base revision
BASE_REVISION := $(firstword $(REVISION_NAMES))

# Enable functional simulation
SIM_ENABLED := 0

# Enforce build ordering for Partial Reconfiguration: the base revision must be
# fully compiled before the persona revision starts, since alternate_persona.qsf
# imports the static region (QDB_FILE_PARTITION) produced by the base compile.
output_files/alternate_persona.sof: output_files/pr.sof

###############################################################################
#                     PR Persona RBF/PMSF Install (renamed)
###############################################################################
# Quartus generates <revision>.pr_partition_0.{rbf,pmsf} during the normal compile.
# The farm expects them renamed to the design-qualified name:
#   pr.pr_partition_0.rbf                      -> dk-si-agf014eb-oobe_pr_persona0.rbf
#   pr.pr_partition_0.pmsf                     -> dk-si-agf014eb-oobe_pr_persona0.pmsf
#   alternate_persona.pr_partition_0.rbf     -> dk-si-agf014eb-oobe_pr_persona1.rbf
#   alternate_persona.pr_partition_0.pmsf    -> dk-si-agf014eb-oobe_pr_persona1.pmsf
# Only the renamed versions are stored on the farm (originals are not installed).
DESIGN_ID := dk-si-agf014eb-oobe_pr

pr-install-sof : $(INSTALL_ROOT_BINARIES)/$(DESIGN_ID)_persona0.rbf \
                 $(INSTALL_ROOT_BINARIES)/$(DESIGN_ID)_persona0.pmsf

$(INSTALL_ROOT_BINARIES)/$(DESIGN_ID)_persona0.rbf : output_files/pr.pr_partition_0.rbf | $(INSTALL_ROOT_BINARIES)
	cp -f $< $@

$(INSTALL_ROOT_BINARIES)/$(DESIGN_ID)_persona0.pmsf : output_files/pr.pr_partition_0.pmsf | $(INSTALL_ROOT_BINARIES)
	cp -f $< $@

alternate_persona-install-sof : $(INSTALL_ROOT_BINARIES)/$(DESIGN_ID)_persona1.rbf \
                                 $(INSTALL_ROOT_BINARIES)/$(DESIGN_ID)_persona1.pmsf

$(INSTALL_ROOT_BINARIES)/$(DESIGN_ID)_persona1.rbf : output_files/alternate_persona.pr_partition_0.rbf | $(INSTALL_ROOT_BINARIES)
	cp -f $< $@

$(INSTALL_ROOT_BINARIES)/$(DESIGN_ID)_persona1.pmsf : output_files/alternate_persona.pr_partition_0.pmsf | $(INSTALL_ROOT_BINARIES)
	cp -f $< $@
