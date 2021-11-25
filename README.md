# Proprietary software installation on Clear Linux

This is my prefered personal way of installing (proprietary) software packages missing in Clear Linux but available for other RPM based distributions.

It configures `dnf` to install all software into `/dnf` root in order to keep `/usr` clean, as intended by the CL paradigm. Most software, however, still wont be functional as they tend to assume to be installed into `/usr`, and therefore need manual fixing.

I suggest running `dnf install --repo clear filesystem bash` to create a minimal directory structure, besides adding `/dnf/bin` to the PATH, and adding `/dnf/lib` & `/dnf/lib64` to `/etc/ld.so.conf`.

Use the `build-fake-deps.sh` script to build a rpm package with the missing requirements in order to avoid reinstalling dependencies already provided by the base CL installation.