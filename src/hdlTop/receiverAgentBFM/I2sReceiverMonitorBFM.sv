`ifndef I2SRECEIVERMONITORBFM_INCLUDED_
`define I2SRECEIVERMONITORBFM_INCLUDED_

import I2sGlobalPkg::*;

interface I2sReceiverMonitorBFM(input clk, 
                                input rst,
                                input sclk,
                                input ws,
                                input sd);

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import I2sReceiverPkg::I2sReceiverMonitorProxy;

  I2sReceiverMonitorProxy i2sReceiverMonitorProxy;
  string name = "I2sReceiverMonitorBFM";

  
  task waitForReset();
    @(negedge rst);
    `uvm_info("IN RECEIVER MONITOR- FROM Receiver MON BFM",$sformatf("SYSTEM RESET ACTIVATED"),UVM_NONE)
    @(posedge rst);
    `uvm_info("IN RECEIVER MONITOR- FROM Receiver MON BFM",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_NONE)
  endtask : waitForReset

  task samplePacket(inout i2sTransferPacketStruct packetStruct, input i2sTransferCfgStruct configStruct);                                     

    `uvm_info(name, $sformatf("IN RECEIVER MONITOR- Starting the Monitor Data method"), UVM_NONE)

    if(configStruct.mode == TX_MASTER || TX_SLAVE)
      begin
        if(ws===1'bx) begin
          initialDetectWsfromUnknown(packetStruct);
        end
        detectWsAndSampleSd(packetStruct,configStruct);
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

task detectWsAndSampleSd(inout i2sTransferPacketStruct packetStruct,input i2sTransferCfgStruct configStruct);
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
              SampleSdFromLeftChannel(packetStruct,i,configStruct);
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
                 SampleSdFromRightChannel(packetStruct,i,configStruct);
               end
               else
                 break;
            end

          wsLocal = {wsLocal[0], ws};
        end while((wsLocal == 2'b00));
      end
    `uvm_info(name, $sformatf("IN RECEIVER MONITOR- Monitor detect WS END"),UVM_NONE);

  endtask: detectWsAndSampleSd

  task SampleSdFromLeftChannel(inout i2sTransferPacketStruct packetStruct,input int i,input i2sTransferCfgStruct configStruct);
    bit [DATA_WIDTH-1:0] serialdata;
    `uvm_info(name,$sformatf("IN RECEIVER MONITOR- Monitor Serial Data from left channel task"),UVM_NONE);

    for(int k=0; k<DATA_WIDTH; k++) 
     begin
      static int bit_no=0;
      bit_no = (configStruct.dataTransferDirection==MSB_FIRST)?((DATA_WIDTH - 1) - k) :k;
      serialdata[bit_no] = sd;
      packetStruct.numOfBitsTransfer++;
      `uvm_info(name, $sformatf("IN RECEIVER MONITOR-LEFT CHANNEL SERIAL DATA[%0d]=%0b",bit_no,sd),UVM_NONE);     
      @(posedge sclk);
      if(ws==1) begin
        @(negedge sclk);
     end
    end
   packetStruct.sdLeftChannel[i] = serialdata;
   packetStruct.sdRightChannel[i]=0;

  endtask : SampleSdFromLeftChannel


  task SampleSdFromRightChannel(inout i2sTransferPacketStruct packetStruct,input int i,input i2sTransferCfgStruct configStruct);
    bit [DATA_WIDTH-1:0] serialdata;
   `uvm_info(name,$sformatf("IN RECEIVER MONITOR- Monitor Serial Data from right channel task"),UVM_NONE);
   
   for(int k=0; k<DATA_WIDTH; k++) 
     begin
      static int bit_no=0;
      bit_no = (configStruct.dataTransferDirection==MSB_FIRST)?((DATA_WIDTH - 1) - k) :k;
      serialdata[bit_no] = sd;
      packetStruct.numOfBitsTransfer++; 
      `uvm_info(name, $sformatf("IN RECEIVER MONITOR-RIGHT CHANNEL SERIAL DATA[%0d]=%0b",bit_no,sd),UVM_NONE);           
      @(posedge sclk);
      if(ws==0) begin
        @(negedge sclk);
      end
    end
    packetStruct.sdRightChannel[i] = serialdata;
    packetStruct.sdLeftChannel[i]=0;

  endtask : SampleSdFromRightChannel

 endinterface : I2sReceiverMonitorBFM
`endif


