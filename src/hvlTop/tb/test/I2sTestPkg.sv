`ifndef I2STESTPKG_INCLUDED_
`define I2STESTPKG_INCLUDED_

package I2sTestPkg;

 `include "uvm_macros.svh"

  import uvm_pkg::*;
  import I2sGlobalPkg::*;
  import I2sTransmitterPkg::*;
  import I2sReceiverPkg::*;
  import I2sEnvPkg::*;
  import I2sTransmitterSequencePkg::*;
  import I2sReceiverSequencePkg::*;
  import I2sVirtualSeqPkg::*;

 `include "I2sBaseTest.sv"
 `include "I2sTest.sv"
 `include "I2sWriteOperationWith8bitdataTxMasterRxSlaveTest.sv"
 `include "I2sWriteOperationWith8bitdataRxMasterTxSlaveTest.sv"

endpackage : I2sTestPkg

`endif
