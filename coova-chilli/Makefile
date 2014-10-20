#
# Copyright (C) 2007-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=coova-chilli
PKG_VERSION:=1.3.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://coova-chilli.s3.amazonaws.com/
PKG_MD5SUM:=dc0037e3cdebcb60508081b4e42e984a

include $(INCLUDE_DIR)/package.mk

define Package/coova-chilli
  SUBMENU:=Captive Portals
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+kmod-tun +librt +haserl
  TITLE:=Wireless LAN HotSpot controller
  URL:=http://www.coova.org/
  MENU:=1
endef

define Package/coova-chilli/description
	CoovaChilli is an open source access controller for wireless LAN
	access points and is based on ChilliSpot. It is used for authenticating
	users of a wireless (or wired) LAN. It supports web based login (UAM)
	which is today's standard for public HotSpots and it supports Wireless Protected
	Access (WPA) which is the standard of the future. Authentication,
	authorization and accounting (AAA) is handled by your favorite
	radius server.
endef

define Package/coova-chilli/config
	source "$(SOURCE)/Config.in"
endef

ifneq ($(CONFIG_COOVACHILLI_COA),)
	CONFIGURE_ARGS += --enable-coa
else
	CONFIGURE_ARGS += --disable-coa
endif

ifneq ($(CONFIG_COOVACHILLI_UAMDOMAINFILE),)
	CONFIGURE_ARGS += --enable-uamdomainfile
else
	CONFIGURE_ARGS += --disable-uamdomainfile
endif

ifneq ($(CONFIG_COOVACHILLI_LAYER3),)
	CONFIGURE_ARGS += --enable-layer3
else
	CONFIGURE_ARGS += --disable-layer3
endif

ifneq ($(CONFIG_COOVACHILLI_CHILLIPROXY),)
	CONFIGURE_ARGS += --enable-chilliproxy
else
	CONFIGURE_ARGS += --disable-chilliproxy
endif

ifneq ($(CONFIG_COOVACHILLI_MULTIROUTE),)
	CONFIGURE_ARGS += --enable-multiroute
else
	CONFIGURE_ARGS += --disable-multiroute
endif

ifneq ($(CONFIG_COOVACHILLI_MULTILAN),)
	CONFIGURE_ARGS += --enable-multilan
else
	CONFIGURE_ARGS += --disable-multilan
endif

ifneq ($(CONFIG_COOVACHILLI_CHILLIREDIR),)
	CONFIGURE_ARGS += --enable-chilliredir
else
	CONFIGURE_ARGS += --disable-chilliredir
endif

ifneq ($(CONFIG_COOVACHILLI_MINIPORTAL),)
	CONFIGURE_ARGS += --enable-miniportal
else
	CONFIGURE_ARGS += --disable-miniportal
endif

ifneq ($(CONFIG_COOVACHILLI_REDIRINJECT),)
	CONFIGURE_ARGS += --enable-redirinject
else
	CONFIGURE_ARGS += --disable-redirinject
endif

#define Build/Configure
#	(cd $(PKG_BUILD_DIR); rm -rf config.{cache,status} ; \
#		$(TARGET_CONFIGURE_OPTS) \
#                CFLAGS="$(strip $(TARGET_CFLAGS)) -DNEED_DN_SKIPNAME" \
#                CPPFLAGS="-I$(STAGING_DIR)/usr/include -I$(STAGING_DIR)/include" \
#                LDFLAGS="-L$(STAGING_DIR)/usr/lib -L$(STAGING_DIR)/lib" \
#		ac_cv_func_malloc_0_nonnull=yes \
#		ac_cv_func_realloc_0_nonnull=yes \
#		ac_cv_func_memcmp_working=yes \
#		ac_cv_func_setvbuf_reversed=no \
#                ./configure \
#			--target=$(GNU_TARGET_NAME) \
#			--host=$(GNU_TARGET_NAME) \
#			--build=$(GNU_HOST_NAME) \
#			--program-prefix="" \
#			--program-suffix="" \
#			--prefix=/usr \
#			--sysconfdir=/etc \
#			--exec-prefix=/usr \
#			--bindir=/usr/bin \
#			--datadir=/usr/share \
#			--includedir=/usr/include \
#			--infodir=/usr/share/info \
#			--libdir=/usr/lib \
#			--libexecdir=/usr/lib \
#			--localstatedir=/var \
#			--mandir=/usr/share/man \
#			--sbindir=/usr/sbin \
#			--enable-shared \
#			--disable-static \
#			--with-gnu-ld \
#			--enable-miniconfig \
#			--enable-miniportal \
#			--enable-chilliredir \
#			--enable-chilliproxy \
#			--enable-binstatusfile \
#        );
#endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/lib* $(1)/usr/lib/
endef

#define Package/coova-chilli-miniportal/install
# 	$(INSTALL_DIR) $(1)/etc/chilli
#	$(CP) $(PKG_INSTALL_DIR)/etc/chilli/www $(1)/etc/chilli/
#endef

define Package/coova-chilli/install
	$(INSTALL_DIR) $(1)/etc/chilli
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/etc/chilli.conf $(1)/etc/
	
	$(INSTALL_DIR) $(1)/etc/chilli
	$(CP) $(PKG_INSTALL_DIR)/etc/chilli/* $(1)/etc/chilli/
	#$(CP) $(PKG_INSTALL_DIR)/etc/chilli/up.sh $(1)/etc/chilli/
	#$(CP) $(PKG_INSTALL_DIR)/etc/chilli/down.sh $(1)/etc/chilli/
	#$(CP) $(PKG_INSTALL_DIR)/etc/chilli/wwwsh $(1)/etc/chilli/
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/chilli* $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/lib*.so.* $(1)/usr/lib/
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,coova-chilli))
