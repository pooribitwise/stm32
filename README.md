---

# STM32 Baremetal Programming Template

---

## Introduction
Here is a template to to start programming stm32 microcontrollers baremetal.
The build process uses make to create the binary file.

---

## Prerequisites
Before using the template, ensure the below packages are installed:
* **For dnf:**
```bash
sudo dnf install arm-none-eabi-gcc arm-none-eabi-newlib openocd stlink make
```
* **For apt:**
```bash
sudo apt install gcc-arm-none-eabi binutils-arm-none-eabi openocd stlink-tools make
```
**Important Note:**
If you use apt package manager, modify the Makefile to the corresponding package.

---

## Wiring

Connect your bluepill to ST-Link V2:
```text
      ST-Link V2                 STM32 BluePill
    +-------------+             +--------------+
    |             |             |              |
    |        3.3V |<----------->| 3.3V         |
    |         GND |<----------->| GND          |
    |       SWDIO |<----------->| SWIO (PA13)  |
    |       SWCLK |<----------->| SWCLK (PA14) |
    |             |             |              |
    +-------------+             +--------------+
```

---

## Usage
1. Clone the repo:
```bash
git clone https://github.com/pooribitwise/stm32-baremetal-template.git
```
2. Write your code in main.c
3. Use make to build the binary (edit Makefile if you want to change your file names to something else)
```bash
make
```
4. Load main.bin on your chips flash (these commands are for stm32f1 series)
* OpenOCD:

```bash
openocd -f interface/stlink.cfg -f target/stm32f1x.cfg -c "program main.bin verify reset exit 0x08000000"
```

* st-flash:

```bash
st-flash write main.bin 0x08000000
```

### BONUS:
You can also use:

```bash
make flash
```
to flash your bin file on the chip and

```bash
make erase
```

to erase the flash memory.

**NOTE:** These make commands work only using st-link programmers.

---

## Additional Notes
* If you want to build header files or use the ST's provided headers, put your files in a directory named "inc".
* To clean the build process and remove the built files, use:
```bash
make clean
```
* If your code uses multiple C files, put them in the main repo directory or create one named "src"

---

## License
This project uses GNU General Public (GPL) v3 license.
