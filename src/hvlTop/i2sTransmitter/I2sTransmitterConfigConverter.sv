`ifndef I2STRANSMITTERCONFIGCONVERTER_INCLUDED_
`define I2STRANSMITTERCONFIGCONVERTER_INCLUDED_
 
class I2sTransmitterConfigConverter extends uvm_object;
  extern function new(string name = "I2sTransmitterConfigConverter");
 
  extern function void do_print(uvm_printer printer);
endclass : I2sTransmitterConfigConverter
 
function I2sTransmitterConfigConverter::new(string name = "I2sTransmitterConfigConverter");
  super.new(name);
endfunction : new
 
  
function void I2sTransmitterConfigConverter::do_print(uvm_printer printer);
  super.do_print(printer);
endfunction : do_print
 
`endif
