#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

MYTEMP="$(mktemp -d /tmp/chromium-ppc64le.XXXXXX)"
cd "${MYTEMP}"

git clone --recurse-submodules https://github.com/chromium-ppc64le/chromium-ppc64le-patches-quilt.git .

mkdir -p gentoo-patches && cd gentoo-patches

# this will sort patches according to series properly, without locale problems
# only power specific patches
# extra patchsets require significant changes to gentoo ebuild
i=1000000
for patch in $(grep -vE "^#" ../patches/series); do
        i=$((i+1)); cp -v -- "../patches/${patch}" ${i#1}-ppc64.patch;
done


# more required patches
wget https://gist.githubusercontent.com/gyakovlev/196e33fdc9eb567e72728dcc3903f081/raw/94d0b514945abbe82bcea8f674faff6e119058c3/dav1d-ppc64-support.patch
wget https://gist.githubusercontent.com/gyakovlev/79425f3d46103d337c9687bc53e67551/raw/b3c1438e819a8219acf55483883e75dff6811748/dav1d-ppc64-support-clang.patch

# temp fix
wget https://raw.githubusercontent.com/chromium-ppc64le/chromium-ppc64le/80e700513aacf0966c62e720992efc4e7394c907/docker-root/patches/chrome/fix-swiftshader-link.patch

# needs clang-10.0.0 rebuilt with https://github.com/chromium-ppc64le/llvm-builds/blob/master/0001-Fix-C-compilation-of-altivec.h.patch
#wget https://raw.githubusercontent.com/chromium-ppc64le/chromium-ppc64le/master/docker-root/patches/chrome/skia-vsx-instructions.patch

# fails to apply on gentoo
#wget https://raw.githubusercontent.com/chromium-ppc64le/chromium-ppc64le/master/docker-root/patches/chrome/Revert-Vulkan-Disable-global-merge-for-volk.patch

# optional patches, uncomment if needed.
#wget https://raw.githubusercontent.com/chromium-ppc64le/chromium-ppc64le/master/docker-root/patches/chrome/change-user-agent.patch
#wget https://raw.githubusercontent.com/chromium-ppc64le/chromium-ppc64le/master/docker-root/patches/chrome/overlay-scrollbars.patch
#wget https://raw.githubusercontent.com/chromium-ppc64le/chromium-ppc64le/master/docker-root/patches/chrome/enable-vaapi.patch

echo
echo "patches ready: ${MYTEMP}/gentoo-patches"
echo
