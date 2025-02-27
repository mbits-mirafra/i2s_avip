`ifndef I2SRECEIVERASSERTIONS_INCLUDED_
`define I2SRECEIVERASSERTIONS_INCLUDED_

import I2sGlobalsPackage::*;

interface I2sReceiverAssertions (input  clk,
                                 input  rst,
				    input sclk,
				    input ws,
				    input [DATA_WIDTH-1:0] sd);
 
  import uvm_pkg::*;
  `include "uvm_macros.svh";


  initial begin
    `uvm_info("I2sReceiverAssertions","I2sReceiverAssertions",UVM_LOW);
  end


  property wsNotUnknown();
      @(negedge sclk) disable iff (rst)
          !($isunknown(ws));
  endproperty

 WS_NOT_UNKNOWN: assert property (wsNotUnknown)
  $info("WS_NOT_UNKNOWN: ASSERTED");
  else
    $error("WS_NOT_UNKNOWN : NOT ASSERTED");
 
  sequence wsSeqCheckNegedge;
      @(negedge sclk)
          $changed(ws);
   endsequence
 
  sequence wsSeqCheckPosedge;
      @(posedge sclk)
          $changed(ws);
   endsequence

  property wsAlignWithSclk();
     wsSeqCheckPosedge or wsSeqCheckNegedge;
  endproperty

  WS_ALIGN_WITH_SCLK :assert property(wsAlignWithSclk)
    $info("WS_ALIGN_WITH_SCLK :ASSERTED");
    else
    $error("WS_ALIGN_WITH_SCLK :NOT ASSERTED");

  property sclkSamplingRate48khzAnd8BitsDataTransaction(int clkPeriod,int numOfTransferBits);
	realtime currentTime;
   @(posedge sclk) disable iff (rst)
  ('1,currentTime=$realtime) |=> (($realtime - currentTime) == (clkPeriod));
  endproperty
  
  SCLK_SAMPLING_RATE_48KHZ_8BITS_DATA_TRASACTION: assert property (sclkSamplingRate48khzAnd8BitsDataTransaction((20834,8))  
      $info("SCLK_SAMPLING_RATE_48KHZ: ASSERTED");
      else
      $error("SCLK_SAMPLING_RATE_48KHZ: NOT ASSERTED");
           


endinterface : I2sReceiverAssertions

`endif
