`ifndef I2STRANSMITTERSEQUENCEPKG_INCLUDED
`define I2STRANSMITTERSEQUENCEPKG_INCLUDED

package I2sTransmitterSequencePkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import I2sGlobalPkg::*;  
  import I2sTransmitterPkg::*;
  
  `include "I2sTransmitterBaseSeq.sv"


  
  `include "I2sTransmitterWrite8bitTransferSeq.sv"
  `include "I2sTransmitterWrite16bitTransferSeq.sv"
  `include "I2sTransmitterWrite24bitTransferSeq.sv"  
  `include "I2sTransmitterWrite32bitTransferSeq.sv"  

  `include "I2sTransmitterWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq.sv"
  `include "I2sTransmitterWrite8bitTransferWithRxWSP48bitTxWSP16bitSeq.sv"
  `include "I2sTransmitterWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq.sv"  

  `include "I2sTransmitterWrite16bitTransferWithRxWSP48bitTxWSP32bitSeq.sv"
  `include "I2sTransmitterWrite16bitTransferWithRxWSP64bitTxWSP32bitSeq.sv"  
  `include "I2sTransmitterWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq.sv" 

 `include "I2sTransmitterWrite32bitTransferWithRxWSP32bitTxWSP64bitSeq.sv"
 `include "I2sTransmitterWrite32bitTransferWithRxWSP48bitTxWSP64bitSeq.sv"
 `include "I2sTransmitterWrite32bitTransferWithRxWSP16bitTxWSP64bitSeq.sv"

 `include "I2sTransmitterWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq.sv"
 `include "I2sTransmitterWrite24bitTransferWithRxWSP16bitTxWSP48bitSeq.sv"
 `include "I2sTransmitterWrite24bitTransferWithRxWSP32bitTxWSP48bitSeq.sv"  


  endpackage : I2sTransmitterSequencePkg
`endif

