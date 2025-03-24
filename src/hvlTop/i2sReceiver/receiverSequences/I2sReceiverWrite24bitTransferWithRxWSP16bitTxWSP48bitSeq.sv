`ifndef I2SRECEIVERWRITE24BITTRANSFERWITHRXWSP16BITTXWSP48BITSEQ_INCLUDED_
`define I2SRECEIVERWRITE24BITTRANSFERWITHRXWSP16BITTXWSP48BITSEQ_INCLUDED_

class I2sReceiverWrite24bitTransferWithRxWSP16bitTxWSP48bitSeq extends I2sReceiverBaseSeq;
  `uvm_object_utils(I2sReceiverWrite24bitTransferWithRxWSP16bitTxWSP48bitSeq)

  rand bit rxWsSeq;
  numOfBitsTransferEnum rxNumOfBitsTransferSeq;
  
  extern function new(string name = "I2sReceiverWrite24bitTransferWithRxWSP16bitTxWSP48bitSeq");
  
  extern task body();
endclass : I2sReceiverWrite24bitTransferWithRxWSP16bitTxWSP48bitSeq

function I2sReceiverWrite24bitTransferWithRxWSP16bitTxWSP48bitSeq::new(string name = "I2sReceiverWrite24bitTransferWithRxWSP16bitTxWSP48bitSeq");
  super.new(name);
endfunction : new

task I2sReceiverWrite24bitTransferWithRxWSP16bitTxWSP48bitSeq::body();
  super.body();
  start_item(req);
  if(!req.randomize() with {rxWs == rxWsSeq;
                            rxNumOfBitsTransfer  == rxNumOfBitsTransferSeq;
                          }) begin 
      `uvm_error(get_type_name(), "Randomization failed")
  end
  req.print();
  finish_item(req);

endtask:body
  
`endif


