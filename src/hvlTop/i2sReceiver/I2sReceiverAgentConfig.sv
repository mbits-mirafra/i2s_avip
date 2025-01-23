`ifndef I2SRECEIVERAGENTCONFIG_INCLUDED_
`define I2SRECEIVERAGENTCONFIG_INCLUDED_

class I2sReceiverAgentConfig extends uvm_object;
  `uvm_object_utils(I2sReceiverAgentConfig)

  /*uvm_active_passive_enum isActive = UVM_ACTIVE;
  hasCoverage_e hasCoverage = TRUE;
  dataTransferDirection_e dataTransferDirection;
  bit [TARGET_ADDRESS_WIDTH-1:0] targetAddress;
  bit [DATA_WIDTH-1:0]defaultReadData = 'hFF;*/
 
  extern function new(string name = "I2sReceiverAgentConfig");
  extern function void do_print(uvm_printer printer);
endclass : I2sReceiverAgentConfig


function I2sReceiverAgentConfig::new(string name = "I2sReceiverAgentConfig");
  super.new(name);
endfunction : new


function void I2sReceiverAgentConfig::do_print(uvm_printer printer);
  super.do_print(printer);
 // printer.print_string ("isActive",isActive.name());
 // printer.print_string ("dataTransferDirection",dataTransferDirection.name());
 // printer.print_string("hasCoverage",hasCoverage.name());
 // printer.print_field("targetAddress",targetAddress,$bits(targetAddress),UVM_HEX);
endfunction : do_print

`endif
