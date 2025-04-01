`ifndef I2SRECEIVERWRITE8BITTRANSFERWITHRXWSP64BITTXWSP16BITSEQ_INCLUDED_
`define I2SRECEIVERWRITE8BITTRANSFERWITHRXWSP64BITTXWSP16BITSEQ_INCLUDED_

class I2sReceiverWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq extends I2sReceiverBaseSeq;
  `uvm_object_utils(I2sReceiverWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq)

  rand bit rxWsSeq;
  bit[DATA_WIDTH-1:0] rxSdLeftChannelSeq[];
  bit[DATA_WIDTH-1:0] rxSdRightChannelSeq[];
  numOfBitsTransferEnum rxNumOfBitsTransferSeq;
  
  extern function new(string name = "I2sReceiverWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq");
  
  extern task body();
endclass : I2sReceiverWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq

function I2sReceiverWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq::new(string name = "I2sReceiverWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq");
  super.new(name);
endfunction : new

task I2sReceiverWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq::body();
  super.body();
  start_item(req);
  if(!req.randomize() with {rxWs == rxWsSeq;
                           
                          }) begin 
      `uvm_error(get_type_name(), "Randomization failed")
  end
  req.print();
  finish_item(req);

endtask:body
  
`endif


