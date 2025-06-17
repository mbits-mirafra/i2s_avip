`ifndef I2SVIRTUAL24BITSWRITEOPERATIONRXMASTERTXSLAVEWITHRXWSP64BITXWSP64BITSEQ_INCLUDED_
`define I2SVIRTUAL24BITSWRITEOPERATIONRXMASTERTXSLAVEWITHRXWSP64BITXWSP64BITSEQ_INCLUDED_

class I2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP48bitSeq extends I2sVirtualBaseSeq;
  `uvm_object_utils(I2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP48bitSeq)

  I2sReceiverWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq i2sReceiverWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq;
  I2sTransmitterWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq i2sTransmitterWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq;
  int wordSelectPeriodVseq;

  extern function new(string name = "I2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP48bitSeq");
  extern task body();
endclass : I2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP48bitSeq

function I2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP48bitSeq::new(string name = "I2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP48bitSeq");
  super.new(name);
endfunction : new

task I2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP48bitSeq::body();
  repeat(2) begin
    i2sReceiverWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq = I2sReceiverWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq::type_id::create("i2sReceiverWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq");
    i2sTransmitterWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq = I2sTransmitterWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq::type_id::create("i2sTransmitterWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq");
  
    `uvm_info(get_type_name(), $sformatf("Inside task Body Seq Start: I2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP48bitSeq"), UVM_NONE);

    if(!i2sReceiverWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq.randomize() with {rxWsSeq==1;
  	                                    						                             }) begin
      `uvm_error(get_type_name(), "Randomization failed : Inside I2sReceiverWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq")
    end
  
    wordSelectPeriodVseq = p_sequencer.i2sTransmitterSequencer.i2sTransmitterAgentConfig.wordSelectPeriod/2;
    if(!i2sTransmitterWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq.randomize() with 
                                                                {txNumOfBitsTransferSeq == wordSelectPeriodVseq; 
                                                               }) begin
      `uvm_error(get_type_name(), "Randomization failed: Inside I2sTransmitterWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq")
    end
  
    fork
      begin
        `uvm_info(get_type_name(), "Starting Receiver Sequence", UVM_LOW);
        i2sReceiverWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq.start(p_sequencer.i2sReceiverSequencer);
      end
      begin
        `uvm_info(get_type_name(), "Starting Transmitter Sequence", UVM_LOW);
        i2sTransmitterWrite24bitTransferWithRxWSP64bitTxWSP48bitSeq.start(p_sequencer.i2sTransmitterSequencer);
      end
    join
  
    `uvm_info(get_type_name(), "Fork_join Completed",UVM_NONE);
  end
endtask : body

`endif


