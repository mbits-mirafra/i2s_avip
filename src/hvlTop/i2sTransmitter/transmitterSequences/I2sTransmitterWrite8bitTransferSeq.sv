`ifndef I2STRANSMITTERWRITE8BITTRANSFERSEQ_INCLUDED_
`define I2STRANSMITTERWRITE8BITTRANSFERSEQ_INCLUDED_

class I2sTransmitterWrite8bitTransferSeq extends I2STransmitterWriteBaseSeq;
  `uvm_object_utils(I2sTransmitterWrite8bitTransferSeq)

  rand bit txWsSeq;
  rand bit txSclkSeq;
  rand bit[DATA_WIDTH-1:0] txSdSeq[];
  rand numOfBitsTransferEnum txNumOfBitsTransferSeq;
  rand wordSelectPeriodEnum txWordSelectPeriodSeq;
  rand modeTypeEnum modeSeq;

  constraint txSdSeq_c{txSdSeq.size() == DATA_WIDTH/txNumOfBitsTransferSeq; }

  extern function new(string name = "I2sTransmitterWrite8bitTransferSeq");
  extern task body();
endclass : I2sTransmitterWrite8bitTransferSeq

function I2sTransmitterWrite8bitTransferSeq::new(string name = "I2sTransmitterWrite8bitTransferSeq");
  super.new(name);
endfunction : new

task I2sTransmitterWrite8bitTransferSeq::body();
  super.body();
  start_item(req);
  if(!req.randomize() with {txWs == txWsSeq;
                            txSclk == txSclkSeq;
                            txSd  == txSdSeq;
                            txNumOfBitsTransfer  == txNumOfBitsTransferSeq;
                            txWordSelectPeriod == txWordSelectPeriodSeq;
                            mode == modeSeq;
                          }) begin 
      `uvm_error(get_type_name(), "Randomization failed")
  end
  req.print();
  finish_item(req);

endtask:body
  
`endif

