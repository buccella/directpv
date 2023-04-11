#!/usr/bin/env bash
#
# This file is part of MinIO DirectPV
# Copyright (c) 2021, 2022 MinIO, Inc.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

set -ex

source "${SCRIPT_DIR}/common.sh"

setup_lvm
setup_luks
export DIRECTPV_CLIENT=./kubectl-directpv
install_directpv 4
add_drives
deploy_minio functests/minio.yaml
test_force_delete
uninstall_minio functests/minio.yaml
test_volume_expansion functests/sleep.yaml
remove_drives
uninstall_directpv 4
remove_luks
remove_lvm
