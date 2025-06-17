`ifndef I2SVIRTUAL16BITSWRITEOPERATIONRXMASTERTXSLAVEWITHRXWSP16BITXWSP32BITSEQ_INCLUDED_
`define I2SVIRTUAL16BITSWRITEOPERATIONRXMASTERTXSLAVEWITHRXWSP16BITXWSP32BITSEQ_INCLUDED_

class I2sVirtual16bitWriteOperationRxMasterTxSlaveWithRxWSP16bitTxWSP32bitSeq extends I2sVirtualBaseSeq;
  `uvm_object_utils(I2sVirtual16bitWriteOperationRxMasterTxSlaveWithRxWSP16bitTxWSP32bitSeq)

  I2sReceiverWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq i2sReceiverWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq;
  I2sTransmitterWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq i2sTransmitterWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq;  
  int wordSelectPeriodVseq;

  extern function new(string name = "I2sVirtual16bitWriteOperationRxMasterTxSlaveWithRxWSP16bitTxWSP32bitSeq");
  extern task body();
endclass : I2sVirtual16bitWriteOperationRxMasterTxSlaveWithRxWSP16bitTxWSP32bitSeq

function I2sVirtual16bitWriteOperationRxMasterTxSlaveWithRxWSP16bitTxWSP32bitSeq::new(string name = "I2sVirtual16bitWriteOperationRxMasterTxSlaveWithRxWSP16bitTxWSP32bitSeq");
  super.new(name);
endfunction : new

task I2sVirtual16bitWriteOperationRxMasterTxSlaveWithRxWSP16bitTxWSP32bitSeq::body();
  repeat(2) begin
  i2sReceiverWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq = I2sReceiverWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq::type_id::create("i2sReceiverWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq");
  i2sTransmitterWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq = I2sTransmitterWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq::type_id::create("i2sTransmitterWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq");

  `uvm_info(get_type_name(), $sformatf("Inside task Body Seq Start: I2sVirtual16bitWriteOperationRxMasterTxSlaveWithRxWSP16bitTxWSP32bitSeq"), UVM_NONE);



   if(!i2sReceiverWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq.randomize() with{rxWsSeq==1;
							                                                                  }) begin
    `uvm_error(get_type_name(), "Randomization failed : Inside I2sReceiverWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq")
  end

    wordSelectPeriodVseq = p_sequencer.i2sTransmitterSequencer.i2sTransmitterAgentConfig.wordSelectPeriod/2;
    if (!i2sTransmitterWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq.randomize() with {txNumOfBitsTransferSeq == wordSelectPeriodVseq; 
                                                                                      }) begin
    `uvm_error(get_type_name(), "Randomization failed: Inside I2sTransmitterWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq")
  end

  fork
    begin
      `uvm_info(get_type_name(), "Starting Receiver Sequence", UVM_LOW);
       i2sReceiverWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq.start(p_sequencer.i2sReceiverSequencer);
    end
    begin
      `uvm_info(get_type_name(), "Starting Transmitter Sequence", UVM_LOW);
      i2sTransmitterWrite16bitTransferWithRxWSP16bitTxWSP32bitSeq.start(p_sequencer.i2sTransmitterSequencer);
    end
  join

  `uvm_info(get_type_name(), "Fork_join Completed",UVM_NONE);
  end

endtask : body

`endif

