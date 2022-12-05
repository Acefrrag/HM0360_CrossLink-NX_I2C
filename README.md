# HM0360_CrossLink-NX_Voice_Vision_ML_Board

VHDL code to implement the interface with the built-in camera on the CrossLink-NX Board


## Introduction

This repository contains the code for the development and testbenching of the VHDL entity implementing the I2C interface with built-in camera sensor HM0360, embedded on the CrossLink-NX Voice and Vision Machine Learning(ML) Board by Lattice Semiconductor.

It was not possible to use any IP from Lattice Semiconductor, because the I2C protocol to interface with this sensor is significaly different. In fact, the ***addressing mode is 16-bit***, which is atypical for a I2C protocol. Moreover, the read operation differs significantly from the the standard read operation. Read the documentation for greater details. I call this I2C protocol ***modified I2C***.

## Development

The main VHDL entity developed and testbenched is ***HM0360_serial_I2C_master***. This entity implements a I2C interface with the sensor. It enables reading and writing from any HM0360 valid register.

The code has been developed under Radiant Software. The bitstream is download onto the board using Radiant Programmer.

## Hardware

The CrossLink NX Voice and Vision ML Board includes the FPGA LIFCL-40-8MG289C. The sensor camera is HM0360 by Hi-Max.

## Bugs

At the current version the VHDL code has a bug. Sometimes when reading from the register, the ACK bit is occasionally missed. This produces an invalid read operation with the sensor. When this happen the value 3C is read from the register. In order to avoid this, the very same transaction  is repeated, after the device attempts to give a stop condition, as adviced by the [I2C Bus Tecnical Overview](https://www.esacademy.com/en/library/technical-articles-and-documents/miscellaneous/i2c-bus).

