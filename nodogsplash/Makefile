#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=nodogsplash
PKG_FIXUP:=autoreconf
PKG_VERSION:=0.9_beta9.9.9
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)/
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=git://github.com/nodogsplash/nodogsplash.git
PKG_SOURCE_VERSION:=650c92933318b846ffe834ecd14e772e200108d8
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk


define Package/nodogsplash
	SUBMENU:=Captive Portals
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+libpthread +iptables-mod-ipopt
	TITLE:=Open public network gateway daemon
	URL:=https://github.com/nodogsplash/nodogsplash
endef

define Package/nodogsplash/description
	Nodogsplash offers a simple way to open a free hotspot providing
	restricted access to an internet connection.
endef

define Package/nodogsplash/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/nodogsplash $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ndsctl $(1)/usr/bin/

	$(CP) ./files/* $(1)/
	$(SED) 's,\(do_module_tests "imq"\),#\1,' $(1)/etc/init.d/$(PKG_NAME)
	$(SED) 's,\(do_module_tests "ipt_IMQ"\),#\1,' $(1)/etc/init.d/$(PKG_NAME)
	$(SED) 's,\(do_module_tests "sch_htb"\),#\1,' $(1)/etc/init.d/$(PKG_NAME)
endef


$(eval $(call BuildPackage,nodogsplash))
