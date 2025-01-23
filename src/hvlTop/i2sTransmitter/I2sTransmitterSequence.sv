`ifndef I2STRANSMITTERSEQUENCE_INCLUDED_
`define I2STRANSMITTERSEQUENCE_INCLUDED_
 
//--------------------------------------------------------------------------------------------
// Class: I2sTransmitterSequence
//--------------------------------------------------------------------------------------------
class I2sTransmitterSequence extends uvm_component;
  `uvm_component_utils(I2sTransmitterSequence)
 
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "I2sTransmitterSequence", uvm_component parent = null);
 
endclass : I2sTransmitterSequence
 
//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - I2sTransmitterSequence
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function I2sTransmitterSequence::new(string name = "I2sTransmitterSequence", uvm_component parent = null);
  super.new(name, parent);
endfunction : new
 
 
`endif
