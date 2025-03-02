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

     outputConv.clockratefrequency = clockrateFrequencyEnum'(inputConv.clockrateFrequency);
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf("After converting from_TransmitterClassclockrateFrequency =  %0d",outputConv.clockratefrequency),UVM_NONE);


    outputConv.sclk = inputConv.txSclk;
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf("After converting from_TransmitterClass sclk =  %0d",outputConv.sclk),UVM_NONE);
    
 
     outputConv.numOfBitsTransfer = numOfBitsTransferEnum'(inputConv.txNumOfBitsTransfer);
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf("After converting from_TransmitterClass numOfBitsTransfer =  %0d",outputConv.numOfBitsTransfer),UVM_NONE);
     
  
      outputConv.wordSelectPeriod = wordSelectPeriodEnum'(inputConv.txWordSelectPeriod);
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf("After converting from_TransmitterClass wordSelectPeriod =  %0d",outputConv.wordSelectPeriod),UVM_NONE);
      
  for(int i=0; i<inputConv.txSd.size();i++) begin
    outputConv.sd[i] = inputConv.txSd[i];   
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf(" After converting from_TransmitterClass Serial Data[%0d]= %p",i,outputConv.sd[i]),UVM_NONE)
  end

endfunction: fromTransmitterClass 


function void I2sTransmitterSeqItemConverter::toTransmitterClass(input i2sTransferPacketStruct inputConv,
       output I2sTransmitterTransaction outputConv);
  outputConv = new();

   outputConv.txWs = inputConv.ws;
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf("After converting toTransmitterClass ws=  %0h",outputConv.txWs),UVM_NONE);

     outputConv.txSclk = inputConv.sclk;
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf("After converting toTransmitterClass sclk=  %0h",outputConv.txSclk),UVM_NONE);
    
 
    outputConv.txNumOfBitsTransfer = numOfBitsTransferEnum'(inputConv.numOfBitsTransfer);
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf("After converting toTransmitterClassnumOfBitsTransfer =  %0h",outputConv.txNumOfBitsTransfer),UVM_NONE);


   outputConv.clockrateFrequency = clockrateFrequencyEnum'(inputConv.clockratefrequency);
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf("After converting toTransmitterClass  clockrateFrequency =  %0h",outputConv.clockrateFrequency),UVM_NONE);

       
      outputConv.txWordSelectPeriod = wordSelectPeriodEnum'(inputConv.wordSelectPeriod);
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf("After converting toTransmitterClass wordSelectPeriod =  %0h",outputConv.txWordSelectPeriod),UVM_NONE);
      

    outputConv.txSd = inputConv.sd;   
    `uvm_info("I2sTransmitterSeqItemConverter",$sformatf(" After converting to_TransmitterClass Serial Data= %p",outputConv.txSd),UVM_NONE)  

  
endfunction: toTransmitterClass


function void I2sTransmitterSeqItemConverter::do_print(uvm_printer printer);
  i2sTransferPacketStruct TransmitterPacketStruct;
  super.do_print(printer);

   printer.print_field("ws",TransmitterPacketStruct.ws,$bits(TransmitterPacketStruct.ws),UVM_DEC);
  printer.print_field("sclk",TransmitterPacketStruct.sclk,$bits(TransmitterPacketStruct.sclk),UVM_DEC);
  printer.print_field("wordSelectPeriod",TransmitterPacketStruct.wordSelectPeriod,$bits(TransmitterPacketStruct.wordSelectPeriod),UVM_DEC);
  printer.print_field("clockratefrequency",TransmitterPacketStruct.clockratefrequency,$bits(TransmitterPacketStruct.clockratefrequency),UVM_DEC);
  printer.print_field("numOfBitsTransfer",TransmitterPacketStruct.numOfBitsTransfer,$bits(TransmitterPacketStruct.numOfBitsTransfer),UVM_DEC);
  foreach(TransmitterPacketStruct.sd[i]) begin
    printer.print_field($sformatf("serial_data[%0d]=%0b",i,TransmitterPacketStruct.sd[i]),$bits(TransmitterPacketStruct.sd),UVM_DEC);
  end
  endfunction : do_print

`endif
