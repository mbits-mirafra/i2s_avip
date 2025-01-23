`ifndef I2SRECEIVERSEQUENCE_INCLUDED_
`define I2SRECEIVERSEQUENCE_INCLUDED_

class I2sReceiverSequence extends uvm_object;
  `uvm_object_utils(I2sReceiverSequence)

   extern function new(string name = "I2sReceiverSequence");
endclass : I2sReceiverSequence

function I2sReceiverSequence::new(string name = "I2sReceiverSequence");
  super.new(name);
endfunction : new

`endif
