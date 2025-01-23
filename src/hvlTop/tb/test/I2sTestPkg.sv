`ifndef I2STESTPKG_INCLUDED_
`define I2STESTPKG_INCLUDED_

package I2sTestPkg;

 `include "uvm_macros.svh"

  import uvm_pkg::*;
  import I2sGlobalsPackage::*;
  import I2sTransmitterPkg::*;
  import I2sReceiverPkg::*;
  import I2sEnvPkg::*;
  import I2sTransmitterSequencePkg::*;
  import I2sReceiverSequencePkg::*;
  import I2sVirtualSeqPkg::*;

 `include "I2sBaseTest.sv"

endpackage : I2sTestPkg

`endif
