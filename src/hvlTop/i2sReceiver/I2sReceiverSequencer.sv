`ifndef I2SRECEIVERSEQUENCER_INCLUDED_
`define I2SRECEIVERSEQUENCER_INCLUDED_

class I2sReceiverSequencer extends uvm_sequencer#(I2sReceiverTransaction) ;
  `uvm_component_utils(I2sReceiverSequencer)
 
  I2sReceiverAgentConfig i2sReceiverAgentConfig;

  extern function new(string name = "I2sReceiverSequencer", uvm_component parent = null);
endclass : I2sReceiverSequencer

function I2sReceiverSequencer::new(string name = "I2sReceiverSequencer",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

`endif
