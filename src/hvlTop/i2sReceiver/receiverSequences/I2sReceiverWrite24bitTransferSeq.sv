`ifndef I2SRECEIVERWRITE24BITTRANSFERSEQ_INCLUDED_
`define I2SRECEIVERWRITE24BITTRANSFERSEQ_INCLUDED_

class I2sReceiverWrite24bitTransferSeq extends I2sReceiverBaseSeq;
  `uvm_object_utils(I2sReceiverWrite24bitTransferSeq)

  rand bit rxWsSeq;
  bit[DATA_WIDTH-1:0] rxSdSeq[];
  numOfBitsTransferEnum rxNumOfBitsTransferSeq;
  
  extern function new(string name = "I2sReceiverWrite24bitTransferSeq");
  
  extern task body();
endclass : I2sReceiverWrite24bitTransferSeq

function I2sReceiverWrite24bitTransferSeq::new(string name = "I2sReceiverWrite24bitTransferSeq");
  super.new(name);
endfunction : new

task I2sReceiverWrite24bitTransferSeq::body();
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


