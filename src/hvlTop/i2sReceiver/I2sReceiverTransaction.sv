`ifndef I2SRECEIVERTRANSACTION_INCLUDED_
`define I2SRECEIVERTRANSACTION_INCLUDED_


class I2sReceiverTransaction extends uvm_sequence_item;
  `uvm_object_utils(I2sReceiverTransaction)

   rand bit rxWs;
   rand bit rxSclk;
   bit[DATA_WIDTH-1:0] rxSd[]; 
   rand numOfBitsTransferEnum rxNumOfBitsTransfer;
   rand wordSelectPeriodEnum rxWordSelectPeriod;
   rand clockrateFrequencyEnum clockrateFrequency;
 
    constraint rxSdSize{soft rxSd.size() == rxNumOfBitsTransfer/DATA_WIDTH; }
  
    
  extern function new(string name = "I2sReceiverTransaction");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer); 
  extern function void do_print(uvm_printer printer);
 

endclass : I2sReceiverTransaction

function I2sReceiverTransaction::new(string name = "I2sReceiverTransaction");
  super.new(name);
endfunction : new


function void I2sReceiverTransaction::do_copy (uvm_object rhs);
  I2sReceiverTransaction i2sReceiverTransactionCopyObj;
  
  if(!$cast(i2sReceiverTransactionCopyObj,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);

  rxWs = i2sReceiverTransactionCopyObj.rxWs;
  rxSclk = i2sReceiverTransactionCopyObj.rxSclk;
  rxSd = i2sReceiverTransactionCopyObj.rxSd;
  rxNumOfBitsTransfer = i2sReceiverTransactionCopyObj.rxNumOfBitsTransfer;
  rxWordSelectPeriod = i2sReceiverTransactionCopyObj.rxWordSelectPeriod;
   clockrateFrequency = i2sReceiverTransactionCopyObj.clockrateFrequency;

endfunction : do_copy

function bit  I2sReceiverTransaction::do_compare (uvm_object rhs,uvm_comparer comparer);
  I2sReceiverTransaction i2sReceiverTransactionCopyObj;

  if(!$cast(i2sReceiverTransactionCopyObj,rhs)) begin
  `uvm_fatal("FATAL_I2S_RECEIVER_SEQ_ITEM_DO_COMPARE_FAILED","cast of the rhs object failed")
  return 0;
  end

  return super.do_compare(rhs,comparer) &&
  rxWs == i2sReceiverTransactionCopyObj.rxWs &&
  rxSclk == i2sReceiverTransactionCopyObj.rxSclk &&
  rxSd == i2sReceiverTransactionCopyObj.rxSd &&
  rxNumOfBitsTransfer == i2sReceiverTransactionCopyObj.rxNumOfBitsTransfer &&
  rxWordSelectPeriod == i2sReceiverTransactionCopyObj.rxWordSelectPeriod &&
  clockrateFrequency == i2sReceiverTransactionCopyObj.clockrateFrequency; 

  endfunction : do_compare 


function void I2sReceiverTransaction::do_print(uvm_printer printer);
  super.do_print(printer);

  printer.print_field($sformatf("WORD SELECT"),this.rxWs,1,UVM_HEX);

  foreach(rxSd[i]) begin
  printer.print_field($sformatf("SERIALDATA[%0d]",i),this.rxSd[i],$bits(rxSd[i]),UVM_BIN);
  end

  printer.print_field($sformatf("SERIAL_CLK"),this.rxSclk,$bits(rxSclk),UVM_HEX);
  printer.print_field($sformatf("WORD_SELECT_PERIOD"),this.rxWordSelectPeriod,$bits(rxWordSelectPeriod),UVM_HEX);
  printer.print_field($sformatf("NO_OF_BITS_TRANSFER"),this.rxNumOfBitsTransfer,$bits(rxNumOfBitsTransfer),UVM_HEX);
 printer.print_field($sformatf("Serial clock rate"),this.clockrateFrequency,$bits(clockrateFrequency),UVM_DEC);

endfunction : do_print


`endif

