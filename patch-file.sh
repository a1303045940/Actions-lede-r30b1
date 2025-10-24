#!/bin/bash
ECHO() {
  echo "[$(date "+%H:%M:%S")] $*"
}

function Patch_File() {
  parent_path=$1
  patch_file_path=$2
  base_path=$PWD
  cp -r "../Patch-Files/$patch_file_path" "$parent_path"
  cd "$parent_path"
  for packagepatch in "$patch_file_path"/*; do
    if [ -f "$packagepatch" ]; then
      patch_file=$(basename "$packagepatch")
      ECHO Applying Patch File "$patch_file"
      patch -p1 --no-backup-if-mismatch < "$patch_file_path/$patch_file"
    fi
  done
  cd "$base_path"
}

# Patch_File feeds/packages feeds-package-patch-files
