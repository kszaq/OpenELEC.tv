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

PKG_NAME="mt7601u-firmware"
PKG_VERSION="3.0.0.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.mediatek.com/en/downloads1/downloads/mt7601u-usb/"
PKG_URL="http://cdn-cw.mediatek.com/Downloads/linux/DPO_MT7601U_LinuxSTA_3.0.0.4_20130913.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="firmware"
PKG_SHORTDESC="MediaTek MT7601U (USB) firmware"
PKG_LONGDESC="MediaTek MT7601U (USB) firmware"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

unpack() {
  PKG_FILENAME="$(echo $PKG_URL | sed -e 's|.*/\(.*\)$|\1|' -e 's|%20| |g')"
  PKG_FULLPATH=$(readlink -f $SOURCES/$PKG_NAME/$PKG_FILENAME)

  mkdir -p $ROOT/$PKG_BUILD
  tar xf "$PKG_FULLPATH" -C $ROOT/$PKG_BUILD --wildcards '*MT7601.bin' --strip-components=4
}

make_target() {
  : # nada
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/firmware
  cp -p MT7601.bin $INSTALL/lib/firmware/mt7601u.bin
}
