`ifndef I2SVIRTUALWRITEOPERATIONWITHINVALIDWSPERRORSEQ_INCLUDED_
`define I2SVIRTUALWRITEOPERATIONWITHINVALIDWSPERRORSEQ_INCLUDED_

class I2sVirtualWriteOperationWithInvalidWSPErrorSeq extends I2sVirtualBaseSeq;
  `uvm_object_utils(I2sVirtualWriteOperationWithInvalidWSPErrorSeq)

  I2sTransmitterWriteErrorSeq i2sTransmitterWriteErrorSeq;
  int wordSelectPeriodVseq;
 
  extern function new(string name = "I2sVirtualWriteOperationWithInvalidWSPErrorSeq");
  extern task body();
endclass : I2sVirtualWriteOperationWithInvalidWSPErrorSeq

function I2sVirtualWriteOperationWithInvalidWSPErrorSeq::new(string name = "I2sVirtualWriteOperationWithInvalidWSPErrorSeq");
  super.new(name);
endfunction : new

task I2sVirtualWriteOperationWithInvalidWSPErrorSeq::body();
  repeat(2) begin
    i2sTransmitterWriteErrorSeq = I2sTransmitterWriteErrorSeq::type_id::create("i2sTransmitterWriteErrorSeq");
    `uvm_info(get_type_name(), $sformatf("Inside Body Seq start I2sVirtualWriteOperationWithInvalidWSPErrorSeq"), UVM_NONE);    
  
    wordSelectPeriodVseq = p_sequencer.i2sTransmitterSequencer.i2sTransmitterAgentConfig.wordSelectPeriod/2;
    if(!i2sTransmitterWriteErrorSeq.randomize() with {txNumOfBitsTransferSeq == wordSelectPeriodVseq;
  	                                                }) begin  
      `uvm_error(get_type_name(), "Randomization failed : Inside I2sTransmitterWriteErrorSeq")
    end
    
    `uvm_info(get_type_name(),"Attempting to start the virtual sequence", UVM_NONE);
    i2sTransmitterWriteErrorSeq.start(p_sequencer.i2sTransmitterSequencer);
  
  end
endtask : body

`endif



