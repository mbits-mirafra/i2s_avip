`ifndef I2SRECEIVERWRITE16BITTRANSFERSEQ_INCLUDED_
`define I2SRECEIVERWRITE16BITTRANSFERSEQ_INCLUDED_

class I2sReceiverWrite16bitTransferSeq extends I2sReceiverBaseSeq;
  `uvm_object_utils(I2sReceiverWrite16bitTransferSeq)

  rand bit rxWsSeq;
  bit[DATA_WIDTH-1:0] rxSdLeftChannelSeq[];
  bit[DATA_WIDTH-1:0] rxSdRightChannelSeq[];  
  numOfBitsTransferEnum rxNumOfBitsTransferSeq;
 
  extern function new(string name = "I2sReceiverWrite16bitTransferSeq");
  
  extern task body();
endclass : I2sReceiverWrite16bitTransferSeq

function I2sReceiverWrite16bitTransferSeq::new(string name = "I2sReceiverWrite16bitTransferSeq");
  super.new(name);
endfunction : new

task I2sReceiverWrite16bitTransferSeq::body();
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

