`ifndef I2SRECEIVERPKG_INCLUDED_
`define I2SRECEIVERPKG_INCLUDED_

package I2sReceiverPkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;
 
  import I2sGlobalsPackage::*;

  `include "I2sReceiverAgentConfig.sv"
  `include "I2sReceiverTransaction.sv"
  `include "I2sReceiverSeqItemConverter.sv"
  `include "I2sReceiverConfigConverter.sv"
  `include "I2sReceiverSequencer.sv"
  `include "I2sReceiverDriverProxy.sv"
  `include "I2sReceiverMonitorProxy.sv"
  `include "I2sReceiverCoverage.sv"
  `include "I2sReceiverAgent.sv"
  
endpackage : I2sReceiverPkg
`endif
