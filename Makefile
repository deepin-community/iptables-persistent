#!/usr/bin/make -f

# This file is part of netfilter-persistent
# Copyright (C) 2014 Jonathan Wiltshire
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation, either version 3
# of the License, or (at your option) any later version.

PREFIX=/
DEST=$(DESTDIR)$(PREFIX)

all:

clean:

install:
	install -d $(DEST)/usr/sbin
	install -d $(DEST)/usr/share/netfilter-persistent
	install -d $(DEST)/usr/share/netfilter-persistent/plugins.d
	# Main wrapper
	install netfilter-persistent $(DEST)/usr/sbin
	# Systemd
	install -d $(DEST)/lib/systemd/system
	install --mode=644 systemd/* $(DEST)/lib/systemd/system
	# Manual
	install -d $(DEST)/usr/share/man/man8
	install --mode=644 netfilter-persistent.8 $(DEST)/usr/share/man/man8

install-plugins:
	# Plugins
	install plugins/* $(DEST)/usr/share/netfilter-persistent/plugins.d
	# Explicit flush plugin
	install --mode=755 iptb-expflush-plugin $(DEST)/usr/share/netfilter-persistent
	ln -fs /usr/share/netfilter-persistent/iptb-expflush-plugin $(DEST)/usr/share/netfilter-persistent/plugins/12-iptb4-explicit-flush
	ln -fs /usr/share/netfilter-persistent/iptb-expflush-plugin $(DEST)/usr/share/netfilter-persistent/plugins/20-iptb6-explicit-flush
