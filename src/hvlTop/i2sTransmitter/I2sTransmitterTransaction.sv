`ifndef I2STRANSMITTERTRANSACTION_INCLUDED_
`define I2STRANSMITTERTRANSACTION_INCLUDED_


class I2sTransmitterTransaction extends uvm_sequence_item;
  `uvm_object_utils(I2sTransmitterTransaction)

   rand bit txWs;
   rand bit txSclk;
   rand bit[DATA_WIDTH-1:0] txSd[]; 
   rand numOfBitsTransferEnum txNumOfBitsTransfer;
   rand wordSelectPeriodEnum txWordSelectPeriod;
   rand clockrateFrequencyEnum clockrateFrequency;

   constraint txSdSize{soft txSd.size() == txNumOfBitsTransfer/DATA_WIDTH; }

  extern function new(string name = "I2sTransmitterTransaction");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, 
                            uvm_comparer comparer); 
 extern function void do_print(uvm_printer printer);
 

endclass : I2sTransmitterTransaction

function I2sTransmitterTransaction::new(string name = "I2sTransmitterTransaction");
  super.new(name);
endfunction : new


function void I2sTransmitterTransaction::do_copy (uvm_object rhs);
  I2sTransmitterTransaction i2sTransmitterTransactionCopyObj;
  
  if(!$cast(i2sTransmitterTransactionCopyObj,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);

  txWs = i2sTransmitterTransactionCopyObj.txWs;
  txSclk = i2sTransmitterTransactionCopyObj.txSclk;
  txSd = i2sTransmitterTransactionCopyObj.txSd;
  txNumOfBitsTransfer = i2sTransmitterTransactionCopyObj.txNumOfBitsTransfer;
  txWordSelectPeriod = i2sTransmitterTransactionCopyObj.txWordSelectPeriod;
  clockrateFrequency = i2sTransmitterTransactionCopyObj.clockrateFrequency;

endfunction : do_copy

function bit  I2sTransmitterTransaction::do_compare (uvm_object rhs,uvm_comparer comparer);
  I2sTransmitterTransaction i2sTransmitterTransactionCopyObj;

  if(!$cast(i2sTransmitterTransactionCopyObj,rhs)) begin
  `uvm_fatal("FATAL_I2S_TRANSMITTER_SEQ_ITEM_DO_COMPARE_FAILED","cast of the rhs object failed")
  return 0;
  end

  return super.do_compare(rhs,comparer) &&
  txWs == i2sTransmitterTransactionCopyObj.txWs &&
  txSclk == i2sTransmitterTransactionCopyObj.txSclk &&
  txSd == i2sTransmitterTransactionCopyObj.txSd &&
  txNumOfBitsTransfer == i2sTransmitterTransactionCopyObj.txNumOfBitsTransfer &&
  txWordSelectPeriod == i2sTransmitterTransactionCopyObj.txWordSelectPeriod && 
  clockrateFrequency == i2sTransmitterTransactionCopyObj.clockrateFrequency;
  endfunction : do_compare 


function void I2sTransmitterTransaction::do_print(uvm_printer printer);
  super.do_print(printer);

  printer.print_field($sformatf("WORD SELECT"),this.txWs,1,UVM_DEC);

  foreach(txSd[i]) begin
  printer.print_field($sformatf("SERIALDATA[%0d]",i),this.txSd[i],$bits(txSd[i]),UVM_BIN);
  end

 // printer.print_field($sformatf("SERIAL_CLK"),this.txSclk,$bits(txSclk),UVM_DEC);
  printer.print_field($sformatf("WORD_SELECT_PERIOD"),this.txWordSelectPeriod,$bits(txWordSelectPeriod),UVM_DEC);
  // printer.print_field($sformatf("NO_OF_BITS_TRANSFER"),this.txNumOfBitsTransfer,$bits(txNumOfBitsTransfer),UVM_DEC);
//  printer.print_field($sformatf("clock rate Frequency"),this.clockrateFrequency,$bits(clockrateFrequency),UVM_DEC);

endfunction : do_print


`endif

