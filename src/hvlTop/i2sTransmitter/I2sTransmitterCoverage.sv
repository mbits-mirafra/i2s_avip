`ifndef I2STRANSMITTERCOVERAGE_INCLUDED_
`define I2STRANSMITTERCOVERAGE_INCLUDED_
 
class I2sTransmitterCoverage extends uvm_subscriber#(I2sTransmitterTransaction);
`uvm_component_utils(I2sTransmitterCoverage)
 
 
  extern function new(string name = "I2sTransmitterCoverage", uvm_component parent = null);
  extern virtual function void display();
  extern virtual function void write(I2sTransmitterTransaction t);
  extern virtual function void report_phase(uvm_phase phase);
 
endclass : I2sTransmitterCoverage
 
 
function I2sTransmitterCoverage::new(string name = "I2sTransmitterCoverage", uvm_component parent = null);
  super.new(name, parent);
endfunction : new
 
 
function void  I2sTransmitterCoverage::display();  
  $display("");
  $display("--------------------------------------");
  $display(" COVERAGE");
  $display("--------------------------------------");
  $display("");
endfunction : display
 
 
function void I2sTransmitterCoverage::write(I2sTransmitterTransaction t);
  `uvm_info(get_type_name(), $sformatf("Before Calling the Sample Method"),UVM_HIGH);    
  `uvm_info(get_type_name(), $sformatf("After Calling the Sample Method"),UVM_HIGH);
endfunction: write
 
function void I2sTransmitterCoverage::report_phase(uvm_phase phase);
display(); 
endfunction: report_phase
`endif



