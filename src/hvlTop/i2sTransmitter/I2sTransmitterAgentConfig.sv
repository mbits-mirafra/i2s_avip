`ifndef I2STRANSMITTERAGENTCONFIG_INCLUDED_
`define I2STRANSMITTERAGENTCONFIG_INCLUDED_
 
class I2sTransmitterAgentConfig extends uvm_object;
  `uvm_object_utils(I2sTransmitterAgentConfig)
 
  uvm_active_passive_enum isActive=UVM_ACTIVE;  
  hasCoverage_e hasCoverage = TRUE;
 
  extern function new(string name = "I2sTransmitterAgentConfig");
  extern function void do_print(uvm_printer printer);
  extern function void post_randomize();
endclass : I2sTransmitterAgentConfig
 
 
function I2sTransmitterAgentConfig::new(string name = "I2sTransmitterAgentConfig");
  super.new(name);
endfunction : new
 
 
function void I2sTransmitterAgentConfig::do_print(uvm_printer printer);
  super.do_print(printer);
 
  printer.print_string ("isActive",isActive.name());
  printer.print_string("hasCoverage",hasCoverage.name());
endfunction : do_print
 
  
  function void I2sTransmitterAgentConfig::post_randomize();
  endfunction: post_randomize

 
`endif
