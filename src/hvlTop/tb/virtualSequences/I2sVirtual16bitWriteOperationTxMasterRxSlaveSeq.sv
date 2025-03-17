`ifndef I2SVIRTUAL16BITSWRITEOPERATIONTXMASTERRXSLAVESEQ_INCLUDED_
`define I2SVIRTUAL16BITSWRITEOPERATIONTXMASTERRXSLAVESEQ_INCLUDED_

class I2sVirtual16bitWriteOperationTxMasterRxSlaveSeq extends I2sVirtualBaseSeq;
  `uvm_object_utils(I2sVirtual16bitWriteOperationTxMasterRxSlaveSeq)

  I2sTransmitterWrite16bitTransferSeq i2sTransmitterWrite16bitTransferSeq;
 
  extern function new(string name = "I2sVirtual16bitWriteOperationTxMasterRxSlaveSeq");
  extern task body();
endclass : I2sVirtual16bitWriteOperationTxMasterRxSlaveSeq

function I2sVirtual16bitWriteOperationTxMasterRxSlaveSeq::new(string name = "I2sVirtual16bitWriteOperationTxMasterRxSlaveSeq");
  super.new(name);
endfunction : new

task I2sVirtual16bitWriteOperationTxMasterRxSlaveSeq::body();

repeat(2)
 begin
 i2sTransmitterWrite16bitTransferSeq = I2sTransmitterWrite16bitTransferSeq::type_id::create("i2sTransmitterWrite16bitTransferSeq");
  `uvm_info(get_type_name(), $sformatf("Inside Body Seq start I2sVirtual16bitWriteOperationTxMasterRxSlaveSeq"), UVM_NONE); 
  
   if(!i2sTransmitterWrite16bitTransferSeq.randomize() with {txWsSeq==1; 
                                                             txWordSelectPeriodSeq==32;
							     }) begin  

       `uvm_error(get_type_name(), "Randomization failed : Inside I2sTransmitterWrite16bitTransferSeq")
  end


`uvm_info(get_type_name(), "Attempting to start the virtual sequence", UVM_NONE);
i2sTransmitterWrite16bitTransferSeq.start(p_sequencer.i2sTransmitterSequencer);

 end
 endtask : body
`endif


