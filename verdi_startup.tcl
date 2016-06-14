# Commands to enable reverse-debug by default in Verdi
# From Brian Schneider <brian.schneider@synopsys.com>
# To enable this, set NOVAS_AUTO_SOURCE to point at this file

tbvSetPreference -autoAddCheckpointsInUVMPhase 1 -genCheckpoints 40 -reverseDebug on
tbvSetPreference -stopCheckpoints 5

