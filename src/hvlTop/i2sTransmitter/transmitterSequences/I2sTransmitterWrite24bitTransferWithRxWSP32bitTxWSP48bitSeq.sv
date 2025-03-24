`ifndef I2STRANSMITTERWRITE24BITTRANSFERWITHRXWSP32BITTXWSP48BITSEQ_INCLUDED_
`define I2STRANSMITTERWRITE24BITTRANSFERWITHRXWSP32BITTXWSP48BITSEQ_INCLUDED_

class I2sTransmitterWrite24bitTransferWithRxWSP32bitTxWSP48bitSeq extends I2sTransmitterBaseSeq;
  `uvm_object_utils(I2sTransmitterWrite24bitTransferWithRxWSP32bitTxWSP48bitSeq)

  rand bit txWsSeq;
  rand bit[DATA_WIDTH-1:0] txSdSeq[];
  rand numOfBitsTransferEnum txNumOfBitsTransferSeq;
  
  constraint txSdSeq_c{soft txSdSeq.size() == txNumOfBitsTransferSeq/DATA_WIDTH; }

  extern function new(string name = "I2sTransmitterWrite24bitTransferWithRxWSP32bitTxWSP48bitSeq");
  extern task body();
endclass : I2sTransmitterWrite24bitTransferWithRxWSP32bitTxWSP48bitSeq

function I2sTransmitterWrite24bitTransferWithRxWSP32bitTxWSP48bitSeq::new(string name = "I2sTransmitterWrite24bitTransferWithRxWSP32bitTxWSP48bitSeq");
  super.new(name);
endfunction : new

task I2sTransmitterWrite24bitTransferWithRxWSP32bitTxWSP48bitSeq::body();
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



