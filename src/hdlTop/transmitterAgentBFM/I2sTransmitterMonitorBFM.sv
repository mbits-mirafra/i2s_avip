`ifndef I2STRANSMITTERMONITORBFM_INCLUDED_
`define I2STRANSMITTERMONITORBFM_INCLUDED_

import I2sGlobalPkg::*;

interface I2sTransmitterMonitorBFM(input clk, 
                                   input rst,
                                   input sclk,
                                   input sclkOutput,
                                   input ws,
                                   input wsOutput,
                                   input sd);


  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import I2sTransmitterPkg::I2sTransmitterMonitorProxy;

  I2sTransmitterMonitorProxy i2sTransmitterMonitorProxy;
  string name = "I2sTransmitterMonitorBFM";

  task waitForReset();
    @(posedge rst);
    `uvm_info("IN MONITOR- FROM TRANSMITTER MON BFM",$sformatf("SYSTEM RESET ACTIVATED"),UVM_NONE)
    @(negedge rst);
    `uvm_info("IN MONITOR- FROM TRANSMITTER MON BFM",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_NONE)
  endtask : waitForReset


  task sampleData(inout i2sTransferPacketStruct packetStruct, input i2sTransferCfgStruct configStruct);                                     

    `uvm_info(name, $sformatf("IN MONITOR- Starting the Monitor Data method"), UVM_NONE);
    if(configStruct.mode == TX_MASTER || TX_SLAVE)
      begin
        if(ws===1'bx) begin
          initialDetectWsfromUnknown(packetStruct);
        end
        detectWs(packetStruct,configStruct);

      end
  endtask : sampleData


  task initialDetectWsfromUnknown(inout i2sTransferPacketStruct packetStruct);
    logic [1:0] wsLocal;
    $display("IN MONITOR- INITIAL detection of  WS: %0d at %0t",ws,$time);

    if (ws===1'bx)
      begin

        wsLocal = 2'b01;
        do begin
          @(posedge sclk);

          wsLocal = {wsLocal[0], ws};
        end while (wsLocal===2'b1x);
      end

  endtask: initialDetectWsfromUnknown

  task detectWs(inout i2sTransferPacketStruct packetStruct,input i2sTransferCfgStruct configStruct);
    logic [1:0] wsLocal;

    if(ws == 1) begin
      wsLocal = 2'b11;
      do begin
        @(negedge sclk);
        packetStruct.numOfBitsTransfer=0;

        for(int i=0;i<configStruct.numOfBitsTransfer/DATA_WIDTH;i++) 
          begin
            packetStruct.ws=ws;
            SampleSdFromLeftChannel(packetStruct,i);
          end

        wsLocal = {wsLocal[0], ws};
      end while((wsLocal == 2'b11));
    end
    else if (ws==0)
      begin
        wsLocal = 2'b00;
        do begin
          @(negedge sclk);
          packetStruct.numOfBitsTransfer=0;

          for(int i=0;i<configStruct.numOfBitsTransfer/DATA_WIDTH;i++) 
            begin
              packetStruct.ws=ws;
              SampleSdFromRightChannel(packetStruct,i);
            end

          wsLocal = {wsLocal[0], ws};
        end while((wsLocal == 2'b00));
      end
    `uvm_info(name, $sformatf("IN MONITOR- Monitor detect WS END"),UVM_NONE);

  endtask: detectWs

  task SampleSdFromLeftChannel(inout i2sTransferPacketStruct packetStruct,input int i);
    bit [DATA_WIDTH-1:0] serialdata;
    $display("IN MONITOR- Monitor sample SD from left channel task");

    for(int k=DATA_WIDTH-1; k>=0; k--) begin 
      packetStruct.numOfBitsTransfer++;
      serialdata[k] = sd; 
      //$display("IN TRASNMITTER MONITOR-LEFT CHANNEL SERIAL DATA[%0d]=%b at time:%0t",k,sd,$time);
      `uvm_info(name, $sformatf("IN TRASNMITTER MONITOR-LEFT CHANNEL SERIAL DATA[%0d]=%b",k,sd),UVM_NONE);     
      @(posedge sclk);
      if(ws==1) begin
        @(negedge sclk);
      end
    end
    packetStruct.sd[i] = serialdata;

  endtask : SampleSdFromLeftChannel


  task SampleSdFromRightChannel(inout i2sTransferPacketStruct packetStruct,input int i);
    bit [DATA_WIDTH-1:0] serialdata;
    $display("IN MONITOR- Monitor sample SD from right channel task");

    for(int k=DATA_WIDTH-1; k>=0; k--) begin 
      packetStruct.numOfBitsTransfer++;       
      serialdata[k] = sd;  
      //$display("IN TRASNMITTER MONITOR-RIGHT CHANNEL SERIAL DATA[%0d]=%b at time:%0t",k,sd,$time);
      `uvm_info(name, $sformatf("IN TRASNMITTER MONITOR-RIGHT CHANNEL SERIAL DATA[%0d]=%b",k,sd),UVM_NONE);           
      @(posedge sclk);
      if(ws==0) begin
        @(negedge sclk);
      end
    end
    packetStruct.sd[i] = serialdata;
  endtask : SampleSdFromRightChannel

endinterface : I2sTransmitterMonitorBFM
`endif


