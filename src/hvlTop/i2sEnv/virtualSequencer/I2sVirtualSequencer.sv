`ifndef I2SVIRTUALSEQUENCER_INCLUDED_
`define I2SVIRTUALSEQUENCER_INCLUDED_

//--------------------------------------------------------------------------------------------
// This class contains the handle of actual sequencer pointing towards them
//--------------------------------------------------------------------------------------------
class I2sVirtualSequencer extends uvm_sequencer #(uvm_sequence_item);
  `uvm_component_utils(I2sVirtualSequencer)
  
  // Declaring environment configuration handle
   I2sEnvConfig i2sEnvConfig;

  I2sTransmitterSequencer i2sTransmitterSequencer;
  I2sReceiverSequencer  i2sReceiverSequencer;

  extern function new(string name = "I2sVirtualSequencer", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
endclass : I2sVirtualSequencer

function I2sVirtualSequencer::new(string name = "I2sVirtualSequencer",uvm_component parent );
    super.new(name, parent);
endfunction : new

function void I2sVirtualSequencer::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  //if(!uvm_config_db #(I2sEnvConfig)::get(this,"","I2sEnvConfig",i2sEnvConfig))
   //`uvm_error("VSEQR","COULDNT GET")
  
  //slave_seqr_h = new[env_cfg_h.no_of_sagent];
  i2sTransmitterSequencer = I2sTransmitterSequencer::type_id::create("i2sTransmitterSequencer",this);
  i2sReceiverSequencer = I2sReceiverSequencer::type_id::create("i2sReceiverSequencer",this);
  
endfunction : build_phase

`endif

