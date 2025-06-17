`ifndef I2SVIRTUALWRITEOPERATIONDATATRANSFERERRORSEQ_INCLUDED_
`define I2SVIRTUALWRITEOPERATIONDATATRANSFERERRORSEQ_INCLUDED_

class I2sVirtualWriteOperationDataTransferErrorSeq extends I2sVirtualBaseSeq;
  `uvm_object_utils(I2sVirtualWriteOperationDataTransferErrorSeq)

  I2sTransmitterWriteErrorSeq i2sTransmitterWriteErrorSeq;
  int wordSelectPeriodVseq;
 
  extern function new(string name = "I2sVirtualWriteOperationDataTransferErrorSeq");
  extern task body();
endclass : I2sVirtualWriteOperationDataTransferErrorSeq

function I2sVirtualWriteOperationDataTransferErrorSeq::new(string name = "I2sVirtualWriteOperationDataTransferErrorSeq");
  super.new(name);
endfunction : new

task I2sVirtualWriteOperationDataTransferErrorSeq::body();
  repeat(2) begin
    i2sTransmitterWriteErrorSeq = I2sTransmitterWriteErrorSeq::type_id::create("i2sTransmitterWriteErrorSeq");
    `uvm_info(get_type_name(), $sformatf("Inside Body Seq start I2sVirtualWriteOperationDataTransferErrorSeq"), UVM_NONE);

    wordSelectPeriodVseq = p_sequencer.i2sTransmitterSequencer.i2sTransmitterAgentConfig.wordSelectPeriod/2;
    if(!i2sTransmitterWriteErrorSeq.randomize() with {txNumOfBitsTransferSeq <= wordSelectPeriodVseq;
  	                                                }) begin  
      `uvm_error(get_type_name(), "Randomization failed : Inside I2sTransmitterWriteErrorSeq")
    end
  
    `uvm_info(get_type_name(), "Attempting to start the virtual sequence", UVM_NONE);
  
    i2sTransmitterWriteErrorSeq.start(p_sequencer.i2sTransmitterSequencer);
  end
endtask : body

`endif






