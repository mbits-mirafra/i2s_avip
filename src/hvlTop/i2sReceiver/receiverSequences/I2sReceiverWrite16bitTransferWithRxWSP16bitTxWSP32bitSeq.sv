`ifndef I2SRECEIVERWRITE16BITTRANSFERWITHRXWSP16BITTXWSP32BITSEQ_INCLUDED_
`define I2SRECEIVERWRITE16BITTRANSFERWITHRXWSP16BITTXWSP32BITSEQ_INCLUDED_

class I2sReceiverWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq extends I2sReceiverBaseSeq;
  `uvm_object_utils(I2sReceiverWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq)

  rand bit rxWsSeq;
  bit[DATA_WIDTH-1:0] rxSdLeftChannelSeq[];
  bit[DATA_WIDTH-1:0] rxSdRightChannelSeq[];
  numOfBitsTransferEnum rxNumOfBitsTransferSeq;

  extern function new(string name = "I2sReceiverWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq");
  
  extern task body();
endclass : I2sReceiverWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq

function I2sReceiverWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq::new(string name = "I2sReceiverWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq");
  super.new(name);
endfunction : new

task I2sReceiverWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq::body();
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



