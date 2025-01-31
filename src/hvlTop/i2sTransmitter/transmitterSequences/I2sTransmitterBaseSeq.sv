`ifndef I2STRANSMITTERBASESEQ_INCLUDED_
`define I2STRANSMITTERBASESEQ_INCLUDED_

class I2sTransmitterBaseSeq extends uvm_sequence #(I2sTransmitterTransaction);
  `uvm_object_utils(I2sTransmitterBaseSeq)

  `uvm_declare_p_sequencer(I2sTransmitterSequencer) 

  extern function new(string name = "I2sTransmitterBaseSeq");
  extern virtual task body();
endclass : I2sTransmitterBaseSeq


function I2sTransmitterBaseSeq::new(string name = "I2sTransmitterBaseSeq");
  super.new(name);
endfunction : new

task I2sTransmitterBaseSeq::body();
  //dynamic casting of p_sequencer and m_sequencer
  if(!$cast(p_sequencer,m_sequencer))begin
    `uvm_error(get_full_name(),"Virtual sequencer pointer cast failed")
  end
endtask:body

`endif
