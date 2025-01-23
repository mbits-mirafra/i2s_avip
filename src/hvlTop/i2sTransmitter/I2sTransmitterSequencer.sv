`ifndef I2STRANSMITTERSEQUENCER_INCLUDED_
`define I2STRANSMITTERSEQUENCER_INCLUDED_

class I2sTransmitterSequencer extends uvm_sequencer#(I2sTransmitterTransaction) ;
  `uvm_component_utils(I2sTransmitterSequencer)
 
  I2sTransmitterAgentConfig i2sTransmitterAgentConfig;

  extern function new(string name = "I2sTransmitterSequencer", uvm_component parent = null);
endclass : I2sTransmitterSequencer

function I2sTransmitterSequencer::new(string name = "I2sTransmitterSequencer", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

`endif
