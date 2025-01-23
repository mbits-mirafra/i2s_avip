`ifndef I2SRECEIVERTRANSACTION_INCLUDED_
`define I2SRECEIVERTRANSACTION_INCLUDED_

class I2sReceiverTransaction extends uvm_sequence_item;
  `uvm_object_utils(I2sReceiverTransaction)

  // rand bit WS;
   //rand data_width_e DATA_WIDTH;
   //rand bit[DATA_WIDTH-1:0]SD[];   //sdi=SD
   //rand  word_select_period_e WORD_SELECT_PERIOD;
   //I2S AUDIO FORMAT


  //-------------------------------------------------------
  // Constraints for I2S
  //-------------------------------------------------------
  
 // constraint serial_data{DATA_WIDTH <= (WORD_SELECT_PERIOD)/2;}


  extern function new(string name = "I2sReceiverTransaction");
  //extern function void do_copy(uvm_object rhs);
 // extern function bit do_compare(uvm_object rhs, 
                            //uvm_comparer comparer); 
  //extern function void do_print(uvm_printer printer);
 

endclass : I2sReceiverTransaction

function I2sReceiverTransaction::new(string name = "I2sReceiverTransaction");
  super.new(name);
endfunction : new

/*function void I2sReceiverTransaction::do_copy (uvm_object rhs);
  I2sReceiverTransaction receiver_rhs;
  
  if(!$cast(receiver_rhs,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);

  WS = receiver_rhs.WS;
  SD = receiver_rhs.SD;
  //operation = receiver_rhs.operation;

endfunction : do_copy*/

/*function bit  I2sReceiverTransaction::do_compare (uvm_object rhs,uvm_comparer comparer);
  I2sReceiverTransaction receiver_rhs;

  if(!$cast(receiver_rhs,rhs)) begin
  `uvm_fatal("FATAL_I2sReceiverTransaction_DO_COMPARE_FAILED","cast of the rhs object failed")
  return 0;
  end

  return super.do_compare(rhs,comparer) &&
  WS == receiver_rhs.WS &&
  SD == receiver_rhs.SD; 
  //&& operation == receiver_rhs.operation;
endfunction : do_compare */


/*function void I2sReceiverTransaction::do_print(uvm_printer printer);
  super.do_print(printer);

  printer.print_field($sformatf("WORD SELECT"),this.WS,1,UVM_HEX);

  foreach(SD[i]) begin
  printer.print_field($sformatf("SERIALDATA[%0d]",i),this.SD[i],$bits(SD[i]),UVM_HEX);
  end

  printer.print_field($sformatf("DATA_WIDTH"),this.DATA_WIDTH,$bits(DATA_WIDTH),UVM_HEX);
  printer.print_field($sformatf("WORD_SELECT_PERIOD"),this.WORD_SELECT_PERIOD,$bits(WORD_SELECT_PERIOD),UVM_HEX);

endfunction : do_print*/


`endif

