`ifndef I2STRANSMITTERASSERTIONS_INCLUDED_
`define I2STRANSMITTERASSERTIONS_INCLUDED_

import I2sGlobalPkg::*;

interface I2sTransmitterAssertions (input  clk,
                                    input  rst,
				    input sclk,
				    input ws,
				    input [DATA_WIDTH-1:0] sd);
 
  import uvm_pkg::*;
  `include "uvm_macros.svh";
 
 
  initial begin
    `uvm_info("I2sTransmitterAssertions","I2sTransmitterAssertions",UVM_LOW);
  end
 
 
  property wsNotUnknown();
      @(negedge sclk) disable iff (rst)
         $fell(sclk) |-> !($isunknown(ws));
  endproperty
 
WS_NOT_UNKNOWN: assert property (wsNotUnknown)
  $info("WS_NOT_UNKNOWN: ASSERTED");
  else
    $error("WS_NOT_UNKNOWN : NOT ASSERTED");
  sequence wsSeqCheckNegedge;
      @(negedge sclk)
         $fell(sclk) |-> $changed(ws);
   endsequence
  property sdNotUnknown();
      wsSeqCheckNegedge |-> !($isunknown(sd));
  endproperty
 
 
  SD_NOT_UNKNOWN: assert property (sdNotUnknown)
  $info("SD_NOT_UNKNOWN: ASSERTED");
  else
    $error("SD_NOT_UNKNOWN : NOT ASSERTED");
 
property SdZeroWhenReset();
   @(posedge clk) 
      rst |-> sd==0;
endproperty
SD_ZER0_WHEN_RESET :assert property(SdZeroWhenReset)
   $info("SD_ZER0_WHEN_RESET: ASSERTED");
   else
   $error("SD_ZER0_WHEN_RESET:NOT ASSERTED");
 
  sequence wsSeqCheckPosedge;
      @(posedge sclk)
         $rose(sclk) |-> $changed(ws);
   endsequence
 
  property wsAlignWithSclk();
     wsSeqCheckPosedge or wsSeqCheckNegedge;
  endproperty
 
  WS_ALIGN_WITH_SCLK :assert property(wsAlignWithSclk)
    $info("WS_ALIGN_WITH_SCLK :ASSERTED");
    else
    $error("WS_ALIGN_WITH_SCLK :NOT ASSERTED");
 
    
  property msbOfSdAlignWithWsInLeftJustifiedCodecMode();
     disable iff (rst)
        (wsSeqCheckPosedge or wsSeqCheckNegedge) |->  !($isunknown(sd[DATA_WIDTH-1]));
  endproperty
 
  MSB_OF_SD_ALIGN_WITH_WS_IN_LEFT_JUSTIFIED_MODE: assert property(msbOfSdAlignWithWsInLeftJustifiedCodecMode)
     $info("MSB_OF_SD_ALIGN_WITH_WS_IN_LEFT_JUSTIFIED_MODE: ASSERTED");
     else
     $error("MSB_OF_SD_ALIGN_WITH_WS_IN_LEFT_JUSTIFIED_MODE: NOT ASSERTED");
 
  property sclkSamplingRate48khzAnd8BitsDataTransaction(int clkPeriod,int numOfTransferBits);
       realtime currentTime;
       @(posedge sclk) disable iff (rst)
('1,currentTime=$realtime) |=> @(posedge sclk) (($realtime - currentTime) == (clkPeriod));
  endproperty
  SCLK_SAMPLING_RATE_48KHZ_8BITS_DATA_TRASACTION: assert property (sclkSamplingRate48khz(1302,8))  
      $info("SCLK_SAMPLING_RATE_48KHZ_8BITS_DATA_TRASACTION: ASSERTED");
      else
      $error("SCLK_SAMPLING_RATE_48KHZ_8BITS_DATA_TRASACTION: NOT ASSERTED");
 
property sclkSamplingRate48khzAnd16BitsDataTransaction(int clkPeriod,int numOfTransferBits);
       realtime currentTime;
       @(posedge sclk) disable iff (rst)
('1,currentTime=$realtime) |=> @(posedge sclk) (($realtime - currentTime) == (clkPeriod));
  endproperty
  SCLK_SAMPLING_RATE_48KHZ_16BITS_DATA_TRASACTION: assert property (sclkSamplingRate48khz(651,16))  
      $info("SCLK_SAMPLING_RATE_48KHZ_16BITS_DATA_TRASACTION: ASSERTED");
      else
      $error("SCLK_SAMPLING_RATE_48KHZ_16BITS_DATA_TRASACTION: NOT ASSERTED");           
 
  property sclkSamplingRate48khzAnd24BitsDataTransaction(int clkPeriod,int numOfTransferBits);
       realtime currentTime;
       @(posedge sclk) disable iff (rst)
('1,currentTime=$realtime) |=> @(posedge sclk) (($realtime - currentTime) == (clkPeriod));
  endproperty
  SCLK_SAMPLING_RATE_48KHZ_24BITS_DATA_TRASACTION: assert property (sclkSamplingRate48khz(434,24))  
      $info("SCLK_SAMPLING_RATE_48KHZ_24BITS_DATA_TRASACTION: ASSERTED");
      else
      $error("SCLK_SAMPLING_RATE_48KHZ_24BITS_DATA_TRASACTION: NOT ASSERTED");
 
   property sclkSamplingRate48khzAnd32BitsDataTransaction(int clkPeriod,int numOfTransferBits);
       realtime currentTime;
       @(posedge sclk) disable iff (rst)
('1,currentTime=$realtime) |=> @(posedge sclk) (($realtime - currentTime) == (clkPeriod));
  endproperty
  SCLK_SAMPLING_RATE_48KHZ_32BITS_DATA_TRASACTION: assert property (sclkSamplingRate48khz(325,32))  
      $info("SCLK_SAMPLING_RATE_48KHZ_32BITS_DATA_TRASACTION: ASSERTED");
      else
      $error("SCLK_SAMPLING_RATE_48KHZ_32BITS_DATA_TRASACTION: NOT ASSERTED");  
 
endinterface : I2sTransmitterAssertions
 
`endif
