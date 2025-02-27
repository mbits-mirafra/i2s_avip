`ifndef I2SRECEIVERSEQUENCEPKG_INCLUDED_
`define I2SRECEIVERSEQUENCEPKG_INCLUDED_

package I2sReceiverSequencePkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import I2sGlobalPkg::*;
  
  import I2sReceiverPkg::*;
  
  `include "I2sReceiverBaseSeq.sv"
  `include  "I2sReceiverWrite8bitTransferSeq.sv"
  endpackage : I2sReceiverSequencePkg
`endif

