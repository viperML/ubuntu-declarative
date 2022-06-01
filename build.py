#!/usr/bin/env python3
import lib

lib.run("dpkg-deb --build --root-owner-group stage1")
