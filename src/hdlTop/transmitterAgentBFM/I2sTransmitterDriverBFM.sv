`ifndef I2STRANSMITTERDRIVERBFM_INCLUDED_
`define I2STRANSMITTERDRIVERBFM_INCLUDED_

import I2sGlobalPkg::*;

interface I2sTransmitterDriverBFM(input clk, 
                                  input rst,
                                  input sclkInput,
                                  output reg sclkOutput,
                                  input wsInput,
                                  output reg wsOutput,
                                  output reg sd);

  int sclkPeriod;
  int timeoutSclk;
  int time1,time2;
  int clkPeriod;
  int clkFrequency;
  int sclkPeriodDivider;
  int numOfChannels;
  int timeout_ws;
  int txNumOfBitsTransferLocal;
  
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import I2sTransmitterPkg::I2sTransmitterDriverProxy;

  I2sTransmitterDriverProxy i2sTransmitterDriverProxy;

  i2sStateEnum state;

  string name = "I2sTransmitterDriverBFM";

  task waitForReset();

    @(negedge rst);
    sd <= 1'b0;
    wsOutput <= 1'bx;
    sclkOutput<=1'b0;
    state<=RESET_ACTIVATED;
    `uvm_info(name,$sformatf("SYSTEM RESET ACTIVATED"),UVM_NONE)
    @(posedge rst);
    state<=RESET_DEACTIVATED;
    `uvm_info(name,$sformatf("SYSTEM RESET DEACTIVATED"),UVM_NONE)

  endtask: waitForReset

  task genSclk(input i2sTransferCfgStruct configPacketStruct);

     static int counter=0;

    `uvm_info(name, $sformatf("IN TRANSMITTER DRIVER-Generating the Serial clock"), UVM_NONE)

    txNumOfBitsTransferLocal= configPacketStruct.wordSelectPeriod/2;
    
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

    cfgStr.sclkFrequency = cfgStr.clockratefrequency * txNumOfBitsTransferLocal * cfgStr.numOfChannels;

    sclkPeriod = ((10**9)/cfgStr.sclkFrequency);
    sclkPeriodDivider = (clkFrequency/cfgStr.sclkFrequency);

    `uvm_info(name, $sformatf("clockFrequency=%0d",clkFrequency), UVM_NONE)
    `uvm_info(name, $sformatf("Serial clockFrequency=%0d",cfgStr.sclkFrequency), UVM_NONE)
    `uvm_info(name, $sformatf("Sclk clockperiod=%0d ns",sclkPeriod), UVM_NONE)
    `uvm_info(name, $sformatf("Sclk Period Divider=%0d",sclkPeriodDivider), UVM_NONE)

  endfunction: generateSclkPeriod

//TX MASTER
  task driveDataWhenTxMaster(inout i2sTransferPacketStruct dataPacketStruct, 
                 input i2sTransferCfgStruct configPacketStruct);

    `uvm_info(name, $sformatf("IN TRANSMITTER DRIVER- Starting the drive data method mode=%d",configPacketStruct.mode), UVM_NONE);
   
     repeat(configPacketStruct.numOfChannels) 
        begin
      	 generateWsAndDriveSdWhenTxMaster(dataPacketStruct,configPacketStruct);
        end
       idleState();
  endtask: driveDataWhenTxMaster

  task idleState();
     @(posedge sclkOutput)
       $display("Inside Idle State");
       wsOutput <= WS_DEFAULT; 
       state    <= IDLE; 
  endtask:idleState

