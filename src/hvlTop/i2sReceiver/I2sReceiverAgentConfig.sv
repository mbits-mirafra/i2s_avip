`ifndef I2SRECEIVERAGENTCONFIG_INCLUDED_
`define I2SRECEIVERAGENTCONFIG_INCLUDED_

class I2sReceiverAgentConfig extends uvm_object;
  `uvm_object_utils(I2sReceiverAgentConfig)

  uvm_active_passive_enum isActive; 
  hasCoverageEnum hasCoverage = TRUE;
  modeTypeEnum mode;
  clockrateFrequencyEnum clockratefrequency;
  numOfBitsTransferEnum numOfBitsTransfer;
  bit Sclk;

  int clockPeriod;
  int sclkFrequency;
  int delayFortxSd;
  int delayFortxWs;
 
  extern function new(string name = "I2sReceiverAgentConfig");
  extern function void do_print(uvm_printer printer);
endclass : I2sReceiverAgentConfig


function I2sReceiverAgentConfig::new(string name = "I2sReceiverAgentConfig");
  super.new(name);
endfunction : new


function void I2sReceiverAgentConfig::do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_string ("isActive",isActive.name());
  printer.print_string ("mode",mode.name());
  printer.print_string("hasCoverage",hasCoverage.name());
  printer.print_field ("clockPeriod",clockPeriod, $bits(clockPeriod), UVM_DEC);
  printer.print_field ("sclkFrequency",sclkFrequency, $bits(sclkFrequency), UVM_DEC);
  printer.print_field ("clockratefrequency",clockratefrequency, $bits(clockratefrequency), UVM_DEC);
  printer.print_field ("numOfBitsTransfer",numOfBitsTransfer, $bits(numOfBitsTransfer), UVM_DEC);
  printer.print_field ("Sclk",Sclk, $bits(Sclk), UVM_DEC);
  printer.print_field ("delayFortxSd", delayFortxSd, 32, UVM_DEC);
  printer.print_field ("delayFortxWs", delayFortxWs, 32, UVM_DEC);

 endfunction : do_print

`endif
