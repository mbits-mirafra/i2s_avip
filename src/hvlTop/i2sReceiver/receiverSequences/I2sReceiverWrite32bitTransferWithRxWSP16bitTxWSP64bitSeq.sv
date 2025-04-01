`ifndef I2SRECEIVERWRITE8BITTRANSFERWITHRXWSP16BITTXWSP16BITSEQ_INCLUDED_
`define I2SRECEIVERWRITE8BITTRANSFERWITHRXWSP16BITTXWSP16BITSEQ_INCLUDED_

class I2sReceiverWrite32bitTransferWithRxWSP16bitTxWSP64bitSeq extends I2sReceiverBaseSeq;
  `uvm_object_utils(I2sReceiverWrite32bitTransferWithRxWSP16bitTxWSP64bitSeq)

  rand bit rxWsSeq;
  bit[DATA_WIDTH-1:0] rxSdLeftChannelSeq[];
  bit[DATA_WIDTH-1:0] rxSdRightChannelSeq[];
  numOfBitsTransferEnum rxNumOfBitsTransferSeq;

  extern function new(string name = "I2sReceiverWrite32bitTransferWithRxWSP16bitTxWSP64bitSeq");
  
  extern task body();
endclass : I2sReceiverWrite32bitTransferWithRxWSP16bitTxWSP64bitSeq

function I2sReceiverWrite32bitTransferWithRxWSP16bitTxWSP64bitSeq::new(string name = "I2sReceiverWrite32bitTransferWithRxWSP16bitTxWSP64bitSeq");
  super.new(name);
endfunction : new

task I2sReceiverWrite32bitTransferWithRxWSP16bitTxWSP64bitSeq::body();
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


