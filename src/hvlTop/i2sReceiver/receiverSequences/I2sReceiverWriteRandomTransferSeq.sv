`ifndef I2SRECEIVERWRITERANDOMTRANSFERSEQ_INCLUDED_
`define I2SRECEIVERWRITERANDOMTRANSFERSEQ_INCLUDED_

class I2sReceiverWriteRandomTransferSeq extends I2sReceiverBaseSeq;
  `uvm_object_utils(I2sReceiverWriteRandomTransferSeq)

  rand bit rxWsSeq;
  bit[DATA_WIDTH-1:0] rxSdLeftChannelSeq[];
  bit[DATA_WIDTH-1:0] rxSdRightChannelSeq[];
  numOfBitsTransferEnum rxNumOfBitsTransferSeq;
   
  extern function new(string name = "I2sReceiverWriteRandomTransferSeq");
  
  extern task body();
endclass : I2sReceiverWriteRandomTransferSeq

function I2sReceiverWriteRandomTransferSeq::new(string name = "I2sReceiverWriteRandomTransferSeq");
  super.new(name);
endfunction : new

task I2sReceiverWriteRandomTransferSeq::body();
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


