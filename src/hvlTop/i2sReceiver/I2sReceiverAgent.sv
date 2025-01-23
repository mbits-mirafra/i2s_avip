`ifndef I2SRECEIVERAGENT_INCLUDED_
`define I2SRECEIVERAGENT_INCLUDED_

class I2sReceiverAgent extends uvm_component;
  `uvm_component_utils(I2sReceiverAgent)

  I2sReceiverAgentConfig i2sReceiverAgentConfig;
  
  I2sReceiverMonitorProxy i2sReceiverMonitorProxy;
  I2sReceiverSequencer i2sReceiverSequencer;
  I2sReceiverDriverProxy i2sReceiverDriverProxy;
  I2sReceiverCoverage i2sReceiverCoverage;

  extern function new(string name = "I2sReceiverAgent",uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass : I2sReceiverAgent


function I2sReceiverAgent::new(string name = "I2sReceiverAgent",uvm_component parent = null);
  super.new(name, parent);
endfunction : new


function void I2sReceiverAgent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  //if(!uvm_config_db #(I2sReceiverAgent_config)::get(this,"","I2sReceiverAgent_config",I2sReceiverAgent_cfg_h))
    //`uvm_fatal("CONFIG","cannot get() the I2sReceiverAgent_cfg_h from the uvm_config_db. have you set it?")
    
  i2sReceiverMonitorProxy=I2sReceiverMonitorProxy::type_id::create("i2sReceiverMonitorProxy",this);

 // if(I2sReceiverAgent_cfg_h.isActive==UVM_ACTIVE)
  begin
    i2sReceiverDriverProxy=I2sReceiverDriverProxy::type_id::create("i2sReceiverDriverProxy",this);
    i2sReceiverSequencer=I2sReceiverSequencer::type_id::create("i2sReceiverSequencer",this);
      
  end

  //if(I2sReceiverAgent_cfg_h.hasCoverage)
    begin
    i2sReceiverCoverage=I2sReceiverCoverage::type_id::create("i2sReceiverCoverage",this);
  end
endfunction : build_phase


function void I2sReceiverAgent::connect_phase(uvm_phase phase);

 // if(I2sReceiverAgent_cfg_h.isActive==UVM_ACTIVE)
  begin
    i2sReceiverDriverProxy.i2sReceiverAgentConfig=i2sReceiverAgentConfig;
    i2sReceiverSequencer.i2sReceiverAgentConfig=i2sReceiverAgentConfig;
    i2sReceiverDriverProxy.seq_item_port.connect(i2sReceiverSequencer.seq_item_export);
  end

  i2sReceiverMonitorProxy.i2sReceiverAgentConfig=i2sReceiverAgentConfig;
  
  //iif(I2sReceiverAgent_cfg_h.hasCoverage) 
    begin                                                         
    i2sReceiverMonitorProxy.i2sReceiverAnalysisPort.connect(i2sReceiverCoverage.analysis_export);
  end  
endfunction : connect_phase

`endif
