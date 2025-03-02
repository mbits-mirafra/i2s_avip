`ifndef I2STRANSMITTERCOVERAGE_INCLUDED_
`define I2STRANSMITTERCOVERAGE_INCLUDED_
 
class I2sTransmitterCoverage extends uvm_subscriber#(I2sTransmitterTransaction);
`uvm_component_utils(I2sTransmitterCoverage)
 
  I2sTransmitterTransaction i2sTransmitterTransaction;


   covergroup i2sTransmitterTransactionCovergroup with function sample (I2sTransmitterTransaction i2sTransmitterTransaction);
  option.per_instance = 1;

   WORDSELECT_TX_CP : coverpoint i2sTransmitterTransaction.txWs {
   option.comment = "Word Select";
   bins WORDSELECT_LEFT                              = {1}; 
   bins WORDSELECT_RIGHT                             = {0};
   }

   SERIALCLOCK_TX_CP : coverpoint i2sTransmitterTransaction.txSclk {
   option.comment = "serial clock";
   bins SCLK_CHANGE                             = {0,1}; 
     }

  
SERIALDATARANGE_0_CP : coverpoint i2sTransmitterTransaction.txSd[0] {
  option.comment = "serial data value range ";
  bins SD_0_LOW_VALID_RANGE = {[0:50]};
  bins SD_0_MID_VALID_RANGE = {[51:200]};
  bins SD_0_HIGH_VALID_RANGE = {[201:255]}; 
 }
SERIALDATARANGE_1_CP : coverpoint i2sTransmitterTransaction.txSd[1] {
  option.comment = "serial data value range ";
  bins SD_1_LOW_VALID_RANGE = {[0:50]};
  bins SD_1_MID_VALID_RANGE = {[51:200]};
  bins SD_1_HIGH_VALID_RANGE = {[201:255]};
 }

SERIALDATARANGE_2_CP : coverpoint i2sTransmitterTransaction.txSd[2] {
  option.comment = "serial data value range ";
  bins SD_2_LOW_VALID_RANGE = {[0:50]};
  bins SD_2_MID_VALID_RANGE = {[51:200]};
  bins SD_2_HIGH_VALID_RANGE = {[201:255]};
 }

SERIALDATARANGE_3_CP : coverpoint i2sTransmitterTransaction.txSd[3] {
  option.comment = "serial data value range ";
  bins SD_3_LOW_VALID_RANGE = {[0:50]};
  bins SD_3_MID_VALID_RANGE = {[51:200]};
  bins SD_3_HIGH_VALID_RANGE = {[201:255]};
 }

NUMOFBITSTRANSFER_TX_CP : coverpoint i2sTransmitterTransaction.txNumOfBitsTransfer {
  option.comment = "num of bits transfer";
  bins BITS_8  = {8};
  bins BITS_16 = {16};
  bins BITS_24 = {24};
  bins BITS_32 = {32};
}

NUMOFBITSTRANSFER_TX_X_WORD_SELECT_TX_CP:cross NUMOFBITSTRANSFER_TX_CP,WORDSELECT_TX_CP;
  
endgroup


  extern function new(string name = "I2sTransmitterCoverage", uvm_component parent = null);
  extern virtual function void display();
  extern virtual function void write(I2sTransmitterTransaction t);
  extern virtual function void report_phase(uvm_phase phase);
 
endclass : I2sTransmitterCoverage
 
 
function I2sTransmitterCoverage::new(string name = "I2sTransmitterCoverage", uvm_component parent = null);
  super.new(name, parent);
  i2sTransmitterTransactionCovergroup=new();
endfunction : new
 
 
function void  I2sTransmitterCoverage::display();  
  $display("");
  $display("--------------------------------------");
  $display(" COVERAGE");
  $display("--------------------------------------");
  $display("");
endfunction : display
 
 
function void I2sTransmitterCoverage::write(I2sTransmitterTransaction t);
  `uvm_info(get_type_name(), $sformatf("Before Calling the Sample Method"),UVM_HIGH); 
   i2sTransmitterTransactionCovergroup.sample(t);
  `uvm_info(get_type_name(), $sformatf("After Calling the Sample Method"),UVM_HIGH);
endfunction: write
 
function void I2sTransmitterCoverage::report_phase(uvm_phase phase);
display(); 

`uvm_info(get_type_name(),$sformatf("I2s Transmitter Coverage  = %0.2f %%", i2sTransmitterTransactionCovergroup.get_coverage()), UVM_NONE);

endfunction: report_phase
`endif



