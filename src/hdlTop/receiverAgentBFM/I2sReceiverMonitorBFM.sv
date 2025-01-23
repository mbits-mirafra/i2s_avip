`ifndef I2SRECEIVERMONITORBFM_INCLUDED_
`define I2SRECEIVERMONITORBFM_INCLUDED_
 
import I2sGlobalsPackage::*;
 
interface I2sReceiverMonitorBFM();

  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  import I2sReceiverPkg::*;
  import I2sReceiverPkg::I2sReceiverMonitorProxy;
  I2sReceiverMonitorProxy i2sReceiverMonitorPorxy;
 
  string name = "I2sReceiverMonitorBFM";
  initial begin
    $display(name);
  end

 
endinterface : I2sReceiverMonitorBFM
 
`endif
