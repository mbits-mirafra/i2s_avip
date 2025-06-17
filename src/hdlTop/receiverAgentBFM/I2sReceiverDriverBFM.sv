`ifndef I2SRECEIVERDRIVERBFM_INCLUDED_
`define I2SRECEIVERDRIVERBFM_INCLUDED_

import I2sGlobalPkg::*;

interface I2sReceiverDriverBFM(input clk, 
                               input rst,
                               input sclkInput,
                               output reg sclkOutput,
                               input wsInput,
                               output reg wsOutput,
                               input reg sd);



  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  import I2sReceiverPkg::I2sReceiverDriverProxy;

  int sclkPeriod;
  int timeoutSclk;
  int time1,time2;
  int clkPeriod;
  int clkFrequency;
  int sclkPeriodDivider;
  int rxNumOfBitsTransfer;
  int timeout_ws;

 
  I2sReceiverDriverProxy i2sReceiverDriverProxy;
  string name = "I2ReceiverDriverBFM";
  i2sStateEnum state;


  task waitForReset();
    @(negedge rst);
    wsOutput <= 1'dx;
    sclkOutput<=1'b0;
     state<=RESET_ACTIVATED;
    `uvm_info(name,$sformatf("SYSTEM RESET ACTIVATED"),UVM_HIGH)
    @(posedge rst);
     state<=RESET_DEACTIVATED;
    `uvm_info(name,$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)

  endtask: waitForReset

  task genSclk(input i2sTransferCfgStruct configPacketStruct);

    static int counter=0;

    rxNumOfBitsTransfer=configPacketStruct.wordSelectPeriod/2;

    `uvm_info(name, $sformatf("IN RECEIVER DRIVER-Generating the Serial clock"), UVM_NONE)

    @(posedge clk);
    time1 = $realtime;

    @(posedge clk);
    time2 = $realtime;

    clkPeriod = time2-time1;

    clkFrequency = ((10**9)/clkPeriod);

    generateSclkPeriod(configPacketStruct); 

    sclkOutput <= configPacketStruct.Sclk; 

    forever begin
      @(posedge clk);
      counter++;

      if (counter == (sclkPeriodDivider/2)) 
        begin
          sclkOutput = ~sclkOutput;
          counter = 0;
        end
    end
    counter=0;
  endtask:genSclk

  function void generateSclkPeriod(input i2sTransferCfgStruct cfgStr);

    cfgStr.sclkFrequency = cfgStr.clockratefrequency * rxNumOfBitsTransfer * cfgStr.numOfChannels;

    sclkPeriod = ((10**9)/cfgStr.sclkFrequency);
    sclkPeriodDivider = (clkFrequency/cfgStr.sclkFrequency);

    `uvm_info(name, $sformatf("clockFrequency=%0d",clkFrequency), UVM_NONE)
    `uvm_info(name, $sformatf("Serial clockFrequency=%0d",cfgStr.sclkFrequency), UVM_NONE)
    `uvm_info(name, $sformatf("Sclk clockperiod=%0d ns",sclkPeriod), UVM_NONE)
    `uvm_info(name, $sformatf("Sclk Period Divider=%0d",sclkPeriodDivider), UVM_NONE)

  endfunction: generateSclkPeriod


  task drivePacket(inout i2sTransferPacketStruct dataPacketStruct, 
                   input i2sTransferCfgStruct configPacketStruct);

    `uvm_info(name, $sformatf("Starting the drive packet method"), UVM_HIGH)

    genWs(dataPacketStruct,configPacketStruct);

  endtask: drivePacket

  task genWs(inout i2sTransferPacketStruct dataPacketStruct,input i2sTransferCfgStruct configPacketStruct); 
                 
    static int counter=0;
    timeout_ws = configPacketStruct.numOfChannels;

    `uvm_info(name, $sformatf("IN RECEIVER DRIVER-Generating the WS"), UVM_NONE)

    forever begin
      @(posedge sclkOutput);

      if (counter == (configPacketStruct.wordSelectPeriod/2)) 
        begin
          timeout_ws=timeout_ws-1;
          if(timeout_ws==0) 
            begin
              wsOutput <= WS_DEFAULT; 
	      state<= IDLE;
              break;
            end

          dataPacketStruct.ws = ~ dataPacketStruct.ws;
          counter = 0;

        end

      wsOutput <= dataPacketStruct.ws; 
      counter++;
      
      if (dataPacketStruct.ws==1'b0)
        begin
	   state <= RIGHT_CHANNEL;
        end
      else if(dataPacketStruct.ws==1'b1)
        begin
	   state <= LEFT_CHANNEL;
	end
    end      
    counter=0;
    timeout_ws= configPacketStruct.numOfChannels;  
    `uvm_info(name, $sformatf("IN RECEIVER DRIVER-Generating the WS ended"), UVM_NONE)
  endtask: genWs  

endinterface : I2sReceiverDriverBFM
`endif



