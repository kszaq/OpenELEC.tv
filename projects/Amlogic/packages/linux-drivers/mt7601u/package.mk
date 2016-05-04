################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="mt7601u"
PKG_VERSION="4.2.6-1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://backports.wiki.kernel.org"
PKG_URL="http://www.kernel.org/pub/linux/kernel/projects/backports/stable/v4.2.6/backports-4.2.6-1.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux mt7601u-firmware"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="driver"
PKG_SHORTDESC="MediaTek MT7601U (USB) driver"
PKG_LONGDESC="MediaTek MT7601U (USB) driver"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

unpack() {
  shopt -s dotglob

  PKG_FILENAME=backports-$PKG_VERSION.tar.xz
  PKG_FULLPATH=$(readlink -f $SOURCES/$PKG_NAME/$PKG_FILENAME)

  tar xf "$PKG_FULLPATH" -C $BUILD
  mv $BUILD/backports-$PKG_VERSION $ROOT/$PKG_BUILD
}

pre_make_target() {
  wget -qO- https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/patch/?id=bed429e1ae8b7ee207e01f3aa60dcc0d06a8ed4d | patch -p1
  wget -qO- https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/patch/?id=d9517c0a5d7468a7ea63086057604fcb0fff480e | patch -p1
  wget -qO- https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/patch/?id=4513493d188d5e3052aee68eda85eaaa1a4e41c2 | patch -p1
  wget -qO- https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/patch/?id=78623bfb6f4cbdba3183621e8e0e781611217022 | patch -p1
  wget -qO- https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/patch/?id=2b02a36d12192f2a86388913143cd1e399eb971c | patch -p1

  echo 'CPTCFG_CFG80211=m' > defconfigs/mt7601u
  echo 'CPTCFG_CFG80211_WEXT=y' >> defconfigs/mt7601u
  echo 'CPTCFG_MAC80211=m' >> defconfigs/mt7601u
  echo 'CPTCFG_WLAN=y' >> defconfigs/mt7601u
  echo 'CPTCFG_WL_MEDIATEK=y' >> defconfigs/mt7601u
  echo 'CPTCFG_MT7601U=m' >> defconfigs/mt7601u
}

make_target() {
  make defconfig-mt7601u \
       CC=gcc \
       KLIB=$INSTALL \
       KLIB_BUILD=$(kernel_path)
  LDFLAGS="" CFLAGS="" make \
       KLIB=$INSTALL \
       KLIB_BUILD=$(kernel_path) \
       ARCH=$TARGET_KERNEL_ARCH \
       CROSS_COMPILE=$TARGET_PREFIX
}

makeinstall_target() {
  make LDFLAGS="" CFLAGS="" install V=1 \
       KLIB=$INSTALL \
       KLIB_BUILD=$(kernel_path)
}
