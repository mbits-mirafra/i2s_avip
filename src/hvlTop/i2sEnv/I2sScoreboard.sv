`ifndef I2SSCOREBOARD_INCLUDED_
`define I2SSCOREBOARD_INCLUDED_

class I2sScoreboard extends uvm_component;
 `uvm_component_utils(I2sScoreboard)

  I2sTransmitterTransaction i2sTransmitterTransaction;
  I2sReceiverTransaction i2sReceiverTransaction;
  I2sEnvConfig i2sEnvConfig;

  uvm_tlm_analysis_fifo#(I2sTransmitterTransaction)i2sTransmitterAnalysisFIFO;
  uvm_tlm_analysis_fifo#(I2sReceiverTransaction)i2sReceiverAnalysisFIFO;

  extern function new(string name = "I2sScoreboard", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void check_phase (uvm_phase phase);
endclass : I2sScoreboard


function I2sScoreboard::new(string name = "I2sScoreboard",
                                 uvm_component parent = null);
  super.new(name, parent);
  i2sTransmitterAnalysisFIFO=new("i2sTransmitterAnalysisFIFO",this);
  i2sReceiverAnalysisFIFO=new("i2sReceiverAnalysisFIFO",this);
endfunction : new

function void I2sScoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_full_name(),"Inside i2s sb build phase",UVM_NONE)
endfunction : build_phase

function void I2sScoreboard::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
  `uvm_info(get_full_name(),"Inside i2s sb connect phase",UVM_NONE)
endfunction : connect_phase

task I2sScoreboard::run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info(get_full_name(),"Inside i2s sb run phase",UVM_NONE)
  
endtask : run_phase

function void I2sScoreboard::check_phase(uvm_phase phase);
  super.check_phase(phase);
  `uvm_info(get_full_name(),"Inside i2s sb check phase",UVM_NONE)
  `uvm_info(get_type_name(),$sformatf("--\n--------SCOREBOARD CHECK PHASE----------------"),UVM_HIGH) 

endfunction : check_phase

`endif

