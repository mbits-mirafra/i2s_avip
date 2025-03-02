`ifndef I2SRECEIVERSEQUENCEPKG_INCLUDED_
`define I2SRECEIVERSEQUENCEPKG_INCLUDED_

package I2sReceiverSequencePkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import I2sGlobalPkg::*;
  
  import I2sReceiverPkg::*;
  
  `include "I2sReceiverBaseSeq.sv"
  `include  "I2sReceiverWrite8bitTransferSeq.sv"
  `include  "I2sReceiverWrite16bitTransferSeq.sv"
  `include  "I2sReceiverWrite24bitTransferSeq.sv"
  `include  "I2sReceiverWrite32bitTransferSeq.sv"

  `include "I2sReceiverWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq.sv"
  `include "I2sReceiverWrite8bitTransferWithRxWSP48bitTxWSP16bitSeq.sv"
  `include "I2sReceiverWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq.sv"


  `include "I2sReceiverWrite16bitTransferWithRxWSP48bitTxWSP32bitSeq.sv"
  `include "I2sReceiverWrite16bitTransferWithRxWSP64bitTxWSP32bitSeq.sv"

  `include "I2sReceiverWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq.sv"

  `include "I2sReceiverWrite32bitTransferWithRxWSP32bitTxWSP64bitSeq.sv"
  `include "I2sReceiverWrite32bitTransferWithRxWSP48bitTxWSP64bitSeq.sv"
  `include "I2sReceiverWrite32bitTransferWithRxWSP16bitTxWSP64bitSeq.sv"


  `include "I2sReceiverWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq.sv"
  `include "I2sReceiverWrite24bitTransferWithRxWSP16bitTxWSP48bitSeq.sv"
  `include "I2sReceiverWrite24bitTransferWithRxWSP32bitTxWSP48bitSeq.sv"





  endpackage : I2sReceiverSequencePkg
`endif

