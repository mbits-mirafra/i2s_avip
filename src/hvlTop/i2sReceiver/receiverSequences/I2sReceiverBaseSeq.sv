`ifndef I2SRECEIVERRBASESEQ_INCLUDED_
`define I2SRECEIVERBASESEQ_INCLUDED_

class I2sReceiverBaseSeq extends uvm_sequence #(I2sReceiverTransaction);
  `uvm_object_utils(I2sReceiverBaseSeq)

  I2sReceiverTransaction req;
  `uvm_declare_p_sequencer(I2sReceiverSequencer) 

  extern function new(string name = "I2sReceiverBaseSeq");
  extern virtual task body();
endclass : I2sReceiverBaseSeq


function I2sReceiverBaseSeq::new(string name = "I2sReceiverBaseSeq");
  super.new(name);
endfunction : new

task I2sReceiverBaseSeq::body();
  req = I2sReceiverTransaction::type_id::create("I2sReceiverTransaction");
  if(!$cast(p_sequencer,m_sequencer))begin
    `uvm_error(get_full_name(),"Virtual sequencer pointer cast failed")
  end
endtask:body

`endif
