`ifndef I2SRECEIVERCOVERAGE_INCLUDED_
`define I2SRECEIVERCOVERAGE_INCLUDED_
class I2sReceiverCoverage extends uvm_subscriber#(I2sReceiverTransaction);
`uvm_component_utils(I2sReceiverCoverage)
  I2sReceiverTransaction i2sReceiverTransaction;
   I2sReceiverAgentConfig i2sReceiverAgentConfig;

 
 
   covergroup i2sReceiverTransactionCovergroup with function sample (I2sReceiverAgentConfig i2sReceiverAgentConfig,I2sReceiverTransaction i2sReceiverTransaction);
  option.per_instance = 1;
 
   WORDSELECT_RX_CP : coverpoint i2sReceiverTransaction.rxWs {
   option.comment = "Word Select";
   bins WORDSELECT_LEFT                              = {1}; 
   bins WORDSELECT_RIGHT                             = {0};
   }

   NUMOFCHANNELS_RX_CP : coverpoint i2sReceiverAgentConfig.numOfChannels {
   option.comment = "Number Of Channels";
   bins MONO                              = {1}; 
   bins STEREO                            = {2};
   }


   SERIALCLOCK_RX_CP : coverpoint i2sReceiverAgentConfig.Sclk{
   option.comment = "serial clock";
   bins SCLK_CHANGE                             = {0,1}; 
     }
 
 
  NUMOFBITSTRANSFER_RX_CP : coverpoint i2sReceiverTransaction.rxNumOfBitsTransfer{
  option.comment = "num of bits transfer";
  bins BITS_8  = {8};
  bins BITS_16 = {16};
  bins BITS_24 = {24};
  bins BITS_32 = {32};
  }

   WORDSELECTPERIOD_RX_CP : coverpoint i2sReceiverAgentConfig.wordSelectPeriod{
  option.comment = " WORD SELECT PERIOD";

   bins WS_PERIOD_2_BYTE = {16};
   bins WS_PERIOD_4_BYTE = {32};
   bins WS_PERIOD_6_BYTE = {48};
   bins WS_PERIOD_8_BYTE = {64};
}


  CLOCKFREQUENCY_RX_CP : coverpoint i2sReceiverAgentConfig.clockratefrequency {
  option.comment = "Clock Frequency";

  bins khz_8000={KHZ_8};
  bins khz_48000={KHZ_48};
  bins khz_96000={KHZ_96};
  bins khz_192000={KHZ_192};
}
 
 NUMOFBITSTRANSFER_RX_CP_X_WORD_SELECT_RX_CP:cross NUMOFBITSTRANSFER_RX_CP,WORDSELECT_RX_CP;
 
endgroup
 
 
  extern function new(string name = "I2sReceiverCoverage", uvm_component parent = null);
  extern virtual function void display();
  extern virtual function void build_phase(uvm_phase phase);  
  extern virtual function void write(I2sReceiverTransaction t);
  extern virtual function void report_phase(uvm_phase phase);
endclass : I2sReceiverCoverage

function I2sReceiverCoverage::new(string name = "I2sReceiverCoverage", uvm_component parent = null);
  super.new(name, parent);
  i2sReceiverTransactionCovergroup=new();
endfunction : new

function void  I2sReceiverCoverage::display();  
  $display("");
  $display("--------------------------------------");
  $display(" COVERAGE");
  $display("--------------------------------------");
  $display("");
endfunction : display


function void I2sReceiverCoverage :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!( uvm_config_db #(I2sReceiverAgentConfig)::get(this,"*","I2sReceiverAgentConfig",this.i2sReceiverAgentConfig)))
  `uvm_fatal("FATAL Rx AGENT CONFIG IN RX COVERAGE", $sformatf("Failed to get Rx agent config in coverage"))
endfunction : build_phase


function void I2sReceiverCoverage::write(I2sReceiverTransaction t);
  `uvm_info(get_type_name(), $sformatf("Before Calling the Sample Method"),UVM_HIGH); 
   i2sReceiverTransactionCovergroup.sample(i2sReceiverAgentConfig,t);
  `uvm_info(get_type_name(), $sformatf("After Calling the Sample Method"),UVM_HIGH);
endfunction: write
function void I2sReceiverCoverage::report_phase(uvm_phase phase);
display();
 
`uvm_info(get_type_name(),$sformatf("I2s Receiver Coverage  = %0.2f %%", i2sReceiverTransactionCovergroup.get_coverage()), UVM_NONE);
 
endfunction: report_phase
`endif
