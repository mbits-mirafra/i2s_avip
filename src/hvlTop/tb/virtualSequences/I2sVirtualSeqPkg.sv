`ifndef I2SVIRTUALSEQPKG_INCLUDED_
`define I2SVIRTUALSEQPKG_INCLUDED_

package I2sVirtualSeqPkg;

 `include "uvm_macros.svh"
 
  import uvm_pkg::*;
  import I2sTransmitterPkg::*;
  import I2sReceiverPkg::*;
  import I2sTransmitterSequencePkg::*;
  import I2sReceiverSequencePkg::*;
  import I2sEnvPkg::*;

 `include "I2sVirtualBaseSeq.sv"
 
endpackage : I2sVirtualSeqPkg

`endif
