# HM0360_CrossLink-NX_Voice_Vision_ML_Board

VHDL code to implement the interface with the built-in camera on the CrossLink-NX Board Voice and Vision Machine Learning Board. To the best of my knowledge there is no VHDL code implementing the I2C interface with this sensor.


## Introduction

This repository contains the code for the development and testbenching of the VHDL entity implementing the I2C interface with built-in camera sensor HM0360, embedded on the CrossLink-NX Voice and Vision Machine Learning(ML) Board by Lattice Semiconductor.

It was not possible to use the I2C IP from Lattice Semiconductor, because the I2C protocol to interface with this sensor is significaly different. In fact, the *addressing mode is 16-bit*, which is atypical for a I2C protocol. Moreover, the *read operation differs significantly from the the standard read operation*. Read the documentation for greater details. I call this I2C protocol ***modified I2C***.

## Development

The main VHDL entity developed and testbenched is ***HM0360_serial_I2C_master***. This entity implements a I2C interface with the sensor. It enables reading and writing from any HM0360 valid register. Nevertheless I include a small description for every file included in the project

* **HM0360_top_level**, it implements the connection between the I2C master VHDL entity and the components external to the FPGA (LEDs, buttons, 27 MHz oscillator, HM0360 camera sensor).
* **HM0360_top_level_tb**, for testbenching the HM0360_top_level.
* **HM0360_serial_master**, implements the modified I2C protocol with the HM0360 camera sensor.

The code has been developed under *Radiant Software* version 3.2.1.217.3 . The bitstream is download onto the board using *Radiant Programmer*.

## Finite State Machine

The modified I2C protocol has been implemented by using a finite state machine. The clock utilized to synchronize

## Hardware

The CrossLink NX Voice and Vision ML Board includes the FPGA LIFCL-40-8MG289C. The sensor camera is HM0360 by Hi-Max.

## Usage

The whole Radiant Software project has been uploaded, therefore the user may only need to open it within the EDA. It is advisable to move the Github Repository to the Desktop to allow synthesis in case of changes.

## Bugs

At the current version the VHDL code has a bug. Sometimes when reading from the register, the ACK bit is occasionally missed. This produces an invalid read operation with the sensor. When this happen the value 3C is read from the register. In order to avoid this, the very same transaction is repeated until no no-ACK is detected during the transaction. When a no-ACK arises the device attempts to give a stop condition, as adviced by the [I2C Bus Tecnical Overview](https://www.esacademy.com/en/library/technical-articles-and-documents/miscellaneous/i2c-bus) and the operation is repeated once again.

