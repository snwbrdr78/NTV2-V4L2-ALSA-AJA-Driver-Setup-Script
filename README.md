# NTV2 V4L2/ALSA Driver Setup Script

This repository contains a bash script that automates the installation and setup of the NTV2 V4L2/ALSA driver for AJA Corvid 88 on Ubuntu.

## Prerequisites

- Ubuntu 20.04 LTS or Ubuntu 22.04 LTS
- Root or sudo access

## Script Overview

The script performs the following tasks:

1. **System Update and Package Installation**
    - Updates the package list and upgrades existing packages.
    - Installs the required packages: `git`, `build-essential`, `linux-headers`, and `v4l-utils`.

2. **Driver Installation**
    - Clones the `ntv2-v4l2` repository from GitHub.
    - Builds the NTV2 V4L2/ALSA driver.
    - Loads the driver into the kernel.

3. **Verification**
    - Lists the available video devices to verify the installation.
    - Checks if the `ntv2video` driver is loaded.

## Usage

1. **Download the Script:**

    Save the script as `ntv2-v4l2-setup.sh`:

    ```bash
    wget https://your-repo-url/ntv2-v4l2-setup.sh
    ```

2. **Make the Script Executable:**

    ```bash
    chmod +x ntv2-v4l2-setup.sh
    ```

3. **Run the Script:**

    Execute the script with root privileges:

    ```bash
    sudo ./ntv2-v4l2-setup.sh
    ```

## Script Output

The script will output the following information during its execution:

- Updates and package installation status.
- Driver cloning, building, and loading status.
- Verification of available video devices and loaded drivers.

## Error Handling

- The script includes error handling at each critical step.
- If any step fails, the script will exit with a relevant error message.

## License
