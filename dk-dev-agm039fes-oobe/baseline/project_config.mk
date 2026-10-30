# Define the Quartus project name
PROJECT_NAME := top

#Define the Quartus revision names
REVISION_NAMES := \
	baseline \

# Define the base revision
BASE_REVISION := $(firstword $(REVISION_NAMES))

# Enable functional simulation
SIM_ENABLED := 0

# Disable strict validation of README.md (DK-DEV-AGM039FES not yet in Quartus kit list)
NO_ENFORCE_README_VALIDATION := 1
