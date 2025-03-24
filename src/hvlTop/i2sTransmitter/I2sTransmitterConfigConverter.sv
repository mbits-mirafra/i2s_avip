`ifndef I2STRASMITTERCONFIGCONVERTER_INCLUDED_
`define I2STRASMITTERCONFIGCONVERTER_INCLUDED_

class I2sTransmitterConfigConverter extends uvm_object;

  extern function new(string name = "I2sTransmitterConfigConverter");
  extern static function void fromTransmitterClass(input I2sTransmitterAgentConfig inputConv, output i2sTransferCfgStruct outputConv);
  extern function void do_print(uvm_printer printer);

endclass : I2sTransmitterConfigConverter
 
function I2sTransmitterConfigConverter::new(string name = "I2sTransmitterConfigConverter");
  super.new(name);
endfunction : new
 
function void I2sTransmitterConfigConverter::fromTransmitterClass(input I2sTransmitterAgentConfig inputConv, output i2sTransferCfgStruct outputConv);
  `uvm_info("I2sTransmitterConfigConverter",$sformatf("----------------------------------------------------------------------"),UVM_HIGH);

  outputConv.mode = inputConv.mode;
  outputConv.clockPeriod  = inputConv.clockPeriod;
  outputConv.sclkFrequency  = inputConv.sclkFrequency;
  outputConv.Sclk  = inputConv.Sclk;
  outputConv.numOfChannels = numOfChannelsEnum'(inputConv.numOfChannels);
  outputConv.clockratefrequency = clockrateFrequencyEnum'(inputConv.clockratefrequency);
outputConv.wordSelectPeriod = wordSelectPeriodEnum'(inputConv.wordSelectPeriod);

//  outputConv.delayFortxSd  = inputConv.delayFortxSd;
//  outputConv.delayFortxWs  = inputConv.delayFortxWs;

endfunction: fromTransmitterClass
  
 
function void I2sTransmitterConfigConverter::do_print(uvm_printer printer);
  
  i2sTransferCfgStruct ConfigStruct;
  
  printer.print_field("mode",ConfigStruct.mode,$bits(ConfigStruct.mode),UVM_STRING);
  printer.print_field("clockPeriod",ConfigStruct.clockPeriod,$bits(ConfigStruct.clockPeriod),UVM_DEC);
  printer.print_field("sclkFrequency",ConfigStruct.sclkFrequency,$bits(ConfigStruct.sclkFrequency),UVM_DEC);
  printer.print_field("clockratefrequency",ConfigStruct.clockratefrequency,$bits(ConfigStruct.clockratefrequency),UVM_DEC);
  printer.print_field ("Sclk",ConfigStruct.Sclk, $bits(ConfigStruct.Sclk), UVM_DEC);
  printer.print_field("numOfChannels",ConfigStruct.numOfChannels, $bits(ConfigStruct.numOfChannels), UVM_DEC);
   printer.print_field("wordSelectPeriod",ConfigStruct.wordSelectPeriod, $bits(ConfigStruct.wordSelectPeriod), UVM_DEC);

//  printer.print_field("delayFortxSd",ConfigStruct.delayFortxSd,$bits(ConfigStruct.delayFortxSd),UVM_DEC);
//  printer.print_field("delayFortxWs",ConfigStruct.delayFortxWs,$bits(ConfigStruct.delayFortxWs),UVM_DEC);

endfunction : do_print
 
`endif
