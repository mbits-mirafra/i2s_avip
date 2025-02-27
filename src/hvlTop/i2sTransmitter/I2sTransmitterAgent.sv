`ifndef I2STRANSMITTERAGENT_INCLUDED_
`define I2STRANSMITTERAGENT_INCLUDED_

class I2sTransmitterAgent extends uvm_component;
  `uvm_component_utils(I2sTransmitterAgent)

  I2sTransmitterAgentConfig i2sTransmitterAgentConfig;
  I2sTransmitterMonitorProxy i2sTransmitterMonitorProxy;
  I2sTransmitterSequencer i2sTransmitterSequencer;
  I2sTransmitterDriverProxy i2sTransmitterDriverProxy;
  I2sTransmitterCoverage i2sTransmitterCoverage;

  extern function new(string name = "I2sTransmitterAgent", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass : I2sTransmitterAgent

function I2sTransmitterAgent::new(string name = "I2sTransmitterAgent",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new


function void I2sTransmitterAgent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(I2sTransmitterAgentConfig)::get(this,"","I2sTransmitterAgentConfig",i2sTransmitterAgentConfig))
  `uvm_fatal("config","cannot get the config m_cfg from uvm_config_db. Have u set it ?")
    
  i2sTransmitterMonitorProxy=I2sTransmitterMonitorProxy::type_id::create("i2sTransmitterMonitorProxy",this);
  
  if(i2sTransmitterAgentConfig.isActive==UVM_ACTIVE)
    
    begin
      i2sTransmitterDriverProxy=I2sTransmitterDriverProxy::type_id::create("i2sTransmitterDriverProxy",this);
      i2sTransmitterSequencer=I2sTransmitterSequencer::type_id::create("i2sTransmitterSequencer",this);
    end

  if(i2sTransmitterAgentConfig.hasCoverage)
   begin
    i2sTransmitterCoverage=I2sTransmitterCoverage::type_id::create("i2sTransmitterCoverage",this);
  end

  uvm_config_db#(I2sTransmitterAgentConfig)::set(uvm_root::get(), "*","I2sTransmitterAgentConfig",i2sTransmitterAgentConfig);
    `uvm_info(get_type_name(), $sformatf("\nI2S_TRANSMITTER_AGENT_CONFIG\n%s",
                 i2sTransmitterAgentConfig.sprint()),UVM_LOW);
endfunction : build_phase


function void I2sTransmitterAgent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(i2sTransmitterAgentConfig.isActive==UVM_ACTIVE)
    begin
     i2sTransmitterDriverProxy.i2sTransmitterAgentConfig=i2sTransmitterAgentConfig;
      i2sTransmitterSequencer.i2sTransmitterAgentConfig=i2sTransmitterAgentConfig;
      i2sTransmitterDriverProxy.seq_item_port.connect(i2sTransmitterSequencer.seq_item_export);
  end                                                                                               
                                                                                                       
  if(i2sTransmitterAgentConfig.hasCoverage) 
   begin                                                         
    i2sTransmitterMonitorProxy.i2sTransmitterAnalysisPort.connect(i2sTransmitterCoverage.analysis_export);
  end                                                                                               
  i2sTransmitterMonitorProxy.i2sTransmitterAgentConfig = i2sTransmitterAgentConfig; 

endfunction : connect_phase


`endif