task generateWsAndDriveSdWhenTxMaster(inout i2sTransferPacketStruct dataPacketStruct, input i2sTransferCfgStruct configPacketStruct);
  txNumOfBitsTransferLocal= configPacketStruct.wordSelectPeriod/2;
 
   if(dataPacketStruct.ws==1'b1) 
      begin
        `uvm_info(name, $sformatf("IN TRANSMITTER DRIVER- Driving data from left channel"), UVM_NONE);
        
       for(int i=0; i< txNumOfBitsTransferLocal/DATA_WIDTH;i++) 
          begin
            leftChannelDriveSdAndWsWhenTxMaster(dataPacketStruct.sdLeftChannel[i],dataPacketStruct,configPacketStruct);
          end
       end

    else if(dataPacketStruct.ws==1'b0) 
      begin
        `uvm_info(name, $sformatf("IN TRANSMITTER DRIVER- Driving data from Right channel"), UVM_NONE);
       
        for(int i=0; i< txNumOfBitsTransferLocal/DATA_WIDTH;i++) 
          begin
	   rightChannelDriveSdAndWsWhenTxMaster(dataPacketStruct.sdRightChannel[i],dataPacketStruct,configPacketStruct);    
          end
      end

     dataPacketStruct.ws = ~ dataPacketStruct.ws;  

  endtask: generateWsAndDriveSdWhenTxMaster

  task leftChannelDriveSdAndWsWhenTxMaster(input bit[7:0]serialData,input i2sTransferPacketStruct dataPacketStruct,input i2sTransferCfgStruct configPacketStruct);
    `uvm_info("DEBUG", $sformatf("IN TRANSMITTER DRIVER- Driving Left Channel Serial Data = %b",serialData), UVM_NONE) 
    
    for(int k=0; k<DATA_WIDTH; k++) 
      begin
        static int bit_no=0;
        bit_no = (configPacketStruct.dataTransferDirection==MSB_FIRST)?((DATA_WIDTH - 1) - k) :k;
        @(posedge sclkOutput)
          state <= LEFT_CHANNEL;
          wsOutput <= dataPacketStruct.ws;
          sd <= serialData[bit_no];
         `uvm_info("DEBUG", $sformatf("IN TRANSMITTER DRIVER- Driving Left Channel Serial data[%0d] = %b at time:%0t",bit_no,serialData[bit_no],$time), UVM_NONE)
      end
    `uvm_info(name, $sformatf("IN TRANSMITTER DRIVER- Generating Left Channel serial data end"), UVM_NONE)
  endtask: leftChannelDriveSdAndWsWhenTxMaster


  task rightChannelDriveSdAndWsWhenTxMaster(input bit[7:0]serialData, input i2sTransferPacketStruct dataPacketStruct,input i2sTransferCfgStruct configPacketStruct);
    `uvm_info("DEBUG", $sformatf("IN TRANSMITTER DRIVER- Driving Right Channel Serial Data = %b",serialData), UVM_NONE) 

    for(int k=0; k<DATA_WIDTH; k++) 
      begin
        static int bit_no=0;
        bit_no = (configPacketStruct.dataTransferDirection==MSB_FIRST)?((DATA_WIDTH - 1) - k) :k;
        @(posedge sclkOutput)
	  state <= RIGHT_CHANNEL;
          wsOutput <= dataPacketStruct.ws;     
          sd <= serialData[bit_no];
        `uvm_info("DEBUG", $sformatf("IN TRANSMITTER DRIVER- Driving Right Channel Serial data[%0d] = %b at time:%0t",bit_no,serialData[bit_no],$time), UVM_NONE)
      end
    `uvm_info(name, $sformatf("IN TRANSMITTER DRIVER- Generating Right Channel serial data end"), UVM_NONE)
  endtask: rightChannelDriveSdAndWsWhenTxMaster

 // TX SLAVE
  task driveDataWhenTxSlave(inout i2sTransferPacketStruct dataPacketStruct, input i2sTransferCfgStruct configPacketStruct);
    begin
      txNumOfBitsTransferLocal= configPacketStruct.wordSelectPeriod/2;

      initialDetectWsfromUnknown(); 
      repeat(configPacketStruct.numOfChannels)
        begin
          detectWsToggleAndDriveSdWhenTxSlave(dataPacketStruct,configPacketStruct);
        end
    end
  endtask :driveDataWhenTxSlave

  task initialDetectWsfromUnknown();
    logic [1:0] wsLocal;

    if (wsInput===1'bx)
      begin
        $display("................IN TRANSMITTER DRIVER- In detect WS task before WS change from unknown............., WS= %0d at %0t",wsInput,$time);

        wsLocal <= 2'b01;
        do begin
          @(posedge sclkInput);

          wsLocal = {wsLocal[0], wsInput};
        end while (wsLocal===2'b1x);
      end
    $display("................IN TRANSMITTER DRIVER-In detect WS task after WS change from unknown............., WS= %0d at %0t",wsInput,$time);

  endtask: initialDetectWsfromUnknown


  task detectWsToggleAndDriveSdWhenTxSlave(inout i2sTransferPacketStruct dataPacketStruct,input i2sTransferCfgStruct configPacketStruct);
     
    if(wsInput == 1'b1) 
      begin
         driveLeftChannelSerialDataWhenTxSlave(dataPacketStruct,configPacketStruct);
      end
 
     else if(wsInput == 1'b0) 
      begin
         driveRightChannelSerialDataWhenTxSlave(dataPacketStruct,configPacketStruct);
      end

  endtask: detectWsToggleAndDriveSdWhenTxSlave

 task driveLeftChannelSerialDataWhenTxSlave(inout i2sTransferPacketStruct dataPacketStruct,input i2sTransferCfgStruct configPacketStruct);
    logic [1:0] wsLocal;
    static int counterSd;
    static bit [7:0] sdLocal='b00000000;
     
     wsLocal = 2'b11; 
     counterSd=0;
     do begin
       if (counterSd==0)
         begin
           for(int i=0; i< txNumOfBitsTransferLocal/DATA_WIDTH;i++) 
            begin
              if (wsInput==1)
		begin
                 leftChannelDriveSdWhenTxSlave(dataPacketStruct.sdLeftChannel[i],configPacketStruct);  
		end
              else
        	 break;
            end
         counterSd= 1;
        end
      else
        begin
          leftChannelDriveSdWhenTxSlave(sdLocal,configPacketStruct);      
        end  
     wsLocal = {wsLocal[0], wsInput}; 
     end while((wsLocal == 2'b11) );

 endtask: driveLeftChannelSerialDataWhenTxSlave 

 task driveRightChannelSerialDataWhenTxSlave(inout i2sTransferPacketStruct dataPacketStruct,input i2sTransferCfgStruct configPacketStruct);
    logic [1:0] wsLocal;
    static int counterSd;
    static bit [7:0] sdLocal='b00000000;
    
     wsLocal = 2'b00; 
     counterSd=0;
     do begin
       if (counterSd==0)
         begin
          for(int i=0; i< txNumOfBitsTransferLocal/DATA_WIDTH;i++) 
            begin
             if (wsInput==0)
               begin
                 rightChannelDriveSdWhenTxSlave(dataPacketStruct.sdRightChannel[i],configPacketStruct);  
               end
             else
        	break;
           end
         counterSd= 1;
        end
      else
        begin
          rightChannelDriveSdWhenTxSlave(sdLocal,configPacketStruct);      
        end  
     wsLocal = {wsLocal[0], wsInput}; 
     end while((wsLocal == 2'b00) );
   
 endtask: driveRightChannelSerialDataWhenTxSlave 

 task leftChannelDriveSdWhenTxSlave(input bit[7:0]serialData,input i2sTransferCfgStruct configPacketStruct);
    `uvm_info("DEBUG", $sformatf("IN TRANSMITTER DRIVER- Driving Left Channel Serial Data = %b",serialData), UVM_NONE) 

    for(int k=0; k<DATA_WIDTH; k++) 
      begin
        static int bit_no=0;
         bit_no = (configPacketStruct.dataTransferDirection==MSB_FIRST)?((DATA_WIDTH - 1) - k) :k;
        sd <= serialData[bit_no];
        state <= LEFT_CHANNEL;
        `uvm_info("DEBUG", $sformatf("IN TRANSMITTER DRIVER- Driving Left Channel Serial data[%0d] = %b at time:%0t",bit_no,serialData[bit_no],$time), UVM_NONE)
       @(posedge sclkInput);

      end
    `uvm_info(name, $sformatf("IN TRANSMITTER DRIVER- Generating Left Channel serial data end"), UVM_NONE)
  endtask: leftChannelDriveSdWhenTxSlave


  task rightChannelDriveSdWhenTxSlave(input bit[7:0]serialData,input i2sTransferCfgStruct configPacketStruct);
    `uvm_info("DEBUG", $sformatf("IN TRANSMITTER DRIVER- Driving Right Channel Serial Data = %b",serialData), UVM_NONE) 

    for(int k=0; k<DATA_WIDTH; k++) 
      begin
        static int bit_no=0;
        bit_no = (configPacketStruct.dataTransferDirection==MSB_FIRST)?((DATA_WIDTH - 1) - k) :k;
       	sd <= serialData[bit_no];
        state <= RIGHT_CHANNEL;
        `uvm_info("DEBUG", $sformatf("IN TRANSMITTER DRIVER- Driving Right Channel Serial data[%0d] = %b at time:%0t",bit_no,serialData[bit_no],$time), UVM_NONE)
         @(posedge sclkInput);

      end
    `uvm_info(name, $sformatf("IN TRANSMITTER DRIVER- Generating Right Channel serial data end"), UVM_NONE)
  endtask: rightChannelDriveSdWhenTxSlave

endinterface : I2sTransmitterDriverBFM
`endif

  
