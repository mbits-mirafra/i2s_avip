`ifndef I2STRANSMITTERMONITORPROXY_INCLUDED_
`define I2STRANSMITTERMONITORPROXY_INCLUDED_

class I2sTransmitterMonitorProxy extends uvm_component;
  `uvm_component_utils(I2sTransmitterMonitorProxy)

   I2sTransmitterTransaction i2sTransmitterTransaction;
   I2sTransmitterAgentConfig i2sTransmitterAgentConfig;

  virtual I2sTransmitterMonitorBFM i2sTransmitterMonitorBFM;

  uvm_analysis_port #(I2sTransmitterTransaction) i2sTransmitterAnalysisPort;

  extern function new(string name = "I2sTransmitterMonitorProxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : I2sTransmitterMonitorProxy

function I2sTransmitterMonitorProxy::new(string name = "I2sTransmitterMonitorProxy",
                                                  uvm_component parent = null);
  super.new(name, parent);
  i2sTransmitterAnalysisPort = new("i2sTransmitterAnalysisPort",this);
endfunction : new

function void I2sTransmitterMonitorProxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
i2sTransmitterTransaction=I2sTransmitterTransaction::type_id::create("i2sTransmitterTransaction"); 
  if(!uvm_config_db #(virtual I2sTransmitterMonitorBFM)::get(this,"","I2sTransmitterMonitorBFM",i2sTransmitterMonitorBFM))begin
  `uvm_fatal("FATAL_MDP_CANNOT_GET_TRANSMITTER_MONITOR_BFM","cannot get () i2sTransmitterMonitorBFM from uvm_config_db")
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

  I2sTransmitterTransaction i2sTransmittertxn;

  `uvm_info(get_type_name(),"IN TRANSMITTER MONITOR: Running the Monitor Proxy", UVM_NONE)

  `uvm_info(get_type_name(), "IN TRANSMITTER MONITOR: Waiting for reset", UVM_NONE);
    i2sTransmitterMonitorBFM.waitForReset();
  `uvm_info(get_type_name(), "IN TRANSMITTER MONITOR: I2S: Reset detected", UVM_NONE);

  forever begin
     i2sTransferPacketStruct packetStruct;
    i2sTransferCfgStruct configStruct;

     I2sTransmitterSeqItemConverter::fromTransmitterClass(i2sTransmitterTransaction, packetStruct);
      `uvm_info(get_type_name(), $sformatf("IN TRANSMITTER MONITOR: Converted i2sTransmitterTransaction to struct\n%p",packetStruct), UVM_NONE)


   I2sTransmitterConfigConverter::fromTransmitterClass(i2sTransmitterAgentConfig, configStruct);

   `uvm_info(get_type_name(), $sformatf("IN TRANSMITTER MONITOR: Converted cfg struct\n%p",configStruct), UVM_NONE)
   
     i2sTransmitterMonitorBFM.sampleData(packetStruct,configStruct);

     I2sTransmitterSeqItemConverter::toTransmitterClass(packetStruct,i2sTransmitterTransaction);
         

    $cast(i2sTransmittertxn, i2sTransmitterTransaction.clone());
    `uvm_info(get_type_name(),$sformatf("IN TRANSMITTER MONITOR: Packet received from sample_data clone packet is \n %s",i2sTransmittertxn.sprint()),UVM_NONE)   
 
    i2sTransmitterAnalysisPort.write(i2sTransmittertxn); 
   
 end 


endtask : run_phase  

`endif


