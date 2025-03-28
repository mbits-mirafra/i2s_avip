`ifndef I2SRECEIVERMONITORBFM_INCLUDED_
`define I2SRECEIVERMONITORBFM_INCLUDED_

import I2sGlobalPkg::*;

interface I2sReceiverMonitorBFM(input clk, 
                                input rst,
                                input sclk,
                                input sclkOutput,
                                input ws,
                                input wsOutput,
                                input sd);

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import I2sReceiverPkg::I2sReceiverMonitorProxy;

  I2sReceiverMonitorProxy i2sReceiverMonitorProxy;
  string name = "I2sReceiverMonitorBFM";

  int txNumOfBitsTransfer;
  int rxNumOfBitsTransfer;


  import I2sTransmitterPkg::I2sTransmitterAgentConfig;
  import I2sReceiverPkg::I2sReceiverAgentConfig;

  I2sTransmitterAgentConfig i2sTransmitterAgentConfig;
  I2sReceiverAgentConfig i2sReceiverAgentConfig;


  initial begin
    start_of_simulation_ph.wait_for_state(UVM_PHASE_STARTED);

     if(!uvm_config_db#(I2sTransmitterAgentConfig)::get(null, "*", "I2sTransmitterAgentConfig",i2sTransmitterAgentConfig)) begin
    `uvm_fatal("FATAL_TRANSMITTER_CANNOT_GET_IN_INTERFACE","cannot get() i2sTransmitterAgentConfig"); 
    end
 
    if(!uvm_config_db#(I2sReceiverAgentConfig)::get(null, "*", "I2sReceiverAgentConfig",i2sReceiverAgentConfig)) begin
    `uvm_fatal("FATAL_TRANSMITTER_CANNOT_GET_IN_INTERFACE","cannot get() i2sTransmitterAgentConfig"); 
    end
    
    end

  task waitForReset();
    @(negedge rst);
    `uvm_info("IN RECEIVER MONITOR- FROM Receiver MON BFM",$sformatf("SYSTEM RESET ACTIVATED"),UVM_NONE)
    @(posedge rst);
    `uvm_info("IN RECEIVER MONITOR- FROM Receiver MON BFM",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_NONE)
  endtask : waitForReset

  task samplePacket(inout i2sTransferPacketStruct packetStruct, input i2sTransferCfgStruct configStruct);                                     

    `uvm_info(name, $sformatf("IN RECEIVER MONITOR- Starting the Monitor Data method"), UVM_NONE)

    txNumOfBitsTransfer=i2sTransmitterAgentConfig.wordSelectPeriod/2;
    rxNumOfBitsTransfer=i2sReceiverAgentConfig.wordSelectPeriod/2;

    if(configStruct.mode == TX_MASTER || TX_SLAVE)
      begin
        if(ws===1'bx) begin
          initialDetectWsfromUnknown(packetStruct);
        end
        detectWs(packetStruct); 
      end

  endtask : samplePacket

  task initialDetectWsfromUnknown(inout i2sTransferPacketStruct packetStruct);
    logic [1:0] wsLocal;

    if (ws===1'bx)
      begin
        wsLocal = 2'b01;
        do begin
          @(posedge sclk);

          wsLocal = {wsLocal[0], ws};
        end while (wsLocal===2'b1x);
      end

  endtask: initialDetectWsfromUnknown

 task detectWs(inout i2sTransferPacketStruct packetStruct);
    logic [1:0] wsLocal;
         
    if(ws == 1) begin
      wsLocal = 2'b11;
      packetStruct.numOfBitsTransfer=0;
      do begin
        @(negedge sclk);
      
        for (int i=0; i<MAXIMUM_SIZE;i++)
          begin
           if (ws==1) 
            begin
	      packetStruct.ws=ws;
              SampleSdFromLeftChannel(packetStruct,i);
            end
            else
              break;
          end

        wsLocal = {wsLocal[0], ws};
      end while((wsLocal == 2'b11));
    end
    else if (ws==0)
      begin
        wsLocal = 2'b00;
	packetStruct.numOfBitsTransfer=0;
        do begin
          @(negedge sclk);
          for (int i=0; i<MAXIMUM_SIZE;i++)
            begin
               if (ws==0) 
               begin
		 packetStruct.ws=ws;
                 SampleSdFromRightChannel(packetStruct,i);
               end
               else
                 break;
            end

          wsLocal = {wsLocal[0], ws};
        end while((wsLocal == 2'b00));
      end
    `uvm_info(name, $sformatf("IN RECEIVER MONITOR- Monitor detect WS END"),UVM_NONE);

  endtask: detectWs

  
  task SampleSdFromLeftChannel(inout i2sTransferPacketStruct packetStruct,input int i);
    bit [DATA_WIDTH-1:0] serialdata;
    `uvm_info(name, $sformatf("IN RECEIVER MONITOR- Monitor sample SD from left channel task"), UVM_LOW)
    for(int k=DATA_WIDTH-1; k>=0; k--) 
      begin 
        serialdata[k] = sd; 
        packetStruct.numOfBitsTransfer++;
        `uvm_info(name, $sformatf("IN RECEIVER MONITOR-LEFT CHANNEL SERIAL DATA[%0d]=%b",k,sd), UVM_LOW)
        @(posedge sclk);
        if(ws==1) 
          begin
            @(negedge sclk);
          end
      end
    packetStruct.sdLeftChannel[i] = serialdata;
    packetStruct.sdRightChannel[i]=0;

  endtask : SampleSdFromLeftChannel

  task SampleSdFromRightChannel(inout i2sTransferPacketStruct packetStruct,input int i);
    bit [DATA_WIDTH-1:0] serialdata;
    `uvm_info(name, $sformatf("IN RECEIVER MONITOR- Monitor sample SD from right channel task"), UVM_LOW)
    for(int k=DATA_WIDTH-1; k>=0; k--) 
      begin 
        serialdata[k] = sd; 
        packetStruct.numOfBitsTransfer++;    
        `uvm_info(name, $sformatf("IN RECEIVER MONITOR-RIGHT CHANNEL SERIAL DATA[%0d]=%b",k,sd), UVM_LOW)
        `uvm_info(name, $sformatf("Last Right channel serial data:%0d",serialdata), UVM_LOW)
        @(posedge sclk);
        if(ws==0) 
          begin
            @(negedge sclk);
          end
      end
    packetStruct.sdRightChannel[i] = serialdata;
    packetStruct.sdLeftChannel[i]=0;

  endtask : SampleSdFromRightChannel

endinterface : I2sReceiverMonitorBFM
`endif


