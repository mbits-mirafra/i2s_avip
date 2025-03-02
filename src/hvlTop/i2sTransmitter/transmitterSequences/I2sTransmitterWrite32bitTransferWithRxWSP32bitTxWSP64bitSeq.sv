`ifndef I2STRANSMITTERWRITE32BITTRANSFERWITHRXWSP32BITTXWSP64BITSEQ_INCLUDED_
`define I2STRANSMITTERWRITE32BITTRANSFERWITHRXWSP32BITTXWSP64BITSEQ_INCLUDED_

class I2sTransmitterWrite32bitTransferWithRxWSP32bitTxWSP64bitSeq extends I2sTransmitterBaseSeq;
  `uvm_object_utils(I2sTransmitterWrite32bitTransferWithRxWSP32bitTxWSP64bitSeq)

 rand bit txWsSeq;
  rand bit txSclkSeq;
  randc bit[DATA_WIDTH-1:0] txSdSeq[];
  rand numOfBitsTransferEnum txNumOfBitsTransferSeq;
  rand wordSelectPeriodEnum txWordSelectPeriodSeq;
  //rand modeTypeEnum modeSeq;
  rand clockrateFrequencyEnum clockrateFrequencySeq;

  I2sTransmitterTransaction i2sTransmitterTransaction;

  constraint txSdSeq_c{soft txSdSeq.size() == txNumOfBitsTransferSeq/DATA_WIDTH; }
  constraint txNumOfBitsTransferSeq_c{soft txNumOfBitsTransferSeq <= txWordSelectPeriodSeq/2;}

  extern function new(string name = "I2sTransmitterWrite32bitTransferWithRxWSP32bitTxWSP64bitSeq");
  extern task body();
endclass : I2sTransmitterWrite32bitTransferWithRxWSP32bitTxWSP64bitSeq

function I2sTransmitterWrite32bitTransferWithRxWSP32bitTxWSP64bitSeq::new(string name = "I2sTransmitterWrite32bitTransferWithRxWSP32bitTxWSP64bitSeq");
  super.new(name);
endfunction : new

task I2sTransmitterWrite32bitTransferWithRxWSP32bitTxWSP64bitSeq::body();
  super.body();
  i2sTransmitterTransaction=I2sTransmitterTransaction::type_id::create("i2sTransmitterTransaction");

  start_item(i2sTransmitterTransaction);
  if(!i2sTransmitterTransaction.randomize() with {
                          // txWs == txWsSeq;
                           // txSclk == txSclkSeq;
                            foreach(txSdSeq[i]){
                               txSd[i]  == txSdSeq[i]};
                            txNumOfBitsTransfer  == txNumOfBitsTransferSeq;
                            txWordSelectPeriod == txWordSelectPeriodSeq;
                            //clockrateFrequency ==clockrateFrequencySeq;
                          }) begin 
      `uvm_error(get_type_name(), "Randomization failed")
  end
  i2sTransmitterTransaction.print();
  finish_item(i2sTransmitterTransaction);

endtask:body
  
`endif



