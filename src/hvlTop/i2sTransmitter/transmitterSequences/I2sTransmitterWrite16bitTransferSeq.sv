`ifndef I2STRANSMITTERWRITE16BITTRANSFERSEQ_INCLUDED_
`define I2STRANSMITTERWRITE16BITTRANSFERSEQ_INCLUDED_

class I2sTransmitterWrite16bitTransferSeq extends I2sTransmitterBaseSeq;
  `uvm_object_utils(I2sTransmitterWrite16bitTransferSeq)

  randc bit txWsSeq;
  rand bit txSclkSeq;
  randc bit[DATA_WIDTH-1:0] txSdSeq[];
  rand numOfBitsTransferEnum txNumOfBitsTransferSeq;
  rand wordSelectPeriodEnum txWordSelectPeriodSeq;
  rand clockrateFrequencyEnum clockrateFrequencySeq;

  constraint txSdSeq_c{soft txSdSeq.size() == txNumOfBitsTransferSeq/DATA_WIDTH; }
  constraint txNumOfBitsTransferSeq_c{txNumOfBitsTransferSeq == txWordSelectPeriodSeq/2;}

  extern function new(string name = "I2sTransmitterWrite16bitTransferSeq");
  extern task body();
endclass : I2sTransmitterWrite16bitTransferSeq

function I2sTransmitterWrite16bitTransferSeq::new(string name = "I2sTransmitterWrite16bitTransferSeq");
  super.new(name);
endfunction : new

task I2sTransmitterWrite16bitTransferSeq::body();
  super.body();

  start_item(i2sTransmitterTransaction);
  if(!i2sTransmitterTransaction.randomize() with {
                           txWs == txWsSeq;
                            txSclk == txSclkSeq;
                            foreach(txSdSeq[i]){
                               txSd[i]  == txSdSeq[i]};
                            txNumOfBitsTransfer  == txNumOfBitsTransferSeq;
                            txWordSelectPeriod == txWordSelectPeriodSeq;
                            clockrateFrequency ==clockrateFrequencySeq;
                          }) begin 
      `uvm_error(get_type_name(), "Randomization failed")
 end
  
  foreach(i2sTransmitterTransaction.txSd[i]) begin
  $display("sd=%b",i2sTransmitterTransaction.txSd[i]);
   end

  i2sTransmitterTransaction.print();
  finish_item(i2sTransmitterTransaction);

endtask:body
  
`endif

