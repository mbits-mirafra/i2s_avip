`ifndef I2SRECEIVERMONITORPROXY_INCLUDED_
`define I2SRECEIVERMONITORPROXY_INCLUDED_
 
class I2sReceiverMonitorProxy extends uvm_component;
  `uvm_component_utils(I2sReceiverMonitorProxy)
 
  I2sReceiverTransaction i2sReceiverTransaction;
  I2sReceiverAgentConfig i2sReceiverAgentConfig;
 
  virtual I2sReceiverMonitorBFM i2sReceiverMonitorBFM;
 
  uvm_analysis_port #(I2sReceiverTransaction)i2sReceiverAnalysisPort;
 
  extern function new(string name = "I2sReceiverMonitorProxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
 
endclass : I2sReceiverMonitorProxy
 
function I2sReceiverMonitorProxy::new(string name = "I2sReceiverMonitorProxy", uvm_component parent = null);
  super.new(name, parent);
   i2sReceiverAnalysisPort = new("i2sReceiverAnalysisPort",this);
   i2sReceiverTransaction = new();
endfunction : new
 
function void I2sReceiverMonitorProxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db #(virtual I2sReceiverMonitorBFM)::get(this,"","I2sReceiverMonitorBFM",i2sReceiverMonitorBFM))begin
  `uvm_fatal("FATAL_MDP_CANNOT_GET_RECEIVER_MONITOR_BFM","cannot get () I2sReceiverMonitorBFM from uvm_config_db")
  end
endfunction : build_phase
 
function void I2sReceiverMonitorProxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase
 
function void I2sReceiverMonitorProxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  i2sReceiverMonitorBFM.i2sReceiverMonitorProxy = this;
endfunction  : end_of_elaboration_phase
 
function void I2sReceiverMonitorProxy::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
endfunction : start_of_simulation_phase
 
task I2sReceiverMonitorProxy::run_phase(uvm_phase phase);
 
  I2sReceiverTransaction i2sReceiverTxn;
 
  `uvm_info(get_type_name(),"Running the Monitor Proxy", UVM_HIGH)
 
  `uvm_info(get_type_name(), "Waiting for reset", UVM_HIGH);
 i2sReceiverMonitorBFM.waitForReset();
  forever begin
    i2sTransferPacketStruct packetStruct;
    i2sTransferCfgStruct configStruct;
 
   
    I2sReceiverConfigConverter::fromReceiverClass(i2sReceiverAgentConfig, configStruct);
    `uvm_info(get_type_name(), $sformatf("Converted cfg struct\n%p",configStruct), UVM_HIGH)
 
    i2sReceiverMonitorBFM.samplePacket(packetStruct,configStruct);
 
    I2sReceiverSeqItemConverter::toReceiverClass(packetStruct,i2sReceiverTransaction);    
    

    $cast(i2sReceiverTxn, i2sReceiverTransaction.clone());
    `uvm_info(get_type_name(),$sformatf("Packet received from sample_data clone packet is  %s",i2sReceiverTxn.sprint()),UVM_HIGH)   
    i2sReceiverAnalysisPort.write(i2sReceiverTxn);
end
 
 
endtask : run_phase
 
`endif
