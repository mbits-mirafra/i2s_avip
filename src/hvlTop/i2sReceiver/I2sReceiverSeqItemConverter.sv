`ifndef I2SRECEIVERSEQITEMCONVERTER_INCLUDED_
`define I2SRECEIVERSEQITEMCONVERTER_INCLUDED_

class I2sReceiverSeqItemConverter extends uvm_object;
  extern function new(string name = "I2sReceiverSeqItemConverter");
  extern static function void fromReceiverClass(input I2sReceiverTransaction inputConv,
                                                 output i2sTransferPacketStruct outputConv);
 
  extern static function void toReceiverClass(input i2sTransferPacketStruct inputConv,     
                                               output I2sReceiverTransaction outputConv);
  extern function void do_print(uvm_printer printer);  
endclass : I2sReceiverSeqItemConverter
 
function I2sReceiverSeqItemConverter::new(string name = "I2sReceiverSeqItemConverter");
  super.new(name);
endfunction : new
 
 
function void I2sReceiverSeqItemConverter::fromReceiverClass(input I2sReceiverTransaction inputConv,
                                                              output i2sTransferPacketStruct outputConv);
 
  `uvm_info("I2sReceiverSeqItemConverter",$sformatf("----------------------------------------------------------------------"),UVM_HIGH);
 
    outputConv.ws = inputConv.rxWs;
    `uvm_info("I2sReceiverSeqItemConverter",$sformatf("After converting fromReceiverClass ws =  %0h",outputConv.ws),UVM_HIGH);
 
    outputConv.sclk = inputConv.rxSclk;
    `uvm_info("I2sReceiverSeqItemConverter",$sformatf("After converting fromReceiverClass sclk =  %0h",outputConv.sclk),UVM_HIGH);

    outputConv.numOfBitsTransfer = numOfBitsTransferEnum'(inputConv.rxNumOfBitsTransfer);
    `uvm_info("I2sReceiverSeqItemConverter",$sformatf("After converting fromReceiverClass numOfBitsTransfer =  %0d",outputConv.numOfBitsTransfer),UVM_HIGH);

    outputConv.wordSelectPeriod = wordSelectPeriodEnum'(inputConv.rxWordSelectPeriod);
    `uvm_info("I2sReceiverSeqItemConverter",$sformatf("After converting fromReceiverClass wordSelectPeriod =  %0d",outputConv.wordSelectPeriod),UVM_HIGH);

    outputConv.clockratefrequency = clockrateFrequencyEnum'(inputConv.clockrateFrequency);
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf("After converting fromReceiverClass clockrateFrequency =  %0d",outputConv.clockratefrequency),UVM_HIGH);

  for(int i=0; i<inputConv.rxSd.size();i++) begin
    outputConv.sd[i] = inputConv.rxSd[i];   
    `uvm_info("I2sReceiverSeqItemConverter",$sformatf(" After converting fromReceiverClass Serial Data= %0b",outputConv.sd[i]),UVM_LOW)
  end
 
endfunction: fromReceiverClass
 
 
function void I2sReceiverSeqItemConverter::toReceiverClass(input i2sTransferPacketStruct inputConv,
       output I2sReceiverTransaction outputConv);
  outputConv = new();
 
   outputConv.rxWs = inputConv.ws;
    `uvm_info("I2sReceiverSeqItemConverter",$sformatf("After converting toReceiverClass ws =%0d",outputConv.rxWs),UVM_HIGH);
 
     outputConv.rxSclk = inputConv.sclk;
    `uvm_info("I2sReceiverSeqItemConverter",$sformatf("After converting toReceiverClass sclk =%0d",outputConv.rxSclk),UVM_HIGH);

     outputConv.rxNumOfBitsTransfer = numOfBitsTransferEnum'(inputConv.numOfBitsTransfer);
    `uvm_info("I2sReceiverSeqItemConverter",$sformatf("After converting toReceiverClassnumOfBitsTransfer =  %0d",outputConv.rxNumOfBitsTransfer),UVM_HIGH);
     outputConv.clockrateFrequency = clockrateFrequencyEnum'(inputConv.clockratefrequency);
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf("After converting toReceiverClass clockrateFrequency =  %0d",outputConv.clockrateFrequency),UVM_NONE);


      outputConv.rxWordSelectPeriod = wordSelectPeriodEnum'(inputConv.wordSelectPeriod);
    `uvm_info("I2sReceiverSeqItemConverter",$sformatf("After converting toReceiverClasswordSelectPeriod =  %0d",outputConv.rxWordSelectPeriod),UVM_HIGH);

     outputConv.rxSd = inputConv.sd;   
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf(" After converting to_TransmitterClass Serial Data= %p",outputConv.rxSd),UVM_NONE) 
     
  
endfunction: toReceiverClass
 
 
function void I2sReceiverSeqItemConverter::do_print(uvm_printer printer);
  i2sTransferPacketStruct ReceiverPacketStruct;
  super.do_print(printer);
 
  printer.print_field("ws",ReceiverPacketStruct.ws,$bits(ReceiverPacketStruct.ws),UVM_DEC);
  printer.print_field("sclk",ReceiverPacketStruct.sclk,$bits(ReceiverPacketStruct.sclk),UVM_DEC);
  printer.print_field("wordSelectPeriod",ReceiverPacketStruct.wordSelectPeriod,$bits(ReceiverPacketStruct.wordSelectPeriod),UVM_DEC);
  printer.print_field("clockratefrequency",ReceiverPacketStruct.clockratefrequency,$bits(ReceiverPacketStruct.clockratefrequency),UVM_DEC);
  printer.print_field("numOfBitsTransfer",ReceiverPacketStruct.numOfBitsTransfer,$bits(ReceiverPacketStruct.numOfBitsTransfer),UVM_DEC);
  foreach(ReceiverPacketStruct.sd[i]) begin
    printer.print_field($sformatf("serial_data[%0d]=%b",i,ReceiverPacketStruct.sd[i]),$bits(ReceiverPacketStruct.sd),UVM_DEC);
  end  
  endfunction : do_print
 
`endif
