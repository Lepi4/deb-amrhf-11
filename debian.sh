#!/usr/bin/env bash
# WB Bullseye armhf LXC builder (Proxmox)
# Defaults: 2 vCPU, 2048 MiB RAM, 2048 MiB swap, 6 GiB disk, unprivileged, dhcp.
# Template: Debian bullseye armhf (LXC Jenkins) with Wiren Board repo + home UI.

APP="WB-Bullseye"
TEMPLATE_URL="https://jenkins.linuxcontainers.org/view/Images/job/image-debian/architecture=armhf,release=bullseye,variant=default/lastSuccessfulBuild/artifact/rootfs.tar.xz"
CORE_COUNT=2
RAM_SIZE=2048
SWAP_SIZE=2048
DISK_SIZE=6
BRG="vmbr0"
NET="dhcp"

SCRIPT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RAW_BASE="https://raw.githubusercontent.com/Lepi4/deb-amrhf-11/main"
LOCAL_BUILD_FUNC="${SCRIPT_DIR}/build.func"

# Prefer local build.func, otherwise fetch from GitHub raw
if [[ -f "$LOCAL_BUILD_FUNC" ]]; then
  # shellcheck source=build.func
  source "$LOCAL_BUILD_FUNC"
else
  source <(curl -fsSL "$RAW_BASE/build.func")
fi

run_build "$@"
