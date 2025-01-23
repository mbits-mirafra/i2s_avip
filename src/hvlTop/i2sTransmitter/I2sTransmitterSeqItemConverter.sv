`ifndef I2STRANSMITTERSEQITEMCONVERTER_INCLUDED_
`define I2STRANSMITTERSEQITEMCONVERTER_INCLUDED_

class I2sTransmitterSeqItemConverter extends uvm_object;
  
  extern function new(string name = "I2sTransmitterSeqItemConverter");
 /* extern static function void from_class(input I2sTransmitterTransaction i2sTransmitterTransaction,
                                         output I2sTransferBits i2sTransferBits);

   extern static function void to_class(input I2sTransferBits i2sTransmitterTransaction,     
                                      output I2sTransmitterTransaction i2sTransferBits);
  extern function void do_print(uvm_printer printer);  */
endclass : I2sTransmitterSeqItemConverter

function I2sTransmitterSeqItemConverter::new(string name = "I2sTransmitterSeqItemConverter");
  super.new(name);
endfunction : new


/*function void I2sTransmitterSeqItemConverter::from_class(input I2sTransmitterTransaction i2sTransmitterTransaction,
         output I2sTransferBits i2sTransferBits);

  
  //i2sTransferBits.operation = operationType_e'(i2sTransmitterTransaction.operation);

  i2sTransferBits.WS = i2sTransmitterTransaction.WS;
  //i2sTransferBits.DATA_WIDTH = data_width_e'(i2sTransmitterTransaction.DATA_WIDTH);
  //i2sTransferBits.WORD_SELECT_PERIOD = word_select_period_e'(i2sTransmitterTransaction.WORD_SELECT_PERIOD);

  for(int i=0; i<i2sTransmitterTransaction.SD.size();i++) begin
    i2sTransferBits.SD[i] = i2sTransmitterTransaction.SD[i];    
  end

endfunction: from_class 


function void I2sTransmitterSeqItemConverter::to_class(input I2sTransferBits i2sTransmitterTransaction,
       output I2sTransmitterTransaction i2sTransferBits);
  i2sTransferBits = new();

  i2sTransferBits.WS = i2sTransmitterTransaction.WS;    
  `uvm_info("master_seq_item_conv_class",$sformatf("To class targetAddress =  %0b",i2sTransferBits.targetAddress),UVM_LOW)
  
  //i2sTransferBits.operation = operationType_e'(i2sTransmitterTransaction.operation);
 
   i2sTransferBits.SD = new[data_width_e'(i2sTransmitterTransaction.DATA_WIDTH)]; //DOUBT

-----------------------------------------------------------------------------------------------------------
  for(int i=0; i<i2sTransmitterTransaction.no_of_i2s_bits_transfer/DATA_WIDTH; i++) begin
  i2sTransferBits.writeData[i] = i2sTransmitterTransaction.writeData[i];
  `uvm_info("master_seq_item_conv_class",
  $sformatf("To class writeData =  %0b",i2sTransferBits.writeData[i]),UVM_LOW)
  end
  ---------------------------------------------------------------------------------------------------

endfunction: to_class


function void I2sTransmitterSeqItemConverter::do_print(uvm_printer printer);
  I2sTransferBits i2s_st;
  super.do_print(printer);

  if(i2s_st.WS) begin
    printer.print_field($sformatf("WORD SELECT"),i2s_st.WS,1,UVM_HEX);
  end
  foreach(i2s_st.SD[i]) begin
    printer.print_field($sformatf("SERIAL_DATA[%0d]",i),i2s_st.SD[i],$bits(SD[i]),UVM_HEX);
  end
endfunction : do_print*/

`endif
