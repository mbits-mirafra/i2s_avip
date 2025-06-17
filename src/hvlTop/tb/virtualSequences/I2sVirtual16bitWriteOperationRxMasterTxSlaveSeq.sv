`ifndef I2SVIRTUAL16BITSWRITEOPERATIONRXMASTERTXSLAVESEQ_INCLUDED_
`define I2SVIRTUAL16BITSWRITEOPERATIONRXMASTERTXSLAVESEQ_INCLUDED_

class I2sVirtual16bitWriteOperationRxMasterTxSlaveSeq extends I2sVirtualBaseSeq;
  `uvm_object_utils(I2sVirtual16bitWriteOperationRxMasterTxSlaveSeq)

  I2sReceiverWrite16bitTransferSeq i2sReceiverWrite16bitTransferSeq;
  I2sTransmitterWrite16bitTransferSeq i2sTransmitterWrite16bitTransferSeq;
  int wordSelectPeriodVseq;

  extern function new(string name = "I2sVirtual16bitWriteOperationRxMasterTxSlaveSeq");
  extern task body();
endclass : I2sVirtual16bitWriteOperationRxMasterTxSlaveSeq

function I2sVirtual16bitWriteOperationRxMasterTxSlaveSeq::new(string name = "I2sVirtual16bitWriteOperationRxMasterTxSlaveSeq");
  super.new(name);
endfunction : new

task I2sVirtual16bitWriteOperationRxMasterTxSlaveSeq::body();
  repeat(2) begin
    i2sReceiverWrite16bitTransferSeq = I2sReceiverWrite16bitTransferSeq::type_id::create("i2sReceiverWrite16bitTransferSeq");
    i2sTransmitterWrite16bitTransferSeq = I2sTransmitterWrite16bitTransferSeq::type_id::create("i2sTransmitterWrite16bitTransferSeq");
  
    `uvm_info(get_type_name(), $sformatf("Inside Body Seq Start: I2sVirtual16bitWriteOperationRxMasterTxSlaveSeq"), UVM_NONE);
  
    if(!i2sReceiverWrite16bitTransferSeq.randomize() with {rxWsSeq==1;
                                                         }) begin
      `uvm_error(get_type_name(), "Randomization failed : Inside I2sReceiverWrite16bitTransferSeq")
    end
  
    wordSelectPeriodVseq = p_sequencer.i2sTransmitterSequencer.i2sTransmitterAgentConfig.wordSelectPeriod/2;
    if(!i2sTransmitterWrite16bitTransferSeq.randomize() with {txNumOfBitsTransferSeq == wordSelectPeriodVseq;
                                                            }) begin
      `uvm_error(get_type_name(), "Randomization failed: Inside I2sTransmitterWrite16bitTransferSeq")
    end

    fork
      begin
        `uvm_info(get_type_name(), "Starting Receiver Sequence", UVM_LOW);
        i2sReceiverWrite16bitTransferSeq.start(p_sequencer.i2sReceiverSequencer);
      end
      begin
        `uvm_info(get_type_name(), "Starting Transmitter Sequence", UVM_LOW);
        i2sTransmitterWrite16bitTransferSeq.start(p_sequencer.i2sTransmitterSequencer);
      end
    join
  
    `uvm_info(get_type_name(), "Fork_join Completed",UVM_NONE);
  end

endtask : body

`endif


