`ifndef I2STRANSMITTERSEQITEMCONVERTER_INCLUDED_
`define I2STRANSMITTERSEQITEMCONVERTER_INCLUDED_

class I2sTransmitterSeqItemConverter extends uvm_object;
  
  extern function new(string name = "I2sTransmitterSeqItemConverter");
  extern static function void fromTransmitterClass(input I2sTransmitterTransaction inputConv,
                                         output i2sTransferPacketStruct outputConv);

   extern static function void toTransmitterClass(input i2sTransferPacketStruct inputConv,     
                                      output I2sTransmitterTransaction outputConv);
  extern function void do_print(uvm_printer printer);  
endclass : I2sTransmitterSeqItemConverter

function I2sTransmitterSeqItemConverter::new(string name = "I2sTransmitterSeqItemConverter");
  super.new(name);
endfunction : new


function void I2sTransmitterSeqItemConverter::fromTransmitterClass(input I2sTransmitterTransaction inputConv,
         output i2sTransferPacketStruct outputConv);

  `uvm_info("I2sTransmitterSeqItemConverter",$sformatf("----------------------------------------------------------------------"),UVM_NONE);

    outputConv.ws = inputConv.txWs;
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf("After converting from_TransmitterClass ws =  %0d",outputConv.ws),UVM_NONE);

     outputConv.numOfBitsTransfer = numOfBitsTransferEnum'(inputConv.txNumOfBitsTransfer);
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf("After converting from_TransmitterClass numOfBitsTransfer =  %0d",outputConv.numOfBitsTransfer),UVM_NONE);
    
    for(int i=0; i<inputConv.txSdLeftChannel.size();i++) begin
    outputConv.sdLeftChannel[i] = inputConv.txSdLeftChannel[i];   
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf(" After converting from_TransmitterClass Left Channel Serial Data[%0d]= %p",i,outputConv.sdLeftChannel[i]),UVM_NONE)
  end
   for(int i=0; i<inputConv.txSdRightChannel.size();i++) begin
    outputConv.sdRightChannel[i] = inputConv.txSdRightChannel[i];   
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf(" After converting from_TransmitterClass Right Channel Serial Data[%0d]= %p",i,outputConv.sdRightChannel[i]),UVM_NONE)

  end

endfunction: fromTransmitterClass 


function void I2sTransmitterSeqItemConverter::toTransmitterClass(input i2sTransferPacketStruct inputConv,
       output I2sTransmitterTransaction outputConv);
  outputConv = new();

   outputConv.txWs = inputConv.ws;
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf("After converting toTransmitterClass ws=  %0d",outputConv.txWs),UVM_NONE);
 
    outputConv.txNumOfBitsTransfer = numOfBitsTransferEnum'(inputConv.numOfBitsTransfer);
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf("After converting toTransmitterClassnumOfBitsTransfer =  %0d",outputConv.txNumOfBitsTransfer),UVM_NONE);

    outputConv.txSdLeftChannel = inputConv.sdLeftChannel;   
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf(" After converting to_TransmitterClass Left Channel Serial Data= %p",outputConv.txSdLeftChannel),UVM_NONE)  
   
   outputConv.txSdRightChannel = inputConv.sdRightChannel;   
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf(" After converting to_TransmitterClass Right Channel Serial Data= %p",outputConv.txSdRightChannel),UVM_NONE)
  
endfunction: toTransmitterClass


function void I2sTransmitterSeqItemConverter::do_print(uvm_printer printer);
  i2sTransferPacketStruct TransmitterPacketStruct;
  super.do_print(printer);

   printer.print_field("ws",TransmitterPacketStruct.ws,$bits(TransmitterPacketStruct.ws),UVM_DEC);
   printer.print_field("numOfBitsTransfer",TransmitterPacketStruct.numOfBitsTransfer,$bits(TransmitterPacketStruct.numOfBitsTransfer),UVM_DEC);
  foreach(TransmitterPacketStruct.sdLeftChannel[i]) begin
    printer.print_field($sformatf("Left channel serial_data[%0d]=%0b",i,TransmitterPacketStruct.sdLeftChannel[i]),$bits(TransmitterPacketStruct.sdLeftChannel),UVM_DEC);
  end

   foreach(TransmitterPacketStruct.sdRightChannel[i]) begin
    printer.print_field($sformatf("Right channel serial_data[%0d]=%0b",i,TransmitterPacketStruct.sdRightChannel[i]),$bits(TransmitterPacketStruct.sdRightChannel),UVM_DEC);
  end

  endfunction : do_print

`endif
