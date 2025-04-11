`ifndef I2SVIRTUALRANDOMWRITEOPERATIONRXMASTERTXSLAVESEQ_INCLUDED_
`define I2SVIRTUALRANDOMWRITEOPERATIONRXMASTERTXSLAVESEQ_INCLUDED_

class I2sVirtualRandomWriteOperationRxMasterTxSlaveSeq extends I2sVirtualBaseSeq;
  `uvm_object_utils(I2sVirtualRandomWriteOperationRxMasterTxSlaveSeq)

  I2sReceiverWriteRandomTransferSeq i2sReceiverWriteRandomTransferSeq;
  I2sTransmitterWriteRandomTransferSeq i2sTransmitterWriteRandomTransferSeq;

  extern function new(string name = "I2sVirtualRandomWriteOperationRxMasterTxSlaveSeq");
  extern task body();
endclass : I2sVirtualRandomWriteOperationRxMasterTxSlaveSeq

function I2sVirtualRandomWriteOperationRxMasterTxSlaveSeq::new(string name = "I2sVirtualRandomWriteOperationRxMasterTxSlaveSeq");
  super.new(name);
endfunction : new

task I2sVirtualRandomWriteOperationRxMasterTxSlaveSeq::body();

repeat(5) begin
  i2sReceiverWriteRandomTransferSeq = I2sReceiverWriteRandomTransferSeq::type_id::create("i2sReceiverWriteRandomTransferSeq");
  i2sTransmitterWriteRandomTransferSeq = I2sTransmitterWriteRandomTransferSeq::type_id::create("i2sTransmitterWriteRandomTransferSeq");

  `uvm_info(get_type_name(), $sformatf("Inside Body Seq Start: I2sVirtualRandomWriteOperationRxMasterTxSlaveSeq"), UVM_NONE);




if(!i2sReceiverWriteRandomTransferSeq.randomize()) begin
       `uvm_error(get_type_name(), "Randomization failed : Inside I2sReceiverWriteRandomTransferSeq")
  end

 

 if (!i2sTransmitterWriteRandomTransferSeq.randomize() with {txNumOfBitsTransferSeq <= (p_sequencer.i2sTransmitterSequencer.i2sTransmitterAgentConfig.wordSelectPeriod/2);                                                                            }) begin
    `uvm_error(get_type_name(), "Randomization failed: Inside I2sTransmitterWriteRandomTransferSeq")
  end

  fork

    begin
  `uvm_info(get_type_name(), "Starting Receiver Sequence", UVM_LOW);
      i2sReceiverWriteRandomTransferSeq.start(p_sequencer.i2sReceiverSequencer);
  end
    begin
        `uvm_info(get_type_name(), "Starting Transmitter Sequence", UVM_LOW);
      i2sTransmitterWriteRandomTransferSeq.start(p_sequencer.i2sTransmitterSequencer);
  end
  join

  `uvm_info(get_type_name(), "Fork_join Completed",UVM_NONE);
  end
endtask : body

`endif


