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
  int txNumOfBitsTransfer;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import I2sTransmitterPkg::I2sTransmitterDriverProxy;

  I2sTransmitterDriverProxy i2sTransmitterDriverProxy;

  i2sStateEnum state;

  string name = "I2sTransmitterDriverBFM";

  import I2sTransmitterPkg::I2sTransmitterAgentConfig;
 
  I2sTransmitterAgentConfig i2sTransmitterAgentConfig;

  initial begin
    start_of_simulation_ph.wait_for_state(UVM_PHASE_STARTED);

     if(!uvm_config_db#(I2sTransmitterAgentConfig)::get(null, "*", "I2sTransmitterAgentConfig",i2sTransmitterAgentConfig)) begin
    `uvm_fatal("FATAL_TRANSMITTER_CANNOT_GET_IN_INTERFACE","cannot get() i2sTransmitterAgentConfig"); 
    
    end
   end

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

    txNumOfBitsTransfer= i2sTransmitterAgentConfig.wordSelectPeriod/2;
    
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

    cfgStr.sclkFrequency = cfgStr.clockratefrequency * txNumOfBitsTransfer * cfgStr.numOfChannels;

    sclkPeriod = ((10**9)/cfgStr.sclkFrequency);
    sclkPeriodDivider = (clkFrequency/cfgStr.sclkFrequency);

    `uvm_info(name, $sformatf("clockFrequency=%0d",clkFrequency), UVM_NONE)
    `uvm_info(name, $sformatf("Serial clockFrequency=%0d",cfgStr.sclkFrequency), UVM_NONE)
    `uvm_info(name, $sformatf("Sclk clockperiod=%0d ns",sclkPeriod), UVM_NONE)
    `uvm_info(name, $sformatf("Sclk Period Divider=%0d",sclkPeriodDivider), UVM_NONE)

  endfunction: generateSclkPeriod

  task driveData(inout i2sTransferPacketStruct dataPacketStruct, 
                 input i2sTransferCfgStruct configPacketStruct);

    `uvm_info(name, $sformatf("IN TRANSMITTER DRIVER- Starting the drive data method mode=%d",configPacketStruct.mode), UVM_NONE);

    fork
      genWs(dataPacketStruct,configPacketStruct);
      repeat(configPacketStruct.numOfChannels) 
        begin
	 detectWsAndDriveSdWhenTxMaster(dataPacketStruct);
        end
    join

  endtask: driveData

  task genWs(inout i2sTransferPacketStruct dataPacketStruct, input i2sTransferCfgStruct configPacketStruct);
    static int counter=0;
     timeout_ws = configPacketStruct.numOfChannels;   
    `uvm_info(name, $sformatf("IN TRANSMITTER DRIVER-Generating the WS"), UVM_NONE)
      
    forever begin
      @(posedge sclkOutput);

      if (counter == (configPacketStruct.wordSelectPeriod/2))
        begin
	 timeout_ws=timeout_ws-1;
          if(timeout_ws==0) begin
            wsOutput <= WS_DEFAULT; 
	    state<=IDLE;
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

    `uvm_info(name, $sformatf("IN TRANSMITTER DRIVER-Generating the WS ended"), UVM_NONE)
  endtask: genWs                

  task detectWsAndDriveSdWhenTxMaster(inout i2sTransferPacketStruct dataPacketStruct);

    if(dataPacketStruct.ws==1'b1) 
      begin
        `uvm_info(name, $sformatf("IN TRANSMITTER DRIVER- Driving data from left channel"), UVM_NONE);
        for(int i=0; i<dataPacketStruct.numOfBitsTransfer/DATA_WIDTH;i++) 
          begin
            LeftChanneldriveSdWhenTxMaster(dataPacketStruct.sd[i]);
          end
      end

    else if(dataPacketStruct.ws==1'b0) 
      begin
        `uvm_info(name, $sformatf("IN TRANSMITTER DRIVER- Driving data from Right channel"), UVM_NONE);
        for(int i=0; i<dataPacketStruct.numOfBitsTransfer/DATA_WIDTH;i++) 
          begin
	   RightChanneldriveSdWhenTxMaster(dataPacketStruct.sd[i]);    
          end
      end

  endtask: detectWsAndDriveSdWhenTxMaster


  task LeftChanneldriveSdWhenTxMaster(input bit[7:0] serialdata);
    `uvm_info("DEBUG", $sformatf("IN TRANSMITTER DRIVER- Driving Left SerialData = %b",serialdata), UVM_NONE) 

    for(int k=0; k<DATA_WIDTH; k++) 
      begin
        static int bit_no=0;
        bit_no = (DATA_WIDTH - 1) - k;
        @(posedge sclkOutput)
     	sd <= serialdata[bit_no];
        `uvm_info("DEBUG", $sformatf("IN TRANSMITTER DRIVER- Driving Left Serial data[%0d] = %b at time:%0t",bit_no, serialdata[bit_no],$time), UVM_NONE)
      end
    `uvm_info(name, $sformatf("IN TRANSMITTER DRIVER- Generating Left serial data end"), UVM_NONE)
  endtask: LeftChanneldriveSdWhenTxMaster


  task RightChanneldriveSdWhenTxMaster(input bit[7:0] serialdata);
    `uvm_info("DEBUG", $sformatf("IN TRANSMITTER DRIVER- Driving Right SerialData = %b",serialdata), UVM_NONE) 

    for(int k=0; k<DATA_WIDTH; k++) 
      begin
        static int bit_no=0;
        bit_no = (DATA_WIDTH - 1) - k;
        @(posedge sclkOutput)
        sd <= serialdata[bit_no];
        `uvm_info("DEBUG", $sformatf("IN TRANSMITTER DRIVER- Driving Right Serial data[%0d] = %b at time:%0t",bit_no, serialdata[bit_no],$time), UVM_NONE)
      end
    `uvm_info(name, $sformatf("IN TRANSMITTER DRIVER- Generating serial Right data end"), UVM_NONE)
  endtask: RightChanneldriveSdWhenTxMaster


  task detectWsandDriveSD(inout i2sTransferPacketStruct dataPacketStruct, input i2sTransferCfgStruct configPacketStruct);
    begin
      txNumOfBitsTransfer= i2sTransmitterAgentConfig.wordSelectPeriod/2;

      initialDetectWsfromUnknown(); 
      repeat(configPacketStruct.numOfChannels)
        begin
          detectWsToggleAndDriveSdWhenTxSlave(dataPacketStruct,configPacketStruct);
        end
    end
  endtask :detectWsandDriveSD

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



  task detectWsToggleAndDriveSdWhenTxSlave(inout i2sTransferPacketStruct dataPacketStruct, input i2sTransferCfgStruct configPacketStruct);

    logic [1:0] wsLocal;
    static int counterSd;
    static bit [7:0] sdLocal='b00000000;
     
    if(wsInput == 1'b1) 
      begin
       wsLocal = 2'b11; 
       counterSd=0;
        do begin
         if (counterSd==0)
           begin
             for(int i=0; i< txNumOfBitsTransfer/DATA_WIDTH;i++) 
              begin
               if (wsInput==1)
		begin
                  driveSerialDataTxSlave(dataPacketStruct.sd[i]);  
		end
               else
		 break;
              end
            counterSd= 1;
           end
         else
           begin
            driveSerialDataTxSlave(sdLocal);      
           end  
         wsLocal = {wsLocal[0], wsInput}; 
        end while((wsLocal == 2'b11) );
      end
 
     else if(wsInput == 1'b0) 
      begin
       wsLocal = 2'b00; 
       counterSd=0;
        do begin
         if (counterSd==0)
           begin
             for(int i=0; i< txNumOfBitsTransfer/DATA_WIDTH;i++) 
              begin
               if (wsInput==0)
		begin
                 driveSerialDataTxSlave(dataPacketStruct.sd[i]);  
		end
              end
            counterSd= 1;
           end
         else
           begin
            driveSerialDataTxSlave(sdLocal);      
           end  
         wsLocal = {wsLocal[0], wsInput}; 
        end while((wsLocal == 2'b00) );
      end

  endtask: detectWsToggleAndDriveSdWhenTxSlave

  task driveSerialDataTxSlave(input bit[7:0] serialdata);
    `uvm_info("DEBUG", $sformatf("IN TRANSMITTER DRIVER- Driving SerialData = %b",serialdata), UVM_NONE)

    for(int k=0; k<DATA_WIDTH; k++) begin
      static int bit_no=0;
      bit_no = (DATA_WIDTH - 1) - k;
      sd <= serialdata[bit_no];
      `uvm_info("DEBUG", $sformatf("IN TRANSMITTER DRIVER- Driving Serial data[%0d] = %b at time %0t",bit_no, serialdata[bit_no], $time), UVM_NONE)
      @(posedge sclkInput);
    end
    `uvm_info(name, $sformatf("IN TRANSMITTER DRIVER- Generating serial data end"), UVM_NONE)
  endtask: driveSerialDataTxSlave


endinterface : I2sTransmitterDriverBFM
`endif


