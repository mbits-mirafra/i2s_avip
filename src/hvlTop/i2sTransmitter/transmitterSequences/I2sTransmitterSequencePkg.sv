`ifndef I2STRANSMITTERSEQUENCEPKG_INCLUDED
`define I2STRANSMITTERSEQUENCEPKG_INCLUDED

package I2sTransmitterSequencePkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import I2sGlobalPkg::*;  
  import I2sTransmitterPkg::*;
  
  `include "I2sTransmitterBaseSeq.sv"
  `include "I2sTransmitterSeq.sv"
  `include "I2sTransmitterWrite8bitTransferSeq.sv"

  endpackage : I2sTransmitterSequencePkg
`endif

