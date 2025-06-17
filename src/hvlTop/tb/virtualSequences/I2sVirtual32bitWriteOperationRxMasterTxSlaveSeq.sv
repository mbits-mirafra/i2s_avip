`ifndef I2SVIRTUAL32BITSWRITEOPERATIONRXMASTERTXSLAVESEQ_INCLUDED_
`define I2SVIRTUAL32BITSWRITEOPERATIONRXMASTERTXSLAVESEQ_INCLUDED_

class I2sVirtual32bitWriteOperationRxMasterTxSlaveSeq extends I2sVirtualBaseSeq;
  `uvm_object_utils(I2sVirtual32bitWriteOperationRxMasterTxSlaveSeq)

  I2sReceiverWrite32bitTransferSeq i2sReceiverWrite32bitTransferSeq;
  I2sTransmitterWrite32bitTransferSeq i2sTransmitterWrite32bitTransferSeq;
  int wordSelectPeriodVseq;

  extern function new(string name = "I2sVirtual32bitWriteOperationRxMasterTxSlaveSeq");
  extern task body();
endclass : I2sVirtual32bitWriteOperationRxMasterTxSlaveSeq

function I2sVirtual32bitWriteOperationRxMasterTxSlaveSeq::new(string name = "I2sVirtual32bitWriteOperationRxMasterTxSlaveSeq");
  super.new(name);
endfunction : new

task I2sVirtual32bitWriteOperationRxMasterTxSlaveSeq::body();
  repeat(2) begin
    i2sReceiverWrite32bitTransferSeq = I2sReceiverWrite32bitTransferSeq::type_id::create("i2sReceiverWrite32bitTransferSeq");
    i2sTransmitterWrite32bitTransferSeq = I2sTransmitterWrite32bitTransferSeq::type_id::create("i2sTransmitterWrite32bitTransferSeq");
  
    `uvm_info(get_type_name(), $sformatf("Inside Body Seq Start: I2sVirtual32bitWriteOperationRxMasterTxSlaveSeq"), UVM_NONE);
  
    if(!i2sReceiverWrite32bitTransferSeq.randomize() with {rxWsSeq==1;
                                                         }) begin
      `uvm_error(get_type_name(), "Randomization failed : Inside I2sReceiverWrite32bitTransferSeq")
    end
   
    wordSelectPeriodVseq = p_sequencer.i2sTransmitterSequencer.i2sTransmitterAgentConfig.wordSelectPeriod/2;
  
    if(!i2sTransmitterWrite32bitTransferSeq.randomize() with {txNumOfBitsTransferSeq == wordSelectPeriodVseq;
                                                            }) begin
      `uvm_error(get_type_name(), "Randomization failed: Inside I2sTransmitterWrite32bitTransferSeq")
    end
  
    fork
      begin
        `uvm_info(get_type_name(), "Starting Receiver Sequence", UVM_LOW);
        i2sReceiverWrite32bitTransferSeq.start(p_sequencer.i2sReceiverSequencer);
      end
      begin
        `uvm_info(get_type_name(), "Starting Transmitter Sequence", UVM_LOW);
        i2sTransmitterWrite32bitTransferSeq.start(p_sequencer.i2sTransmitterSequencer);
      end
    join
  
    `uvm_info(get_type_name(), "Fork_join Completed",UVM_NONE);
  end
endtask : body

`endif

