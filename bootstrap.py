#!/usr/bin/env python3
from pathlib import Path
import lib
from shutil import copy

mountpoint = Path("/mnt")
stages = [
    Path("./stage1.deb"),
    # Path("./stage2.deb"),
]

for s in stages:
    if not s.exists():
        print("Build all stages first!")
        exit(1)

for s in stages:
    print(f"Copying stage {str(s)}")
    copy(s, Path("/mnt"))

exit(1)

lib.run(
    f"debootstrap --variant=minbase --components=main,universe,multiverse jammy {str(mountpoint)} http://archive.ubuntu.com/ubuntu",
)
