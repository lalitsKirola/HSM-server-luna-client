Issues i faced during configuration:

When i was checking ./lunacm by getting inside pod... getting current slot id as none...

# ./lunacm

lunacm (64-bit) v10.7.1-125. Copyright (c) 2024 Thales Group. All rights reserved.

Available HSMS:

0

0

Current Slot Id: None

lunacm:>

#exit

command terminated with exit code 12


Solution:

Make sure the configuration file for Luna is correctly set up. The file should be located at /usr/local/luna/config/Chrystoki.conf (or another specified configuration path). You may need to check if:

The correct slot is defined in the configuration.

The HSM’s IP or hostname is properly configured.

The ChrystokiConfigurationPath environment variable is set correctly.


You can manually inspect the config file by running:

cat /usr/local/luna/config/Chrystoki.conf
