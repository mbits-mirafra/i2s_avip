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
 `include "I2sWriteOperationWith24bitdataTxMasterRxSlaveWith24khzTest.sv"         
 `include "I2sWriteOperationWith32bitdataTxMasterRxSlaveWith192khzTest.sv"       

 `include "I2sWriteOperationWith8bitdataRxMasterTxSlaveWith8khzTest.sv"
 `include "I2sWriteOperationWith16bitdataRxMasterTxSlaveWith48khzTest.sv"    
 `include "I2sWriteOperationWith24bitdataRxMasterTxSlaveWith16khzTest.sv"   
 `include "I2sWriteOperationWith32bitdataRxMasterTxSlaveWith96khzTest.sv"      
      
 //Test cases for  Padding data with zeroes
 `include "I2sWriteOperationWith8bitdataRxMasterTxSlaveWithRxWSP32bitTxWSP16bitWith8khzTest.sv" 
 `include "I2sWriteOperationWith8bitdataRxMasterTxSlaveWithRxWSP48bitTxWSP16bitWith16khzTest.sv"    
 
 `include "I2sWriteOperationWith8bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP16bitWith96khzTest.sv"     
 `include "I2sWriteOperationWith16bitdataRxMasterTxSlaveWithRxWSP48bitTxWSP32bitWith192khzTest.sv"   
 `include "I2sWriteOperationWith16bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP32bitWith24khzTest.sv"      
 `include "I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP48bitWith48khzTest.sv"   

 //Test cases to Ignore data

 `include "I2sWriteOperationWith32bitdataRxMasterTxSlaveWithRxWSP32bitTxWSP64bitWith96khzTest.sv"       
 `include "I2sWriteOperationWith32bitdataRxMasterTxSlaveWithRxWSP48bitTxWSP64bitWith192khzTest.sv"
 `include "I2sWriteOperationWith32bitdataRxMasterTxSlaveWithRxWSP16bitTxWSP64bitWith32khzTest.sv"       
 `include "I2sWriteOperationWith16bitdataRxMasterTxSlaveWithRxWSP16bitTxWSP32bitWith48khzTest.sv"    
 `include "I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP16bitTxWSP48bitWith16khzTest.sv"   
 `include "I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP32bitTxWSP48bitWith192khzTest.sv"

 //Random Tests
  `include "I2sWriteOperationRandomTxMasterRxSlaveWithTxWSP32bitWith16khzTest.sv"
  `include "I2sWriteOperationRandomTxMasterRxSlaveWithTxWSP48bitWith96khzTest.sv"
  `include "I2sWriteOperationRandomTxMasterRxSlaveWithTxWSP64bitWith32khzTest.sv"

  `include "I2sWriteOperationRandomRxMasterTxSlaveWith32khzTest.sv"

 //Error Tests
  `include "I2sWriteOperationDataTransferErrorTest.sv"
  `include "I2sWriteOperationWithInvalidWSPErrorTest.sv"

        


endpackage : I2sTestPkg

`endif
