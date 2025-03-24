`ifndef I2SRECEIVERCONFIGCONVERTER_INCLUDED_
`define I2SRECEIVERCONFIGCONVERTER_INCLUDED_

class I2sReceiverConfigConverter extends uvm_object; 
  extern function new(string name = "I2sReceiverConfigConverter");
  extern static function void fromReceiverClass(input I2sReceiverAgentConfig inputConv, output i2sTransferCfgStruct outputConv);
  extern function void do_print(uvm_printer printer);
endclass : I2sReceiverConfigConverter

function I2sReceiverConfigConverter::new(string name = "I2sReceiverConfigConverter");
  super.new(name);
endfunction : new

function void I2sReceiverConfigConverter::fromReceiverClass(input I2sReceiverAgentConfig inputConv, output i2sTransferCfgStruct outputConv);
  `uvm_info("I2sReceiverConfigConverter",$sformatf("----------------------------------------------------------------------"),UVM_HIGH);
  outputConv.mode =inputConv.mode;
  outputConv.clockPeriod  = inputConv.clockPeriod;
  outputConv.sclkFrequency  = inputConv.sclkFrequency;
  outputConv.clockratefrequency = clockrateFrequencyEnum'(inputConv.clockratefrequency);
  outputConv.Sclk  = inputConv.Sclk;
  outputConv.numOfChannels = numOfChannelsEnum'(inputConv.numOfChannels);
  outputConv.wordSelectPeriod = wordSelectPeriodEnum'(inputConv.wordSelectPeriod);
  
//  outputConv.delayFortxSd  = inputConv.delayFortxSd;
//  outputConv.delayFortxWs  = inputConv.delayFortxWs;

endfunction: fromReceiverClass

function void I2sReceiverConfigConverter::do_print(uvm_printer printer);
  i2sTransferCfgStruct ConfigStruct;
  printer.print_field("mode",ConfigStruct.mode,$bits(ConfigStruct.mode),UVM_STRING);
  printer.print_field("sclkFrequency",ConfigStruct.sclkFrequency,$bits(ConfigStruct.sclkFrequency),UVM_DEC);
  printer.print_field("clockratefrequency",ConfigStruct.clockratefrequency,$bits(ConfigStruct.clockratefrequency),UVM_DEC);
  printer.print_field ("Sclk",ConfigStruct.Sclk, $bits(ConfigStruct.Sclk), UVM_DEC);
  printer.print_field("numOfChannels",ConfigStruct.numOfChannels, $bits(ConfigStruct.numOfChannels), UVM_DEC);
  printer.print_field("wordSelectPeriod",ConfigStruct.wordSelectPeriod, $bits(ConfigStruct.wordSelectPeriod), UVM_DEC);

//  printer.print_field("delayFortxSd",ConfigStruct.delayFortxSd,$bits(ConfigStruct.delayFortxSd),UVM_DEC);
//  printer.print_field("delayFortxWs",ConfigStruct.delayFortxWs,$bits(ConfigStruct.delayFortxWs),UVM_DEC);
endfunction : do_print
`endif
