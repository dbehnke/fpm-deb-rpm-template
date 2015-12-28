NAME=hello
PROVIDES=${NAME}
VERSION=1.0
ITERATION=1

#ARCH should be all,i686,amd64
ARCH=all

#RPMARCH should be noarch,i686,x86_64
RPMARCH=noarch

#RPMDIST should be el5, el6, el7, fc23, etc.
RPMDIST=el7

#DEBSUFFIX may be used in future, right now this does nothing
DEBSUFFIX="~Debian~jessie"

#MAINTAINER change to your email address if you don't want user@host
MAINTAINER="<$(shell whoami)@$(shell hostname)>"

DEB=$(NAME)_$(VERSION)-$(ITERATION)_$(ARCH).deb
RPM=$(NAME)-$(VERSION)-$(ITERATION).$(RPMDIST).$(RPMARCH).rpm
DESCRIPTION="Outputs a friendly hello"
SCRIPTSDIR=packaging-scripts
AINSTALL=$(SCRIPTSDIR)/after-install.sh
AREMOVE=$(SCRIPTSDIR)/after-remove.sh
AUPGRADE=$(SCRIPTSDIR)/after-upgrade.sh
BINSTALL=$(SCRIPTSDIR)/before-install.sh
BREMOVE=$(SCRIPTSDIR)/before-remove.sh
BUPGRADE=$(SCRIPTSDIR)/before-upgrade.sh

# to build on OSX:
# brew install ruby rpm
# gem install fpm
# make

all: deb rpm

.PHONY: rpmbuild
rpmbuild:
	which rpmbuild

.PHONY: fpm
fpm:
	which fpm

deb: fpm
	test -f $(DEB) || \
	fpm -s dir -t deb -a $(ARCH) -C root --provides $(PROVIDES) \
		-n $(NAME) \
		--version $(VERSION) --iteration $(ITERATION) \
		-m $(MAINTAINER) --description $(DESCRIPTION) \
		--after-install $(AINSTALL) \
		--before-install $(BINSTALL) \
		--after-remove $(AREMOVE) \
		--before-remove $(BREMOVE) \
		--after-upgrade $(AUPGRADE) \
		--before-upgrade $(BUPGRADE)
		

rpm: fpm rpmbuild
	test -f $(RPM) || \
	fpm -s dir -t rpm --rpm-os linux -a $(ARCH) -C root --provides $(PROVIDES) \
		-n $(NAME) \
		--version $(VERSION) --iteration $(ITERATION) \
		-m $(MAINTAINER) --description $(DESCRIPTION) \
		--rpm-dist $(RPMDIST) \
		--after-install $(AINSTALL) \
                --before-install $(BINSTALL) \
                --after-remove $(AREMOVE) \
                --before-remove $(BREMOVE) \
                --after-upgrade $(AUPGRADE) \
                --before-upgrade $(BUPGRADE)

clean:
	-rm *.deb
	-rm *.rpm
