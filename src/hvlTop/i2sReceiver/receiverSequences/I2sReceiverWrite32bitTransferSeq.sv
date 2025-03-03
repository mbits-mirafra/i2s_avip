`ifndef I2SRECEIVERWRITE32BITTRANSFERSEQ_INCLUDED_
`define I2SRECEIVERWRITE32BITTRANSFERSEQ_INCLUDED_

class I2sReceiverWrite32bitTransferSeq extends I2sReceiverBaseSeq;
  `uvm_object_utils(I2sReceiverWrite32bitTransferSeq)

   rand bit rxWsSeq;
  rand bit rxSclkSeq;
  rand bit[DATA_WIDTH-1:0] rxSdSeq[];
  rand numOfBitsTransferEnum rxNumOfBitsTransferSeq;
  rand wordSelectPeriodEnum rxWordSelectPeriodSeq;
  rand clockrateFrequencyEnum clockrateFrequencySeq;

 
  constraint rxNumOfBitsTransferSeq_c {rxNumOfBitsTransferSeq == rxWordSelectPeriodSeq/2;}

  extern function new(string name = "I2sReceiverWrite32bitTransferSeq");
  
  extern task body();
endclass : I2sReceiverWrite32bitTransferSeq

function I2sReceiverWrite32bitTransferSeq::new(string name = "I2sReceiverWrite32bitTransferSeq");
  super.new(name);
endfunction : new

task I2sReceiverWrite32bitTransferSeq::body();
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

