`ifndef I2STRANSMITTERMONITORPROXY_INCLUDED_
`define I2STRANSMITTERMONITORPROXY_INCLUDED_

class I2sTransmitterMonitorProxy extends uvm_component;
  `uvm_component_utils(I2sTransmitterMonitorProxy)

  I2sTransmitterTransaction i2sTransmitterTransaction;
  I2sTransmitterAgentConfig i2sTransmitterAgentConfig;

  virtual I2sTransmitterMonitorBFM i2sTransmitterMonitorBFM;

  uvm_analysis_port #(I2sTransmitterTransaction)i2sTransmitterAnalysisPort;

  extern function new(string name = "I2sTransmitterMonitorProxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : I2sTransmitterMonitorProxy

function I2sTransmitterMonitorProxy::new(string name = "I2sTransmitterMonitorProxy", uvm_component parent = null);
  super.new(name, parent);
  i2sTransmitterAnalysisPort = new("i2sTransmitterAnalysisPort",this);
   i2sTransmitterTransaction = new();
endfunction : new

function void I2sTransmitterMonitorProxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(virtual I2sTransmitterMonitorBFM)::get(this,"","I2sTransmitterMonitorBFM",i2sTransmitterMonitorBFM))begin
  `uvm_fatal("FATAL_MDP_CANNOT_GET_MASTER_MONITOR_BFM","cannot get () I2sTransmitterMonitorBFM from uvm_config_db")
  end
endfunction : build_phase

function void I2sTransmitterMonitorProxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

function void I2sTransmitterMonitorProxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  i2sTransmitterMonitorBFM.i2sTransmitterMonitorProxy = this;
endfunction  : end_of_elaboration_phase

function void I2sTransmitterMonitorProxy::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase

task I2sTransmitterMonitorProxy::run_phase(uvm_phase phase);

  I2sTransmitterTransaction transmitterTxn;

  `uvm_info(get_type_name(),"Running the Monitor Proxy", UVM_HIGH)

 /* `uvm_info(get_type_name(), "Waiting for reset", UVM_HIGH);
  i2sTransmitterMonitorBFM.wait_for_reset();
 
  forever begin
    i2sTransferPacketStruct packetStruct;
    i2sTransferCfgStruct configStruct;

   
    i2sTransmitterConfigConverter::from_class(i2sTransmitterAgentConfig, configStruct);
    `uvm_info(get_type_name(), $sformatf("Converted cfg struct\n%p",configStruct), UVM_HIGH)

    i2sTransmitterMonitorBFM.sample_data(packetStruct,configStruct);

    I2sTransmitterSeqItemConverter::to_class(packetStruct,i2sTransmitterTransaction);    

    $cast(transmitterTxn, i2sTransmitterTransaction.clone());
    `uvm_info(get_type_name(),$sformatf("Packet received from sample_data clone packet is \n %s",transmitterTxn.sprint()),UVM_HIGH)   
 
    i2sTransmitterAnalysisPort.write(transmitterTxn); 
   
 end */


endtask : run_phase  

`endif


