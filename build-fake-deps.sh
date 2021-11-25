#!/bin/sh

# This script builds a rpm which pretends to provide
# every missing required package in the enabled dnf repos.
# Intended to avoid installing packages already provided
# by Clear Linux, since it doesn't register its installed
# bundles in the rpm database, also because there are
# some naming differences.

set -euo pipefail

type dnf rpmbuild > /dev/null


TMP=$(mktemp -d)

SPEC=$TMP/fake.spec

cat <<EOS > $SPEC

%define _rpmdir $TMP

Name:		fake-deps
Version:	1
Release:	$(date +%s)
Summary:	fake deps

Group:		Fake
License:	MIT
BuildRoot:	$TMP

BuildArch:	noarch

$(
    (dnf repoclosure -y -x fake-deps 2>&- || true) | \
    awk '/^    [^(]/{print "Provides: " $1}' | \
    sort | uniq
)


%description
%{summary}

%files

%changelog

EOS

rpmbuild --quiet -bb $SPEC

find $TMP -name \*.rpm -exec cp "{}" . \;
