`ifndef I2SVIRTUAL24BITSWRITEOPERATIONRXMASTERTXSLAVESEQ_INCLUDED_
`define I2SVIRTUAL24BITSWRITEOPERATIONRXMASTERTXSLAVESEQ_INCLUDED_

class I2sVirtual24bitWriteOperationRxMasterTxSlaveSeq extends I2sVirtualBaseSeq;
  `uvm_object_utils(I2sVirtual24bitWriteOperationRxMasterTxSlaveSeq)

  I2sReceiverWrite24bitTransferSeq i2sReceiverWrite24bitTransferSeq;
  I2sTransmitterWrite24bitTransferSeq i2sTransmitterWrite24bitTransferSeq;

  extern function new(string name = "I2sVirtual24bitWriteOperationRxMasterTxSlaveSeq");
  extern task body();
endclass : I2sVirtual24bitWriteOperationRxMasterTxSlaveSeq

function I2sVirtual24bitWriteOperationRxMasterTxSlaveSeq::new(string name = "I2sVirtual24bitWriteOperationRxMasterTxSlaveSeq");
  super.new(name);
endfunction : new

task I2sVirtual24bitWriteOperationRxMasterTxSlaveSeq::body();

repeat(2) begin
  i2sReceiverWrite24bitTransferSeq = I2sReceiverWrite24bitTransferSeq::type_id::create("i2sReceiverWrite24bitTransferSeq");
  i2sTransmitterWrite24bitTransferSeq = I2sTransmitterWrite24bitTransferSeq::type_id::create("i2sTransmitterWrite24bitTransferSeq");

  `uvm_info(get_type_name(), $sformatf("Inside Body Seq Start: I2sVirtual24bitWriteOperationRxMasterTxSlaveSeq"), UVM_NONE);




if(!i2sReceiverWrite24bitTransferSeq.randomize() with {rxWsSeq==1;
                                                      rxWordSelectPeriodSeq==48;
                                                      }) begin
       `uvm_error(get_type_name(), "Randomization failed : Inside I2sReceiverWrite24bitTransferSeq")
  end

 

 if (!i2sTransmitterWrite24bitTransferSeq.randomize() with { txWordSelectPeriodSeq==48;
                                                             }) begin
    `uvm_error(get_type_name(), "Randomization failed: Inside I2sTransmitterWrite24bitTransferSeq")
  end

  fork

    begin
  `uvm_info(get_type_name(), "Starting Receiver Sequence", UVM_LOW);
      i2sReceiverWrite24bitTransferSeq.start(p_sequencer.i2sReceiverSequencer);
  end
    begin
        `uvm_info(get_type_name(), "Starting Transmitter Sequence", UVM_LOW);
      i2sTransmitterWrite24bitTransferSeq.start(p_sequencer.i2sTransmitterSequencer);
  end
  join

  `uvm_info(get_type_name(), "Fork_join Completed",UVM_NONE);
  end
endtask : body

`endif

