`ifndef I2SRECEIVERDRIVERBFM_INCLUDED_
`define I2SRECEIVERDRIVERBFM_INCLUDED_
 
import I2sGlobalsPackage::*;
 
interface I2sReceiverDriverBFM();
 
  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  import I2sReceiverPkg::I2sReceiverDriverProxy;
 
  I2sReceiverDriverProxy i2sReceiverDriverProxy;
  string name = "I2sReceiverDriverBFM";
  initial begin
    $display(name);
  end
 
 
    
endinterface : I2sReceiverDriverBFM
`endif
