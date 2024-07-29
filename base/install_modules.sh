#!/usr/bin/env bash

set -ex

. /opt/epics/install-functions.sh

install_from_github mdavidsaver pvxs PVXS $PVXS_VERSION "
EPICS_BASE
"

install_from_github epics-modules sequencer SNCSEQ $SEQUENCER_VERSION "
EPICS_BASE
"

install_from_github epics-modules calc CALC $CALC_VERSION "
EPICS_BASE
"

# Build asyn without seq since it's only needed for testIPServer
install_from_github epics-modules asyn ASYN $ASYN_VERSION "
EPICS_BASE
CALC
"

install_from_github paulscherrerinstitute StreamDevice STREAM $STREAMDEVICE_VERSION "
EPICS_BASE
ASYN
CALC
"

install_from_github epics-modules busy BUSY $BUSY_VERSION "
EPICS_BASE
ASYN
"

install_from_github epics-modules autosave AUTOSAVE $AUTOSAVE_VERSION "
EPICS_BASE
"

install_from_github epics-modules sscan SSCAN $SSCAN_VERSION "
EPICS_BASE
SNCSEQ
"

download_from_github ChannelFinder recsync $RECCASTER_VERSION
install_module recsync/client RECCASTER "
EPICS_BASE
"

install_from_github epics-modules ipac IPAC $IPAC_VERSION "
EPICS_BASE
"

download_from_github epics-modules caPutLog $CAPUTLOG_VERSION
patch -d caPutLog -Np1 < caputlog-waveform-fix.patch
install_module caPutLog CAPUTLOG "
EPICS_BASE
"

install_from_github brunoseivam retools RETOOLS $RETOOLS_VERSION "
EPICS_BASE
"

install_from_github -i epics-modules ether_ip ETHER_IP $ETHER_IP_VERSION "
EPICS_BASE
"

install_from_github  epics-modules iocStats DEVIOCSTATS $IOCSTATS_VERSION "
EPICS_BASE
"

download_from_github slac-epics-modules ipmiComm $IPMICOMM_VERSION
patch -d ipmiComm -Np1 < ipmicomm.patch
JOBS=1 install_module ipmiComm IPMICOMM "
EPICS_BASE
ASYN
"

download_from_github mdavidsaver pyDevSup $PYDEVSUP_VERSION
echo PYTHON=python3 >> pyDevSup/configure/CONFIG_SITE
install_module pyDevSup PYDEVSUP "
EPICS_BASE
"
