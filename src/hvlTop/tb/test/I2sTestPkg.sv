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
 
 `include "I2sWriteOperationWith8bitdataTxMasterRxSlaveWith48khzTest.sv"
 `include "I2sWriteOperationWith16bitdataTxMasterRxSlaveWith8khzTest.sv"
 `include "I2sWriteOperationWith24bitdataTxMasterRxSlaveWith96khzTest.sv"
 `include "I2sWriteOperationWith32bitdataTxMasterRxSlaveWith192khzTest.sv"

 `include "I2sWriteOperationWith8bitdataRxMasterTxSlaveWith8khzTest.sv"
 `include "I2sWriteOperationWith16bitdataRxMasterTxSlaveWith48khzTest.sv"
 `include "I2sWriteOperationWith24bitdataRxMasterTxSlaveWith192khzTest.sv"
 `include "I2sWriteOperationWith32bitdataRxMasterTxSlaveWith96khzTest.sv"



 /*     
 //Test cases for  Padding data with zeroes
 `include "I2sWriteOperationWith8bitdataRxMasterTxSlaveWithRxWSP32bitTxWSP16bitTest.sv"
 `include "I2sWriteOperationWith8bitdataRxMasterTxSlaveWithRxWSP48bitTxWSP16bitTest.sv"
 `include "I2sWriteOperationWith8bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP16bitTest.sv" 
 `include "I2sWriteOperationWith16bitdataRxMasterTxSlaveWithRxWSP48bitTxWSP32bitTest.sv" 
 `include "I2sWriteOperationWith16bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP32bitTest.sv" 
 `include "I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP48bitTest.sv"

 //Test cases to Ignore data

 `include "I2sWriteOperationWith32bitdataRxMasterTxSlaveWithRxWSP32bitTxWSP64bitTest.sv"
 `include "I2sWriteOperationWith32bitdataRxMasterTxSlaveWithRxWSP48bitTxWSP64bitTest.sv"
 `include "I2sWriteOperationWith32bitdataRxMasterTxSlaveWithRxWSP16bitTxWSP64bitTest.sv" 
 `include "I2sWriteOperationWith16bitdataRxMasterTxSlaveWithRxWSP16bitTxWSP32bitTest.sv" 
 `include "I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP16bitTxWSP48bitTest.sv" 
 `include "I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP32bitTxWSP48bitTest.sv"*/

endpackage : I2sTestPkg

`endif
