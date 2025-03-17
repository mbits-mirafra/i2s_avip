`ifndef I2SVIRTUAL24BITSWRITEOPERATIONTXMASTERRXSLAVESEQ_INCLUDED_
`define I2SVIRTUAL24BITSWRITEOPERATIONTXMASTERRXSLAVESEQ_INCLUDED_

class I2sVirtual24bitWriteOperationTxMasterRxSlaveSeq extends I2sVirtualBaseSeq;
  `uvm_object_utils(I2sVirtual24bitWriteOperationTxMasterRxSlaveSeq)

  I2sTransmitterWrite24bitTransferSeq i2sTransmitterWrite24bitTransferSeq;
 
  extern function new(string name = "I2sVirtual24bitWriteOperationTxMasterRxSlaveSeq");
  extern task body();
endclass : I2sVirtual24bitWriteOperationTxMasterRxSlaveSeq

function I2sVirtual24bitWriteOperationTxMasterRxSlaveSeq::new(string name = "I2sVirtual24bitWriteOperationTxMasterRxSlaveSeq");
  super.new(name);
endfunction : new

task I2sVirtual24bitWriteOperationTxMasterRxSlaveSeq::body();

repeat(2)
 begin
 i2sTransmitterWrite24bitTransferSeq = I2sTransmitterWrite24bitTransferSeq::type_id::create("i2sTransmitterWrite24bitTransferSeq");
  `uvm_info(get_type_name(), $sformatf("Inside Body Seq start I2sVirtual24bitWriteOperationTxMasterRxSlaveSeq"), UVM_NONE); 
  
   if(!i2sTransmitterWrite24bitTransferSeq.randomize() with { txWsSeq==1; 
                                                              txWordSelectPeriodSeq==48;                                                                                                                                            }) begin  

       `uvm_error(get_type_name(), "Randomization failed : Inside I2sTransmitterWrite24bitTransferSeq")
  end


`uvm_info(get_type_name(), "Attempting to start the virtual sequence", UVM_NONE);
i2sTransmitterWrite24bitTransferSeq.start(p_sequencer.i2sTransmitterSequencer);

 end
 endtask : body
`endif

