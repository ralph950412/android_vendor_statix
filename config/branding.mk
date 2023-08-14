#
# Copyright (C) 2018-2022 StatiXOS
#
# SPDX-License-Identifier: Apache-2.0
#

# Set date and time
BUILD_DATE := $(shell date +%Y%m%d)

## Versioning System
# Set all versions
STATIX_BASE_VERSION := v6.3
STATIX_PLATFORM_VERSION := 13

BUILD_ID_LC ?= $(shell echo $(BUILD_ID) | tr '[:upper:]' '[:lower:]')

# Use signing keys and don't print date & time in the final zip for official builds
ifndef STATIX_BUILD_TYPE
    STATIX_BUILD_TYPE := UNOFFICIAL
endif

ifeq ($(STATIX_BUILD_TYPE),OFFICIAL)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := ./.keys/releasekey
    STATIX_VERSION := $(TARGET_PRODUCT)-$(BUILD_DATE)-$(STATIX_PLATFORM_VERSION)-$(STATIX_BASE_VERSION)-$(STATIX_BUILD_TYPE)
else
    STATIX_VERSION := $(TARGET_PRODUCT)-$(BUILD_DATE)-$(STATIX_PLATFORM_VERSION)-$(STATIX_BASE_VERSION)-$(STATIX_BUILD_TYPE)
endif

# Fingerprint
ROM_FINGERPRINT := StatiXOS/$(PLATFORM_VERSION)/$(STATIX_BUILD_TYPE)/$(BUILD_DATE)
# Declare it's a StatiX build
STATIX_BUILD := true

$(call inherit-product-if-exists, vendor/statix/build/target/product/security/statix_security.mk)

PRODUCT_HOST_PACKAGES += \
    sign_target_files_apks \
    ota_from_target_files
