# i2s_avip
This project deals with the I2S protocol

# Accelerated VIP for axi4Lite Protocol
The idea of using Accelerated VIP is to push the synthesizable part of the testbench into the separate top module along with the interface and it is named as HDL TOP and the unsynthesizable part is pushed into the HVL TOP. This setup provides the ability to run longer tests quickly. This particular testbench can be used for the simulation as well as the emulation based on the mode of operation.
