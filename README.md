# i2s_avip
This project deals with the I2S protocol

# Accelerated VIP for i2s Protocol
The idea of using Accelerated VIP is to push the synthesizable part of the testbench into the separate top module along with the interface and it is named as HDL TOP and the unsynthesizable part is pushed into the HVL TOP. This setup provides the ability to run longer tests quickly. This particular testbench can be used for the simulation as well as the emulation based on the mode of operation.

# Key Features
1. It has 8,16,24,32 Serial data bits for each sample. 
2. It supports both mono channel and stereo channel modes of communication  
3. It has different sample rates. (8 khz to 192 khz) 
4. It supports the Left justified (Codec) mode.  
5. It has 16-bit, 32-bit, 48-bit, or 64-bit Word select period. 
6. Mechanism to enable Serial data transmission, WS generation and Serial clock generation. 

# Key features for the TO DO 
1. It supports the Right justified (Codec) mode and Phillips Standard mode.  

   
# Testbench Architecture Diagram
![image](https://github.com/user-attachments/assets/f07bfa47-dbe6-4d85-9781-87ad1cf24df5)

## Developers, Welcome
We believe in growing together and if you'd like to contribute, please do check out the contributing guide below:
https://github.com/mbits-mirafra/i2s_avip/blob/main/contribution_guidelines.md
# Installation - Get the VIP collateral from the GitHub repository

```
# Checking for git software, open the terminal type the command
git version

# Get the VIP collateral
git clone git@github.com:mbits-mirafra/axi4_avip.git
```

# Running the test

### Using Mentor's Questasim simulator 

```
cd i2s_avip/sim/questasim

# Compilation:  
make compile

# Simulation:
make simulate test=<test_name> uvm_verbosity=<VERBOSITY_LEVEL>

ex: make simulate test=I2sWriteOperationWith16bitdataTxMasterRxSlaveWith8khzTest uvm_verbosity=UVM_HIGH

# Note: You can find all the test case names in the path given below   
i2s_avip/src/hvlTop/testlist/I2s_standard_mode_regression.list

# Wavefrom:  
vsim -view <test_name>/waveform.wlf &

ex: vsim -view I2sWriteOperationWith16bitdataTxMasterRxSlaveWith8khzTest/waveform.wlf &

# Regression:
make regression testlist_name=<regression_testlist_name.list>
ex: make regression testlist_name=I2s_standard_mode_regression

# Coverage: 
 ## Individual test:
 firefox <test_name>/html_cov_report/index.html &
 ex: firefox I2sWriteOperationWith16bitdataTxMasterRxSlaveWith8khzTest/html_cov_report/index.html &

 ## Regression:
 firefox merged_cov_html_report/index.html &

```
## User Guide  
https://github.com/mbits-mirafra/i2s_avip/blob/main/doc/i2s_Avip_Document.pdf

## Contact Mirafra Team
You can reach out to us over mbits@mirafra.com

For more information regarding Mirafra Technologies please do check out our official website:
https://mirafra.com/






