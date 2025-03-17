`ifndef I2SVIRTUAL8BITSWRITEOPERATIONRXMASTERTXSLAVESEQ_INCLUDED_
`define I2SVIRTUAL8BITSWRITEOPERATIONRXMASTERTXSLAVESEQ_INCLUDED_

class I2sVirtual8bitWriteOperationRxMasterTxSlaveSeq extends I2sVirtualBaseSeq;
  `uvm_object_utils(I2sVirtual8bitWriteOperationRxMasterTxSlaveSeq)

  I2sReceiverWrite8bitTransferSeq i2sReceiverWrite8bitTransferSeq;
  I2sTransmitterWrite8bitTransferSeq i2sTransmitterWrite8bitTransferSeq;

  extern function new(string name = "I2sVirtual8bitWriteOperationRxMasterTxSlaveSeq");
  extern task body();
endclass : I2sVirtual8bitWriteOperationRxMasterTxSlaveSeq

function I2sVirtual8bitWriteOperationRxMasterTxSlaveSeq::new(string name = "I2sVirtual8bitWriteOperationRxMasterTxSlaveSeq");
  super.new(name);
endfunction : new

task I2sVirtual8bitWriteOperationRxMasterTxSlaveSeq::body();

repeat(2) 
 begin

  i2sReceiverWrite8bitTransferSeq = I2sReceiverWrite8bitTransferSeq::type_id::create("i2sReceiverWrite8bitTransferSeq");
  i2sTransmitterWrite8bitTransferSeq = I2sTransmitterWrite8bitTransferSeq::type_id::create("i2sTransmitterWrite8bitTransferSeq");

  `uvm_info(get_type_name(), $sformatf("Inside Body Seq Start: I2sVirtual8bitWriteOperationRxMasterTxSlaveSeq"), UVM_NONE);



if(!i2sReceiverWrite8bitTransferSeq.randomize() with {rxWsSeq==1;
                                                      rxWordSelectPeriodSeq==16;
                                                     }) begin
       `uvm_error(get_type_name(), "Randomization failed : Inside I2sReceiverWrite8bitTransferSeq")
  end

 

 if (!i2sTransmitterWrite8bitTransferSeq.randomize() with {txWordSelectPeriodSeq==16;
                                                             }) begin
    `uvm_error(get_type_name(), "Randomization failed: Inside I2sTransmitterWrite8bitTransferSeq")
  end

  
//end

 
  fork
    begin
  `uvm_info(get_type_name(), "Starting Receiver Sequence", UVM_LOW);
     
      i2sReceiverWrite8bitTransferSeq.start(p_sequencer.i2sReceiverSequencer);
  end
    begin
        `uvm_info(get_type_name(), "Starting Transmitter Sequence", UVM_LOW);
      i2sTransmitterWrite8bitTransferSeq.start(p_sequencer.i2sTransmitterSequencer);
  end
  join

  `uvm_info(get_type_name(), "Fork_join Completed",UVM_NONE);
end

endtask : body

`endif

