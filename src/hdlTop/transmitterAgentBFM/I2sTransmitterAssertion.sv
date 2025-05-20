`ifndef I2STRANSMITTERASSERTIONS_INCLUDED_
`define I2STRANSMITTERASSERTIONS_INCLUDED_

import I2sGlobalPkg::*;

interface I2sTransmitterAssertions (input  clk,
                                    input  rst,
				    input sclk,
				    input ws,
			            input sd);
 
   import uvm_pkg::*;
  `include "uvm_macros.svh";
 
   import I2sTransmitterPkg::I2sTransmitterAgentConfig;

   I2sTransmitterAgentConfig i2sTransmitterAgentConfig;

  initial begin
    `uvm_info("I2sTransmitterAssertions","I2sTransmitterAssertions",UVM_LOW);
  end

  property SdZeroWhenReset();
   @(posedge clk) 
      (rst==0) |-> sd==0;
  endproperty
 
 TX_SD_ZER0_WHEN_RESET :assert property(SdZeroWhenReset)
   $info("TX_SD_ZER0_WHEN_RESET: ASSERTED");
   else
   $error("TX_SD_ZER0_WHEN_RESET:NOT ASSERTED");
 
  property wsNotUnknown();
      @(posedge sclk) disable iff (!rst)
     	 ($changed(ws) && !($isunknown(ws))) |=> ($stable(ws) until $changed(ws));
   endproperty
 
 TX_WS_NOT_UNKNOWN: assert property (wsNotUnknown)
  $info("TX_WS_NOT_UNKNOWN : ASSERTED");
  else
    $error("TX_WS_NOT_UNKNOWN : NOT ASSERTED");   

  property sdNotUnknown();
     @(posedge sclk) disable iff (!rst)
        $changed(ws)  |-> (!($isunknown(sd)) until $changed(ws));

  endproperty
 
  TX_SD_NOT_UNKNOWN: assert property (sdNotUnknown)
  $info("TX_SD_NOT_UNKNOWN: ASSERTED");
  else
    $error("TX_SD_NOT_UNKNOWN : NOT ASSERTED");
 
 
endinterface : I2sTransmitterAssertions
 
`endif

