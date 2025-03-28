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
    `uvm_info("I2sReceiverSeqItemConverter",$sformatf("After converting from Receiver Class ws =  %0d",outputConv.ws),UVM_HIGH);
 
    
    outputConv.numOfBitsTransfer = numOfBitsTransferEnum'(inputConv.rxNumOfBitsTransfer);
    `uvm_info("I2sReceiverSeqItemConverter",$sformatf("After converting from Receiver Class numOfBitsTransfer =  %0d",outputConv.numOfBitsTransfer),UVM_HIGH);
    
  for(int i=0; i<inputConv.rxSdLeftChannel.size();i++) begin
    outputConv.sdLeftChannel[i] = inputConv.rxSdLeftChannel[i];   
    `uvm_info("I2sReceiverSeqItemConverter",$sformatf(" After converting from Receiver Class Left Channel Serial Data= %0b",outputConv.sdLeftChannel[i]),UVM_LOW)
  end
 
 for(int i=0; i<inputConv.rxSdRightChannel.size();i++) begin
    outputConv.sdRightChannel[i] = inputConv.rxSdRightChannel[i];   
    `uvm_info("I2sReceiverSeqItemConverter",$sformatf(" After converting from Receiver Class Right Channel Serial Data= %0b",outputConv.sdRightChannel[i]),UVM_LOW)
  end

endfunction: fromReceiverClass
 
 
function void I2sReceiverSeqItemConverter::toReceiverClass(input i2sTransferPacketStruct inputConv,
       output I2sReceiverTransaction outputConv);
  outputConv = new();
 
   outputConv.rxWs = inputConv.ws;
    `uvm_info("I2sReceiverSeqItemConverter",$sformatf("After converting to ReceiverClass ws =%0d",outputConv.rxWs),UVM_HIGH);
 
    
     outputConv.rxNumOfBitsTransfer = numOfBitsTransferEnum'(inputConv.numOfBitsTransfer);
    `uvm_info("I2sReceiverSeqItemConverter",$sformatf("After converting to Receiver Class numOfBitsTransfer =  %0d",outputConv.rxNumOfBitsTransfer),UVM_HIGH);
     outputConv.rxSdLeftChannel = inputConv.sdLeftChannel;   
    `uvm_info("I2sReceiverSeqItemConverter",$sformatf(" After converting to Receiver Class Left Channel Serial Data= %p",outputConv.rxSdLeftChannel),UVM_NONE) 
     outputConv.rxSdRightChannel = inputConv.sdRightChannel;   
    `uvm_info("I2sReceiverSeqItemConverter",$sformatf(" After converting to Receiver Class Right Channel Serial Data= %p",outputConv.rxSdRightChannel),UVM_NONE) 

  
endfunction: toReceiverClass
 
 
function void I2sReceiverSeqItemConverter::do_print(uvm_printer printer);
  i2sTransferPacketStruct ReceiverPacketStruct;
  super.do_print(printer);
   printer.print_field("numOfBitsTransfer",ReceiverPacketStruct.numOfBitsTransfer,$bits(ReceiverPacketStruct.numOfBitsTransfer),UVM_DEC);
   printer.print_field("ws",ReceiverPacketStruct.ws,$bits(ReceiverPacketStruct.ws),UVM_DEC);
   foreach(ReceiverPacketStruct.sdLeftChannel[i]) begin
    printer.print_field($sformatf("Left Channel serial_data[%0d]=%b",i,ReceiverPacketStruct.sdLeftChannel[i]),$bits(ReceiverPacketStruct.sdLeftChannel),UVM_DEC);
  end 

  foreach(ReceiverPacketStruct.sdRightChannel[i]) begin
    printer.print_field($sformatf("Right Channel serial_data[%0d]=%b",i,ReceiverPacketStruct.sdRightChannel[i]),$bits(ReceiverPacketStruct.sdRightChannel),UVM_DEC);
  end  
  endfunction : do_print
 
`endif
