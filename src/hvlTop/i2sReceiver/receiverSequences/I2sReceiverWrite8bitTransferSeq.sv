`ifndef I2SRECEIVERWRITE8BITTRANSFERSEQ_INCLUDED_
`define I2SRECEIVERWRITE8BITTRANSFERSEQ_INCLUDED_

class I2sReceiverWrite8bitTransferSeq extends I2sReceiverBaseSeq;
  `uvm_object_utils(I2sReceiverWrite8bitTransferSeq)

  rand bit rxWsSeq;
  rand bit rxSclkSeq;
  rand bit[DATA_WIDTH-1:0] rxSdSeq[];
  rand numOfBitsTransferEnum rxNumOfBitsTransferSeq;
  rand wordSelectPeriodEnum rxWordSelectPeriodSeq;
  rand clockrateFrequencyEnum clockrateFrequencySeq;

 
  constraint rxNumOfBitsTransferSeq_c {soft rxNumOfBitsTransferSeq <= rxWordSelectPeriodSeq/2;}

  extern function new(string name = "I2sReceiverWrite8bitTransferSeq");
  
  extern task body();
endclass : I2sReceiverWrite8bitTransferSeq

function I2sReceiverWrite8bitTransferSeq::new(string name = "I2sReceiverWrite8bitTransferSeq");
  super.new(name);
endfunction : new

task I2sReceiverWrite8bitTransferSeq::body();
  super.body();
  start_item(req);
  if(!req.randomize() with {rxWs == rxWsSeq;
                            rxSclk == rxSclkSeq;
                            clockrateFrequency==clockrateFrequencySeq;
                            rxNumOfBitsTransfer  == rxNumOfBitsTransferSeq;
                            rxWordSelectPeriod == rxWordSelectPeriodSeq;
                        
                          }) begin 
      `uvm_error(get_type_name(), "Randomization failed")
  end
  req.print();
  finish_item(req);

endtask:body
  
`endif

