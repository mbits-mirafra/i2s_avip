`ifndef I2SVIRTUALRANDOMWRITEOPERATIONTXMASTERRXSLAVEWITHTXWSP64BITSEQ_INCLUDED_
`define I2SVIRTUALRANDOMWRITEOPERATIONTXMASTERRXSLAVEWITHTXWSP64BITSEQ_INCLUDED_

class I2sVirtualRandomWriteOperationTxMasterRxSlaveWithTxWSP64bitSeq extends I2sVirtualBaseSeq;
  `uvm_object_utils(I2sVirtualRandomWriteOperationTxMasterRxSlaveWithTxWSP64bitSeq)

  I2sTransmitterWriteRandomTransferSeq i2sTransmitterWriteRandomTransferSeq;
 
  extern function new(string name = "I2sVirtualRandomWriteOperationTxMasterRxSlaveWithTxWSP64bitSeq");
  extern task body();
endclass : I2sVirtualRandomWriteOperationTxMasterRxSlaveWithTxWSP64bitSeq

function I2sVirtualRandomWriteOperationTxMasterRxSlaveWithTxWSP64bitSeq::new(string name = "I2sVirtualRandomWriteOperationTxMasterRxSlaveWithTxWSP64bitSeq");
  super.new(name);
endfunction : new

task I2sVirtualRandomWriteOperationTxMasterRxSlaveWithTxWSP64bitSeq::body();

repeat(5)
 begin
 i2sTransmitterWriteRandomTransferSeq = I2sTransmitterWriteRandomTransferSeq::type_id::create("i2sTransmitterWriteRandomTransferSeq");
  `uvm_info(get_type_name(), $sformatf("Inside Body Seq start I2sVirtualRandomWriteOperationTxMasterRxSlaveWithTxWSP64bitSeq"), UVM_NONE);    

   if(!i2sTransmitterWriteRandomTransferSeq.randomize() with {txNumOfBitsTransferSeq <= (p_sequencer.i2sTransmitterSequencer.i2sTransmitterAgentConfig.wordSelectPeriod/2);
	                                                    }) begin  

       `uvm_error(get_type_name(), "Randomization failed : Inside I2sTransmitterWriteRandomTransferSeq")
  end


`uvm_info(get_type_name(), "Attempting to start the virtual sequence", UVM_NONE);
i2sTransmitterWriteRandomTransferSeq.start(p_sequencer.i2sTransmitterSequencer);

 end
 endtask : body

`endif





