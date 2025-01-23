`ifndef I2STRANSMITTERDRIVERBFM_INCLUDED_
`define I2STRANSMITTERDRIVERBFM_INCLUDED_
 
import I2sGlobalsPackage::*;
 
interface I2sTransmitterDriverBFM();
 
  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  import I2sTransmitterPkg::I2sTransmitterDriverProxy;
 
  I2sTransmitterDriverProxy i2sTransmitterDriverProxy;
  string name = "I2sTransmitterDriverBFM";
  initial begin
    $display(name);
  end
 
    
endinterface : I2sTransmitterDriverBFM
`endif
