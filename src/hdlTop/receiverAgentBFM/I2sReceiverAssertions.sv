`ifndef I2SRECEIVERASSERTIONS_INCLUDED_
`define I2SRECEIVERASSERTIONS_INCLUDED_

import I2sGlobalPkg::*;

interface I2sReceiverAssertions (input  clk,
                                    input  rst,
				    input sclk,
				    input ws,
				    input sd);
  import uvm_pkg::*;
  `include "uvm_macros.svh";
  
  initial begin
    `uvm_info("I2sReceiverAssertions","I2sReceiverAssertions",UVM_LOW);
  end

  property SdZeroWhenReset();
   @(posedge clk) 
      (rst==0) |-> sd==0;
  endproperty
  RX_SD_ZER0_WHEN_RESET :assert property(SdZeroWhenReset)
   $info("RX_SD_ZER0_WHEN_RESET: ASSERTED");
   else
   $error("RX_SD_ZER0_WHEN_RESET:NOT ASSERTED");
 
 
  property wsNotUnknown();
      @(posedge sclk) disable iff (!rst)
          ($changed(ws) && !($isunknown(ws))) |=> ($stable(ws) until $changed(ws));
  endproperty
 
  RX_WS_NOT_UNKNOWN: assert property (wsNotUnknown)
  $info("RX_WS_NOT_UNKNOWN: ASSERTED");
  else
    $error("RX_WS_NOT_UNKNOWN : NOT ASSERTED");  

  property sdNotUnknown();
     @(posedge sclk) disable iff (!rst)
          $changed(ws)  |-> (!($isunknown(sd)) until $changed(ws));
  endproperty
 
  RX_SD_NOT_UNKNOWN: assert property (sdNotUnknown)
  $info("RX_SD_NOT_UNKNOWN: ASSERTED");
  else
    $error("RX_SD_NOT_UNKNOWN : NOT ASSERTED");

 
 
endinterface : I2sReceiverAssertions
 
`endif


