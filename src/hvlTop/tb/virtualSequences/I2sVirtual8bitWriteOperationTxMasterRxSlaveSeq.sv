`ifndef I2SVIRTUAL8BITSWRITEOPERATIONTXMASTERRXSLAVESEQ_INCLUDED_
`define I2SVIRTUAL8BITSWRITEOPERATIONTXMASTERRXSLAVESEQ_INCLUDED_

class I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq extends I2sVirtualBaseSeq;
  `uvm_object_utils(I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq)

  I2sTransmitterWrite8bitTransferSeq i2sTransmitterWrite8bitTransferSeq;
 
  extern function new(string name = "I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq");
  extern task body();
endclass : I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq

function I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq::new(string name = "I2sVirtual8bitsWriteOperationTxMasterRxSlaveSeq");
  super.new(name);
endfunction : new

task I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq::body();
  i2sTransmitterWrite8bitTransferSeq = I2sTransmitterWrite8bitTransferSeq::type_id::create("i2sTransmitterWrite8bitTransferSeq");

  `uvm_info(get_type_name(), $sformatf("Insdie Body Seq start I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq"), UVM_NONE); 

   if(!i2sTransmitterWrite8bitTransferSeq.randomize() with {SDSeq inside {[0:255]};
                                                              delayForWSSeq == 16;
                                                            }) begin
       `uvm_error(get_type_name(), "Randomization failed : Inside I2sTransmitterWrite8bitTransferSeq")
  end

    i2sTransmitterWrite8bitTransferSeq.start(p_sequencer.i2sTransmitterVirtualSequencer.i2sTransmitterWriteSequencer);

 endtask : body

`endif

