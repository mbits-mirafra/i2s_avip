`ifndef I2SENV_INCLUDED_
`define I2SENV_INCLUDED_

class I2sEnv extends uvm_env;
  `uvm_component_utils(I2sEnv)
  
  I2sVirtualSequencer i2sVirtualSequencer; 
  I2sEnvConfig i2sEnvConfig;
  I2sScoreboard i2sScoreboard;
  I2sTransmitterAgent i2sTransmitterAgent;
  I2sReceiverAgent i2sReceiverAgent;

  
  extern function new(string name = "I2sEnv", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass : I2sEnv

function I2sEnv::new(string name = "I2sEnv", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sEnv::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_full_name(),"Inside I2S Env build phase",UVM_NONE)
  
  i2sTransmitterAgent=I2sTransmitterAgent::type_id::create("i2sTransmitterAgent",this);
  i2sReceiverAgent=I2sReceiverAgent::type_id::create("i2sReceiverAgent",this);

  if(!uvm_config_db #(I2sEnvConfig)::get(this,"","I2sEnvConfig",i2sEnvConfig)) begin
    `uvm_fatal("CONFIG","cannot get() the i2sEnvConfig from the uvm_config_db . Have you set it?")
  end
  
  if(i2sEnvConfig.hasVirtualSequencer)begin
    i2sVirtualSequencer=I2sVirtualSequencer::type_id::create("i2sVirtualSequencer",this);
  end 
  
  if(i2sEnvConfig.hasScoreboard)begin
    i2sScoreboard=I2sScoreboard::type_id::create("i2sScoreboard",this);
  end 
endfunction : build_phase

function void I2sEnv::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_full_name(),"Inside I2S Env Connect phase",UVM_NONE)
  if( i2sEnvConfig.hasVirtualSequencer)
  begin
 
      i2sVirtualSequencer.i2sTransmitterSequencer=i2sTransmitterAgent.i2sTransmitterSequencer;
      i2sVirtualSequencer.i2sReceiverSequencer=i2sReceiverAgent.i2sReceiverSequencer;
      i2sTransmitterAgent.i2sTransmitterMonitorProxy.i2sTransmitterAnalysisPort.connect(i2sScoreboard.i2sTransmitterAnalysisFIFO.analysis_export); 
      i2sReceiverAgent.i2sReceiverMonitorProxy.i2sReceiverAnalysisPort.connect(i2sScoreboard.i2sReceiverAnalysisFIFO.analysis_export); 
  end
endfunction : connect_phase

`endif

