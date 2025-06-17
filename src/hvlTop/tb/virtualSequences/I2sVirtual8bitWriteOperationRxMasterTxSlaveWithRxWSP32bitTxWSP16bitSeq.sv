`ifndef I2SVIRTUAL8BITSWRITEOPERATIONRXMASTERTXSLAVEWITHRXWSP32BITXWSP16BITSEQ_INCLUDED_
`define I2SVIRTUAL8BITSWRITEOPERATIONRXMASTERTXSLAVEWITHRXWSP32BITXWSP16BITSEQ_INCLUDED_

class I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP32bitTxWSP16bitSeq extends I2sVirtualBaseSeq;
  `uvm_object_utils(I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP32bitTxWSP16bitSeq)

  I2sReceiverWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq i2sReceiverWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq;
  I2sTransmitterWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq i2sTransmitterWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq;  
  int wordSelectPeriodVseq;

  extern function new(string name = "I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP32bitTxWSP16bitSeq");
  extern task body();
endclass : I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP32bitTxWSP16bitSeq

function I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP32bitTxWSP16bitSeq::new(string name = "I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP32bitTxWSP16bitSeq");
  super.new(name);
endfunction : new

task I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP32bitTxWSP16bitSeq::body();
  repeat(2) begin
    i2sReceiverWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq = I2sReceiverWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq::type_id::create("i2sReceiverWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq");
    i2sTransmitterWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq = I2sTransmitterWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq::type_id::create("i2sTransmitterWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq");

    `uvm_info(get_type_name(), $sformatf("Inside task Body Seq Start: I2sVirtual8bitWriteOperationRxMasterTxSlaveWithRxWSP32bitTxWSP16bitSeq"), UVM_NONE);

    if(!i2sReceiverWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq.randomize() with {rxWsSeq==1;
                                                                                }) begin
      `uvm_error(get_type_name(), "Randomization failed : Inside I2sReceiverWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq")
    end

    wordSelectPeriodVseq = p_sequencer.i2sTransmitterSequencer.i2sTransmitterAgentConfig.wordSelectPeriod/2;
    if(!i2sTransmitterWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq.randomize() with {txNumOfBitsTransferSeq == wordSelectPeriodVseq; 
                                                                                  }) begin
      `uvm_error(get_type_name(), "Randomization failed: Inside I2sTransmitterWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq")
    end

    fork
      begin
        `uvm_info(get_type_name(), "Starting Receiver Sequence", UVM_LOW);
        i2sReceiverWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq.start(p_sequencer.i2sReceiverSequencer);
      end
      begin
        `uvm_info(get_type_name(), "Starting Transmitter Sequence", UVM_LOW);
        i2sTransmitterWrite8bitTransferWithRxWSP32bitTxWSP16bitSeq.start(p_sequencer.i2sTransmitterSequencer);
      end
    join

    `uvm_info(get_type_name(), "Fork_join Completed",UVM_NONE);
  end
endtask : body

`endif


