`ifndef I2SVIRTUAL8BITSWRITEOPERATIONRXMASTERTXSLAVEWITHRXWSP64BITXWSP16BITSEQ_INCLUDED_
`define I2SVIRTUAL8BITSWRITEOPERATIONRXMASTERTXSLAVEWITHRXWSP64BITXWSP16BITSEQ_INCLUDED_

class I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP16bitSeq extends I2sVirtualBaseSeq;
  `uvm_object_utils(I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP16bitSeq)

  I2sReceiverWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq i2sReceiverWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq;
  I2sTransmitterWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq i2sTransmitterWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq;  

  extern function new(string name = "I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP16bitSeq");
  extern task body();
endclass : I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP16bitSeq

function I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP16bitSeq::new(string name = "I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP16bitSeq");
  super.new(name);
endfunction : new

task I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP16bitSeq::body();
  i2sReceiverWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq = I2sReceiverWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq::type_id::create("i2sReceiverWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq");
  i2sTransmitterWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq = I2sTransmitterWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq::type_id::create("i2sTransmitterWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq");

  `uvm_info(get_type_name(), $sformatf("Inside task Body Seq Start: I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP16bitSeq"), UVM_NONE);



   if(!i2sReceiverWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq.randomize() with {rxSclkSeq==1; rxWsSeq==1;
							                         rxWordSelectPeriodSeq==64;
										 clockrateFrequencySeq==48000;
							                          //rxNumOfBitsTransferSeq==32;
      }) begin
       `uvm_error(get_type_name(), "Randomization failed : Inside I2sReceiverWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq")
  end

 if (!i2sTransmitterWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq.randomize() with {
                                                           txNumOfBitsTransferSeq==8;
							   txWordSelectPeriodSeq==16;

                                                             }) begin
    `uvm_error(get_type_name(), "Randomization failed: Inside I2sTransmitterWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq")
  end

  fork
    begin
  `uvm_info(get_type_name(), "Starting Receiver Sequence", UVM_LOW);
      i2sReceiverWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq.start(p_sequencer.i2sReceiverSequencer);
  end
    begin
        `uvm_info(get_type_name(), "Starting Transmitter Sequence", UVM_LOW);
      i2sTransmitterWrite8bitTransferWithRxWSP64bitTxWSP16bitSeq.start(p_sequencer.i2sTransmitterSequencer);
  end
  join

  `uvm_info(get_type_name(), "Fork_join Completed",UVM_NONE);
endtask : body

`endif



