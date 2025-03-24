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


 
 `include "I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq.sv"
 `include "I2sVirtual8bitWriteOperationRxMasterTxSlaveSeq.sv"
 `include "I2sVirtual16bitWriteOperationTxMasterRxSlaveSeq.sv"
 `include "I2sVirtual16bitWriteOperationRxMasterTxSlaveSeq.sv"
 `include "I2sVirtual24bitWriteOperationRxMasterTxSlaveSeq.sv"  
 `include "I2sVirtual24bitWriteOperationTxMasterRxSlaveSeq.sv"  
 `include "I2sVirtual32bitWriteOperationRxMasterTxSlaveSeq.sv" 
 `include "I2sVirtual32bitWriteOperationTxMasterRxSlaveSeq.sv"  

 `include "I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP32bitTxWSP16bitSeq.sv"
 `include "I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP48bitTxWSP16bitSeq.sv"
 `include "I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP16bitSeq.sv"
 
 `include "I2sVirtual16bitWriteOperationRxMasterTxSlaveWithRxWSP48bitTxWSP32bitSeq.sv"
 `include "I2sVirtual16bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP32bitSeq.sv"
 `include "I2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP48bitSeq.sv"


 `include "I2sVirtual32bitWriteOperationRxMasterTxSlaveWithRxWSP16bitTxWSP64bitSeq.sv"
 `include "I2sVirtual32bitWriteOperationRxMasterTxSlaveWithRxWSP32bitTxWSP64bitSeq.sv"
 `include "I2sVirtual32bitWriteOperationRxMasterTxSlaveWithRxWSP48bitTxWSP64bitSeq.sv"
 `include "I2sVirtual16bitWriteOperationRxMasterTxSlaveWithRxWSP16bitTxWSP32bitSeq.sv"
 `include "I2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP16bitTxWSP48bitSeq.sv"
 `include "I2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP32bitTxWSP48bitSeq.sv"



 
endpackage : I2sVirtualSeqPkg

`endif
