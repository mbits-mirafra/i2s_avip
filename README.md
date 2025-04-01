# i2s_avip
This project deals with the I2S protocol

# Accelerated VIP for i2s Protocol
The idea of using Accelerated VIP is to push the synthesizable part of the testbench into the separate top module along with the interface and it is named as HDL TOP and the unsynthesizable part is pushed into the HVL TOP. This setup provides the ability to run longer tests quickly. This particular testbench can be used for the simulation as well as the emulation based on the mode of operation.

# Key Features
1. It has 8,16,24,32 Serial data bits for each sample. 
2. It has different sample rates. (8 khz to 192 khz)
3. I2S supports the Left justified, Right justified (CODEC) mode, Phillips Standard mode.
4. It has 16-bit, 32-bit, 48-bit, or 64-bit Word select period.
5. It supports serial data transmission through mono and stereo channels based on word select signal.
   
# Testbench Architecture Diagram
![image](https://github.com/user-attachments/assets/f07bfa47-dbe6-4d85-9781-87ad1cf24df5)

## Developers, Welcome
We believe in growing together and if you'd like to contribute, please do check out the contributing guide below:
https://github.com/mbits-mirafra/i2s_avip/blob/main/contribution_guidelines.md

## Contact Mirafra Team
You can reach out to us over mbits@mirafra.com

For more information regarding Mirafra Technologies please do check out our official website:
https://mirafra.com/






