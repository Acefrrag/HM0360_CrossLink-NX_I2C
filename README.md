# HM0360_CrossLink-NX_Voice_Vision_ML_Board

VHDL code to implement the interface with the built-in camera on the CrossLink-NX Board


## Introduction

This repository contains the code for the development and testbenching of the VHDL entity implementing the I2C interface with built-in camera sensor HM0360, embedded on the CrossLink-NX Voice and Vision Machine Learning(ML) Board by Lattice Semiconductor.

It was not possible to use any IP from Lattice Semiconductor, because the I2C  protocol to interface with this sensor is significaly different. In particular, the addressing mode is 16-bit, which is atypical for a I2C protocol. Moreover, the read operation differs significantly from the the standard read operation.

## Development

The main VHDL entity developed and testbenched is ***HM0360_serial_I2C_master***. This entity implements a I2C interface with the sensor. It enables reading and writing from any HM0360 valid register.

The code has been developed under Radiant Software.

##Hardware

The CrossLink NX Voice and Vision ML Board includes the FPGA LIFCL-40-8MG289C 

##Bugs

At the current version the VHDL code has a bug. Sometimes when writing/reading to and from the register. The ACK bit is occasionally missed. This produces invalid write or read operation with the sensor.

