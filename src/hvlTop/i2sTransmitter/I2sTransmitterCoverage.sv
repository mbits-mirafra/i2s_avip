`ifndef I2STRANSMITTERCOVERAGE_INCLUDED_
`define I2STRANSMITTERCOVERAGE_INCLUDED_
 
class I2sTransmitterCoverage extends uvm_subscriber#(I2sTransmitterTransaction);
`uvm_component_utils(I2sTransmitterCoverage)
 
  I2sTransmitterTransaction i2sTransmitterTransaction;
  I2sTransmitterAgentConfig i2sTransmitterAgentConfig;


   covergroup i2sTransmitterTransactionCovergroup with function sample (I2sTransmitterAgentConfig i2sTransmitterAgentConfig,I2sTransmitterTransaction i2sTransmitterTransaction);
  option.per_instance = 1;

   WORDSELECT_TX_CP : coverpoint i2sTransmitterTransaction.txWs {
   option.comment = "Word Select";
   bins WORDSELECT_LEFT                              = {1}; 
   bins WORDSELECT_RIGHT                             = {0};
   }

   NUMOFCHANNELS_TX_CP : coverpoint i2sTransmitterAgentConfig.numOfChannels {
   option.comment = "Number Of Channels";
   bins MONO                              = {1}; 
   bins STEREO                            = {2};
   }

 SERIALCLOCK_TX_CP : coverpoint i2sTransmitterAgentConfig.Sclk{
   option.comment = "serial clock";
   bins SCLK_CHANGE                             = {0,1}; 
     }

  
LEFTCHANNELSERIALDATARANGE_0_CP : coverpoint i2sTransmitterTransaction.txSdLeftChannel[0] {
  option.comment = "left channel serial data value range ";
  bins SD_LEFT_CHANNEL_0_LOW_VALID_RANGE = {[0:50]};
  bins SD_LEFT_CHANNEL_0_MID_VALID_RANGE = {[51:200]};
  bins SD_LEFT_CHANNEL_0_HIGH_VALID_RANGE = {[201:255]}; 
 }
LEFTCHANNELSERIALDATARANGE_1_CP : coverpoint i2sTransmitterTransaction.txSdLeftChannel[1]{
  option.comment = "left channel serial data value range ";
  bins SD_LEFT_CHANNEL_1_LOW_VALID_RANGE = {[0:50]};
  bins SD_LEFT_CHANNEL_1_MID_VALID_RANGE = {[51:200]};
  bins SD_LEFT_CHANNEL_1_HIGH_VALID_RANGE = {[201:255]}; 
}

LEFTCHANNELSERIALDATARANGE_2_CP : coverpoint i2sTransmitterTransaction.txSdLeftChannel[2]{
  option.comment = "left channel serial data value range ";
  bins SD_LEFT_CHANNEL_2_LOW_VALID_RANGE = {[0:50]};
  bins SD_LEFT_CHANNEL_2_MID_VALID_RANGE = {[51:200]};
  bins SD_LEFT_CHANNEL_2_HIGH_VALID_RANGE = {[201:255]};   
}

LEFTCHANNELSERIALDATARANGE_3_CP : coverpoint i2sTransmitterTransaction.txSdLeftChannel[3]{
  option.comment = "left channel serial data value range ";
  bins SD_LEFT_CHANNEL_3_LOW_VALID_RANGE = {[0:50]};
  bins SD_LEFT_CHANNEL_3_MID_VALID_RANGE = {[51:200]};
  bins SD_LEFT_CHANNEL_3_HIGH_VALID_RANGE = {[201:255]};
 }

RIGHTCHANNELSERIALDATARANGE_0_CP : coverpoint i2sTransmitterTransaction.txSdRightChannel[0] {
  option.comment = "right channel serial data value range ";
  bins SD_RIGHT_CHANNEL_0_LOW_VALID_RANGE = {[0:50]};
  bins SD_RIGHT_CHANNEL_0_MID_VALID_RANGE = {[51:200]};
  bins SD_RIGHT_CHANNEL_0_HIGH_VALID_RANGE = {[201:255]}; 
 }
RIGHTCHANNELSERIALDATARANGE_1_CP : coverpoint i2sTransmitterTransaction.txSdRightChannel[1]{
  option.comment = "right channel serial data value range ";
  bins SD_RIGHT_CHANNEL_1_LOW_VALID_RANGE = {[0:50]};
  bins SD_RIGHT_CHANNEL_1_MID_VALID_RANGE = {[51:200]};
  bins SD_RIGHT_CHANNEL_1_HIGH_VALID_RANGE = {[201:255]};
 }

RIGHTCHANNELSERIALDATARANGE_2_CP : coverpoint i2sTransmitterTransaction.txSdRightChannel[2]{
  option.comment = "right channel serial data value range ";
  bins SD_RIGHT_CHANNEL_2_LOW_VALID_RANGE = {[0:50]};
  bins SD_RIGHT_CHANNEL_2_MID_VALID_RANGE = {[51:200]};
  bins SD_RIGHT_CHANNEL_2_HIGH_VALID_RANGE = {[201:255]}; 
}

RIGHTCHANNELSERIALDATARANGE_3_CP : coverpoint i2sTransmitterTransaction.txSdRightChannel[3]{
  option.comment = "right channel serial data value range ";
  bins SD_RIGHT_CHANNEL_3_LOW_VALID_RANGE = {[0:50]};
  bins SD_RIGHT_CHANNEL_3_MID_VALID_RANGE = {[51:200]};
  bins SD_RIGHT_CHANNEL_3_HIGH_VALID_RANGE = {[201:255]}; 
}


NUMOFBITSTRANSFER_TX_CP : coverpoint i2sTransmitterTransaction.txNumOfBitsTransfer{
  option.comment = "Num of Bits Transfer";
  bins BITS_8  = {8};
  bins BITS_16 = {16};
  bins BITS_24 = {24};
  bins BITS_32 = {32};
  illegal_bins BINS_INVALID={[33:$]};
}

CLOCKFREQUENCY_TX_CP : coverpoint i2sTransmitterAgentConfig.clockratefrequency{
  option.comment = "Clock Frequency";

  bins khz_8000={KHZ_8};
  bins khz_16000={KHZ_16};
  bins khz_24000={KHZ_24};
  bins khz_32000={KHZ_32};
  bins khz_48000={KHZ_48};
  bins khz_96000={KHZ_96};
  bins khz_192000={KHZ_192};

}

 WORDSELECTPERIOD_TX_CP : coverpoint i2sTransmitterAgentConfig.wordSelectPeriod{
  option.comment = " WORD SELECT PERIOD";

   bins WS_PERIOD_2_BYTE = {16};
   bins WS_PERIOD_4_BYTE = {32};
   bins WS_PERIOD_6_BYTE = {48};
   bins WS_PERIOD_8_BYTE = {64};
   illegal_bins WS_PERIOD_INVALID= {[65:$]};
}

NUMOFBITSTRANSFER_TX_X_WORD_SELECT_TX_CP:cross NUMOFBITSTRANSFER_TX_CP,WORDSELECT_TX_CP;
  
endgroup


  extern function new(string name = "I2sTransmitterCoverage", uvm_component parent = null);
  extern virtual function void display();
  extern virtual function void build_phase(uvm_phase phase);
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

function void I2sTransmitterCoverage :: build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!( uvm_config_db #(I2sTransmitterAgentConfig)::get(this,"*","I2sTransmitterAgentConfig",this.i2sTransmitterAgentConfig)))
  `uvm_fatal("FATAL Tx AGENT CONFIG IN TX COVERAGE", $sformatf("Failed to get Tx agent config in coverage"))
endfunction : build_phase
 
 
function void I2sTransmitterCoverage::write(I2sTransmitterTransaction t);
  `uvm_info(get_type_name(), $sformatf("Before Calling the Sample Method"),UVM_HIGH); 
   i2sTransmitterTransactionCovergroup.sample(i2sTransmitterAgentConfig,t);
  `uvm_info(get_type_name(), $sformatf("After Calling the Sample Method"),UVM_HIGH);
endfunction: write
 
function void I2sTransmitterCoverage::report_phase(uvm_phase phase);
display(); 
`uvm_info(get_type_name(),$sformatf("I2s Transmitter Coverage  = %0.2f %%", i2sTransmitterTransactionCovergroup.get_coverage()), UVM_NONE);
endfunction: report_phase
`endif


