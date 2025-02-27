class I2sTransmitterSeq extends uvm_sequence #(I2sTransmitterTransaction);
  `uvm_object_utils(I2sTransmitterSeq)

   I2sTransmitterTransaction i2sTransmitterTransaction;

  extern function new(string name = "I2sTransmitterSeq");
  extern virtual task body();
endclass : I2sTransmitterSeq

function I2sTransmitterSeq::new(string name = "I2sTransmitterSeq");
  super.new(name);
endfunction : new

task I2sTransmitterSeq::body();
 i2sTransmitterTransaction =I2sTransmitterTransaction::type_id::create("i2sTransmitterTransaction");
if (i2sTransmitterTransaction == null) begin
            `uvm_error("ITEM_CREATION", "Failed to create transaction item!")
        end
  forever begin
    $display("start of seq");
    start_item(i2sTransmitterTransaction);
   $display("start of seq 2");

    i2sTransmitterTransaction.randomize() with {//mode==0;
                                                txNumOfBitsTransfer==8;
                                                txWordSelectPeriod==16;
                                               };
    
    finish_item(i2sTransmitterTransaction);
  end
endtask:body
    
