#!/usr/bin/env bash
set -e

# Configuration
ARCH=x86_64
export TARGET=$ARCH-unknown-redox
HOST=$TARGET

# Automatic variables
ROOT="$(cd `dirname "$0"` && pwd)"
REPO="$ROOT/repo/$TARGET"
export PATH="${ROOT}/bin:$PATH"
export CARGO_HOME="${ROOT}/cargo"

export AR="${HOST}-ar"
export AS="${HOST}-as"
export CC="${HOST}-gcc"
export CXX="${HOST}-g++"
export LD="${HOST}-ld"
export NM="${HOST}-nm"
export OBJCOPY="${HOST}-objcopy"
export OBJDUMP="${HOST}-objdump"
#export PKG_CONFIG="${HOST}-pkg-config"
export RANLIB="${HOST}-ranlib"
export READELF="${HOST}-readelf"
export STRIP="${HOST}-strip"

if [[ "$OSTYPE" == "darwin"* ]]; then
    # GNU find
    FIND="gfind";

    # GNU stat from Homebrew or MacPorts
    if [ ! -z "$(which brew)" ]; then
        STAT="$(brew --prefix)/opt/coreutils/libexec/gnubin/stat";
    elif [ ! -z "$(which port)" ]; then
        # TODO: find a programatic way of asking MacPorts for it's root dir.
        STAT="/opt/local/opt/coreutils/libexec/gnubin/stat";
    else
        echo "Please install either Homebrew or MacPorts and run the boostrap script."
        exit 1
    fi
else
    FIND="find"
    STAT="stat";
fi
