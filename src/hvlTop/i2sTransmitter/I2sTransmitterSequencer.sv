`ifndef I2STRANSMITTERSEQUENCER_INCLUDED_
`define I2STRANSMITTERSEQUENCER_INCLUDED_

class I2sTransmitterSequencer extends uvm_sequencer#(I2sTransmitterTransaction) ;
  `uvm_component_utils(I2sTransmitterSequencer)
 
  I2sTransmitterAgentConfig i2sTransmitterAgentConfig;

  extern function new(string name = "I2sTransmitterSequencer", uvm_component parent = null);
  extern task run_phase(uvm_phase phase);
  
endclass : I2sTransmitterSequencer

function I2sTransmitterSequencer::new(string name = "I2sTransmitterSequencer", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

task I2sTransmitterSequencer::run_phase(uvm_phase phase);
  super.run_phase(phase);
  $display("start seqr run phase");
endtask: run_phase
`endif
