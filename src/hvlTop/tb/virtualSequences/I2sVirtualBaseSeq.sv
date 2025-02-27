`ifndef I2SVIRTUALBASESEQ_INCLUDED_
`define I2SVIRTUALBASESEQ_INCLUDED_

class I2sVirtualBaseSeq extends uvm_sequence#(uvm_sequence_item);
  `uvm_object_utils(I2sVirtualBaseSeq)

   `uvm_declare_p_sequencer(I2sVirtualSequencer)
        
   I2sTransmitterSequencer  i2sTransmitterSequencer;
   I2sReceiverSequencer   i2sReceiverSequencer;
   I2sEnvConfig i2sEnvConfig;
   
   extern function new(string name="I2sVirtualBaseSeq");
   extern task body();
endclass:I2sVirtualBaseSeq
 
function I2sVirtualBaseSeq::new(string name="I2sVirtualBaseSeq");
  super.new(name);
endfunction:new
  
task I2sVirtualBaseSeq::body();
  if(!uvm_config_db#(I2sEnvConfig) ::get(null,get_full_name(),"I2sEnvConfig",i2sEnvConfig)) begin
  `uvm_fatal("CONFIG","cannot get() env_cfg from uvm_config_db.Have you set() it?")
  end

  if(!$cast(p_sequencer,m_sequencer))begin
  `uvm_error(get_full_name(),"Virtual sequencer pointer cast failed")
  end
                                             
  i2sTransmitterSequencer = p_sequencer.i2sTransmitterSequencer;
  i2sReceiverSequencer    = p_sequencer.i2sReceiverSequencer;

endtask:body

`endif
