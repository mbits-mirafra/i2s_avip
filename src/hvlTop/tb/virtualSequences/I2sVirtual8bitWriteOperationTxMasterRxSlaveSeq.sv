`ifndef I2SVIRTUAL8BITSWRITEOPERATIONTXMASTERRXSLAVESEQ_INCLUDED_
`define I2SVIRTUAL8BITSWRITEOPERATIONTXMASTERRXSLAVESEQ_INCLUDED_

class I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq extends I2sVirtualBaseSeq;
  `uvm_object_utils(I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq)

  I2sTransmitterWrite8bitTransferSeq i2sTransmitterWrite8bitTransferSeq;
 
  extern function new(string name = "I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq");
  extern task body();
endclass : I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq

function I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq::new(string name = "I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq");
  super.new(name);
endfunction : new

task I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq::body();

repeat(2)
 begin
 i2sTransmitterWrite8bitTransferSeq = I2sTransmitterWrite8bitTransferSeq::type_id::create("i2sTransmitterWrite8bitTransferSeq");
  `uvm_info(get_type_name(), $sformatf("Inside Body Seq start I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq"), UVM_NONE); 
  
   if(!i2sTransmitterWrite8bitTransferSeq.randomize() with { txWsSeq==1; 
                                                           txWordSelectPeriodSeq==16;
                                                            }) begin  

       `uvm_error(get_type_name(), "Randomization failed : Inside I2sTransmitterWrite8bitTransferSeq")
  end


`uvm_info(get_type_name(), "Attempting to start the virtual sequence", UVM_NONE);
i2sTransmitterWrite8bitTransferSeq.start(p_sequencer.i2sTransmitterSequencer);

 end
 endtask : body

`endif


