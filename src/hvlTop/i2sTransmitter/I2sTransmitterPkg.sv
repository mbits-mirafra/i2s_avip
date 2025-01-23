`ifndef I2STRANSMITTERPKG_INCLUDED_
`define I2STRANSMITTERPKG_INCLUDED_

package I2sTransmitterPkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;
 
  import I2sGlobalsPackage::*;

  `include "I2sTransmitterAgentConfig.sv"
  `include "I2sTransmitterTransaction.sv"
  `include "I2sTransmitterSeqItemConverter.sv"
  `include "I2sTransmitterConfigConverter.sv"
  `include "I2sTransmitterSequencer.sv"
  `include "I2sTransmitterDriverProxy.sv"
  `include "I2sTransmitterMonitorProxy.sv"
  `include "I2sTransmitterCoverage.sv"
  `include "I2sTransmitterAgent.sv"
  
endpackage : I2sTransmitterPkg

`endif
