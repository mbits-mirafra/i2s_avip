`ifndef I2STRANSMITTERWRITE16BITTRANSFERWITHRXWSP48BITTXWSP32BITSEQ_INCLUDED_
`define I2STRANSMITTERWRITE16BITTRANSFERWITHRXWSP48BITTXWSP32BITSEQ_INCLUDED_

class I2sTransmitterWrite16bitTransferWithRxWSP48bitTxWSP32bitSeq extends I2sTransmitterBaseSeq;
  `uvm_object_utils(I2sTransmitterWrite16bitTransferWithRxWSP48bitTxWSP32bitSeq)

  rand bit txWsSeq;
  rand bit [DATA_WIDTH-1:0] txSdSeq[];
  rand numOfBitsTransferEnum txNumOfBitsTransferSeq;
  
  constraint txSdSeq_c{soft txSdSeq.size() == txNumOfBitsTransferSeq/DATA_WIDTH; }
  
  extern function new(string name = "I2sTransmitterWrite16bitTransferWithRxWSP48bitTxWSP32bitSeq");
  extern task body();
endclass : I2sTransmitterWrite16bitTransferWithRxWSP48bitTxWSP32bitSeq

function I2sTransmitterWrite16bitTransferWithRxWSP48bitTxWSP32bitSeq::new(string name = "I2sTransmitterWrite16bitTransferWithRxWSP48bitTxWSP32bitSeq");
  super.new(name);
endfunction : new

task I2sTransmitterWrite16bitTransferWithRxWSP48bitTxWSP32bitSeq::body();
  super.body();
  
  start_item(i2sTransmitterTransaction);
  if(!i2sTransmitterTransaction.randomize() with {
			    foreach(txSdSeq[i]){
                               txSd[i]  == txSdSeq[i]};
                            txNumOfBitsTransfer  == txNumOfBitsTransferSeq;
                             }) begin 
      `uvm_error(get_type_name(), "Randomization failed")
  end
  i2sTransmitterTransaction.print();
  finish_item(i2sTransmitterTransaction);

endtask:body
  
`endif



