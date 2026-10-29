# Create rules for baseline subdir
TARGET_SUBDIR := baseline
$(eval $(call create_targets_on_subdir, $(TARGET_SUBDIR)))
$(foreach target, $(shell make --no-print-directory -q -C $(TARGET_SUBDIR) print-sw-targets), $(eval $(call create_sw_targets_on_subdir, $(TARGET_SUBDIR), $(target))))

# Create rules for sgmii subdir
TARGET_SUBDIR := sgmii
$(eval $(call create_targets_on_subdir, $(TARGET_SUBDIR)))
$(foreach target, $(shell make --no-print-directory -q -C $(TARGET_SUBDIR) print-sw-targets), $(eval $(call create_sw_targets_on_subdir, $(TARGET_SUBDIR), $(target))))

# Create rules for pr subdir
TARGET_SUBDIR := pr
$(eval $(call create_targets_on_subdir, $(TARGET_SUBDIR)))
$(foreach target, $(shell make --no-print-directory -q -C $(TARGET_SUBDIR) print-sw-targets), $(eval $(call create_sw_targets_on_subdir, $(TARGET_SUBDIR), $(target))))

