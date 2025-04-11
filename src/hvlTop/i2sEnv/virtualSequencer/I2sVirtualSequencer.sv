`ifndef I2SVIRTUALSEQUENCER_INCLUDED_
`define I2SVIRTUALSEQUENCER_INCLUDED_

class I2sVirtualSequencer extends uvm_sequencer #(uvm_sequence_item);
  `uvm_component_utils(I2sVirtualSequencer)
  
   I2sEnvConfig i2sEnvConfig;

  I2sTransmitterSequencer i2sTransmitterSequencer;
  I2sReceiverSequencer  i2sReceiverSequencer;

  extern function new(string name = "I2sVirtualSequencer", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
endclass : I2sVirtualSequencer

function I2sVirtualSequencer::new(string name = "I2sVirtualSequencer",uvm_component parent );
    super.new(name, parent);
endfunction : new

function void I2sVirtualSequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  if(!uvm_config_db #(I2sEnvConfig)::get(this,"","I2sEnvConfig",i2sEnvConfig))
   `uvm_fatal(get_type_name(),"cannot get() env_cfg from uvm_config_db.Have you set() it?")

    i2sTransmitterSequencer = I2sTransmitterSequencer::type_id::create("i2sTransmitterSequencer",this);
   i2sReceiverSequencer = I2sReceiverSequencer::type_id::create("i2sReceiverSequencer",this);
  
endfunction : build_phase

function void I2sVirtualSequencer::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase
 
function void I2sVirtualSequencer::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction  : end_of_elaboration_phase
 
function void I2sVirtualSequencer::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase
 
 
task I2sVirtualSequencer::run_phase(uvm_phase phase);
endtask : run_phase

`endif

