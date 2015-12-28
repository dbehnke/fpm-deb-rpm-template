# fpm-deb-rpm-template
Template for use with FPM to build Debian and RPM packages

See [FPM](https://github.com/jordansissel/fpm) for more information on how to install and use it.

## Creating .deb and .rpm

Simply run make once you have fpm installed.  It will create the hello 1.0.0-1 packages.

        make

## Expanding on the template

Use the root directory as if it were the root directory on the file system, place all your files in a tree structure.

Modify the variables in the Makefile

## OSX Notes

To build from OSX you'll need to use homebrew and install ruby, gnu-tar, and rpm

        brew install ruby gnu-tar rpm

You may need to exit and open a new terminal to have the /usr/local version of ruby default in your path.

Install fpm

        gem install fpm
