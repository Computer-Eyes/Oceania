.PHONY: build clean deb

BIN=oceania

VERSION=1.0.0

BUILD_DIR=build

build:
	go build -o $(BUILD_DIR)/$(BIN) main.go

clean:
	rm -rf $(BUILD_DIR)

deb:
	mkdir -p $(BUILD_DIR)/$(PROGRAM)-$(VERSION)/usr/local/bin
	cp $(BUILD_DIR)/$(BIN) $(BUILD_DIR)/$(PROGRAM)-$(VERSION)/usr/local/bin

	echo "Package: $(PROGRAM)" > $(BUILD_DIR)/$(PROGRAM)-$(VERSION)/DEBIAN/control
	echo "Version: $(VERSION)" >> $(BUILD_DIR)/$(PROGRAM)-$(VERSION)/DEBIAN/control
	echo "Section: base" >> $(BUILD_DIR)/$(PROGRAM)-$(VERSION)/DEBIAN/control
	echo "Priority: optional" >> $(BUILD_DIR)/$(PROGRAM)-$(VERSION)/DEBIAN/control
	echo "Architecture: amd64" >> $(BUILD_DIR)/$(PROGRAM)-$(VERSION)/DEBIAN/control
	echo "Maintainer: VentGrey <ventgrey@gmail.com>" >> $(BUILD_DIR)/$(PROGRAM)-$(VERSION)/DEBIAN/control
	echo "Description: $(PROGRAM) is a simple tool to get your Docker container status on SSH login to a server." >> $(BUILD_DIR)/$(PROGRAM)-$(VERSION)/DEBIAN/control

	dpkg-deb --build $(BUILD_DIR)/$(PROGRAM)-$(VERSION)

# Empaqueta el programa en un paquete rpm
rpm:
	mkdir -p $(BUILD_DIR)/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

	cp $(BUILD_DIR)/$(PROGRAM) $(BUILD_DIR)/rpmbuild/SOURCES/

	echo "Name: $(PROGRAM)" > $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec
	echo "Version: $(VERSION)" >> $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec
	echo "Release: 1" >> $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec
	echo "Summary: $(PROGRAM) is a simple tool to get your Docker container status on SSH login to a server." >> $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec
	echo "Group: Development/Tools" >> $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec
	echo "License: GPL-3" >> $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec
	echo "Source: $(PROGRAM)" >> $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec
	echo "" >> $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec
	echo "%description" >> $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec
	echo "$(PROGRAM) is a simple tool to get your Docker container status on SSH login to a server." >> $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec
	echo "" >> $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec
	echo "%install" >> $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec
	echo "mkdir -p %{buildroot}/usr/local/bin" >> $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec
	echo "cp %{SOURCE0} %{buildroot}/usr/local/bin" >> $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec
	echo "" >> $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec
	echo "%files" >> $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec
	echo "%defattr(-,root,root)" >> $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec
	echo "/usr/local/bin/$(PROGRAM)" >> $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec

	rpmbuild -bb $(BUILD_DIR)/rpmbuild/SPECS/$(PROGRAM).spec --define "_topdir $(BUILD_DIR)/rpmbuild"

alpine:
	mkdir -p $(BUILD_DIR)/pkg

	cp $(BUILD_DIR)/$(PROGRAM) $(BUILD_DIR)/pkg/

	echo "pkgname=$(PROGRAM)" > $(BUILD_DIR)/pkg/APKBUILD
	echo "pkgver=$(VERSION)" >> $(BUILD_DIR)/pkg/APKBUILD
	echo "pkgrel=1" >> $(BUILD_DIR)/pkg/APKBUILD
	echo "pkgdesc=\"$(PROGRAM) is a simple tool to get your Docker container status on SSH login to a server.\"" >> $(BUILD_DIR)/pkg/APKBUILD
	echo "url=\"https://github.com/VentGrey/oceania\"" >> $(BUILD_DIR)/pkg/APKBUILD
	echo "arch=\"x86_64\"" >> $(BUILD_DIR)/pkg/APKBUILD
	echo "license=\"GPL-3\"" >>
