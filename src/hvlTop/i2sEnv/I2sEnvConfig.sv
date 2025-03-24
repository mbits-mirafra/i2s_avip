`ifndef I2SENVCONFIG_INCLUDED_
`define I2SENVCONFIG_INCLUDED_

class I2sEnvConfig extends uvm_object;
  `uvm_object_utils(I2sEnvConfig)

   bit hasScoreboard;
   bit hasVirtualSequencer;
   I2sTransmitterAgentConfig i2sTransmitterAgentConfig;
   I2sReceiverAgentConfig i2sReceiverAgentConfig;

  extern function new(string name = "I2sEnvConfig");
  extern function void do_print(uvm_printer printer);
endclass : I2sEnvConfig

function I2sEnvConfig::new(string name = "I2sEnvConfig");
  super.new(name);
endfunction : new

function void I2sEnvConfig::do_print(uvm_printer printer);
  super.do_print(printer);
  `uvm_info(get_full_name(),"inside i2s env config do print function",UVM_NONE)
  printer.print_field ("hasScoreboard",hasScoreboard,1, UVM_DEC);
  printer.print_field ("hasVirtualSequencer",hasVirtualSequencer,1, UVM_DEC);
endfunction : do_print

`endif



