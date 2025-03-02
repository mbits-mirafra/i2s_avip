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
 
  task waitForReset();
   @(posedge rst);
    `uvm_info("IN RECEIVER MONITOR- FROM Receiver MON BFM",$sformatf("SYSTEM RESET ACTIVATED"),UVM_NONE)
    @(negedge rst);
    `uvm_info("IN RECEIVER MONITOR- FROM Receiver MON BFM",$sformatf("SYSTEM RESET DEACTIVATED"),UVM_NONE)
  endtask : waitForReset
 
 
  task samplePacket(inout i2sTransferPacketStruct packetStruct, input i2sTransferCfgStruct configStruct);                                     
 
      `uvm_info(name, $sformatf("IN RECEIVER MONITOR- Starting the Monitor Data method"), UVM_NONE);
      if(configStruct.mode == TX_MASTER || TX_SLAVE)
      begin
         initialDetectWsfromUnknown(packetStruct);
         detectWs(packetStruct);
      end
  endtask : samplePacket
 
  task SampleSdFromLeftChannel(inout i2sTransferPacketStruct packetStruct,input int i);
    bit [DATA_WIDTH-1:0] serialdata;
    $display("IN RECEIVER MONITOR- Monitor sample SD from left channel task");
   // packetStruct.numOfBitsTransfer=0;
    for(int k=DATA_WIDTH-1; k>=0; k--) begin 
      serialdata[k] = sd; 
	    packetStruct.numOfBitsTransfer++;
    $display("IN RECEIVER MONITOR-RIGHT CHANNEL SERIAL DATA[%0d]=%b",k,sd);
       @(posedge sclk);
       if(ws==1) begin
         @(negedge sclk);
       end
         
 
	 end
	 packetStruct.sd[i] = serialdata;

  endtask : SampleSdFromLeftChannel
 
task SampleSdFromRightChannel(inout i2sTransferPacketStruct packetStruct,input int i);
    bit [DATA_WIDTH-1:0] serialdata;
    $display("IN RECEIVER MONITOR- Monitor sample SD from right channel task");

    for(int k=DATA_WIDTH-1; k>=0; k--) begin 
        packetStruct.numOfBitsTransfer++;       
           serialdata[k] = sd;     
     $display("IN RECEIVER MONITOR-RIGHT CHANNEL SERIAL DATA[%0d]=%b",k,sd);
      @(posedge sclk);
       if(ws==0) begin
         @(negedge sclk);
       end

       
	end
	 packetStruct.sd[i] = serialdata;
  endtask : SampleSdFromRightChannel
 
  task initialDetectWsfromUnknown(inout i2sTransferPacketStruct packetStruct);
     logic [1:0] wsLocal;

  if (ws===1'bx)
   begin
      $display("................IN RECEIVER MONITOR- In detect WS task before WS change from unknown............., WS= %0d at %0t",ws,$time);

      wsLocal = 2'b01;
      do begin
        @(posedge sclk);

       wsLocal = {wsLocal[0], ws};
      end while (wsLocal===2'b1x);
    end
     $display("................IN RECEIVER MONITOR-In detect WS task after WS change from unknown............., WS= %0d at %0t",ws,$time);
     
 
  endtask: initialDetectWsfromUnknown

task detectWs(inout i2sTransferPacketStruct packetStruct);
     logic [1:0] wsLocal;
       $display("IN RECEIVER MONITOR- Monitor detect WS start %0d at %0t",ws,$time);
    if(ws == 1) begin
      wsLocal = 2'b11;
     do begin
      @(negedge sclk);
     packetStruct.numOfBitsTransfer=0;
       for(int i=0;i<MAXIMUM_SIZE;i++) begin
         packetStruct.ws=ws;
         SampleSdFromLeftChannel(packetStruct,i);
         if(ws!=1)
           break;
      
        end
 
       wsLocal = {wsLocal[0], ws};
     end while((wsLocal == 2'b11) );
   end
    else  
	begin
        wsLocal = 2'b00;
	packetStruct.numOfBitsTransfer=0;
      do begin
         @(negedge sclk);
	 for(int i=0;i<MAXIMUM_SIZE;i++) begin
         packetStruct.ws=ws;
	       SampleSdFromRightChannel(packetStruct,i);
     if(ws!=0)
      break;

	 end
 
       wsLocal = {wsLocal[0], ws};
      end while((wsLocal == 2'b00));
    end  
   `uvm_info(name, $sformatf("IN RECEIVER MONITOR- Monitor detect WS END"),UVM_NONE);
 
 
  endtask: detectWs

endinterface : I2sReceiverMonitorBFM
`endif
