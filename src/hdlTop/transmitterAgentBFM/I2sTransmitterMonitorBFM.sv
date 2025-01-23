`ifndef I2STRANSMITTERMONITORBFM_INCLUDED_
`define I2STRANSMITTERMONITORBFM_INCLUDED_
 
import I2sGlobalsPackage::*;
 
interface I2sTransmitterMonitorBFM();

  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  import I2sTransmitterPkg::*;
  import I2sTransmitterPkg::I2sTransmitterMonitorProxy;
  I2sTransmitterMonitorProxy i2sTransmitterMonitorProxy;
 
  string name = "I2sTransmitterMonitorBFM";
  initial begin
    $display(name);
  end

 
endinterface : I2sTransmitterMonitorBFM
 
`endif
