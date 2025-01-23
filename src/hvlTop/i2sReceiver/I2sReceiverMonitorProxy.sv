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

function I2sReceiverMonitorProxy::new(string name = "I2sReceiverMonitorProxy",
                                                  uvm_component parent = null);
  super.new(name, parent);
  i2sReceiverAnalysisPort = new("i2sReceiverAnalysisPort",this);
    i2sReceiverTransaction = new();
endfunction : new

function void I2sReceiverMonitorProxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
   // if(!uvm_config_db #(virtual I2sReceiverMonitorBFM)::get(this,"","I2sReceiverMonitorBFM",i2sReceiverMonitorBFM))begin
  //`uvm_fatal("FATAL_MDP_CANNOT_GET_SLAVE_MONITOR_BFM","cannot get () I2sReceiverMonitorBFM from uvm_config_db")
  //end
endfunction : build_phase

function void I2sReceiverMonitorProxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
   `uvm_info(get_type_name(),"Starting of connect phase", UVM_HIGH)
endfunction : connect_phase

function void I2sReceiverMonitorProxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  //i2sReceiverMonitorBFM.i2sReceiverMonitorProxy = this;
  `uvm_info(get_type_name(),"Starting of end_of_elaboration_phase", UVM_HIGH)
endfunction  : end_of_elaboration_phase

function void I2sReceiverMonitorProxy::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
   `uvm_info(get_type_name(),"Starting of starting_of_simulation_phase", UVM_HIGH)
endfunction : start_of_simulation_phase

task I2sReceiverMonitorProxy::run_phase(uvm_phase phase);

 // i2s_slave_seq_item txn_packet;

  `uvm_info(get_type_name(),"Running the Monitor Proxy", UVM_HIGH)
  `uvm_info(get_type_name(),"Starting of Run phase", UVM_HIGH)



  //`uvm_info(get_type_name(), "Waiting for reset", UVM_HIGH);
  //i2s_slave_mon_bfm_h.wait_for_reset();
 
 // forever begin
   // i2s_transfer_bits_s struct_packet;
    //i2s_transfer_cfg_s struct_cfg;

   
   // i2s_slave_cfg_converter::from_class(i2s_slave_agent_cfg_h, struct_cfg);
    //`uvm_info(get_type_name(), $sformatf("Converted cfg struct\n%p",struct_cfg), UVM_HIGH)

    //i2s_slave_mon_bfm_h.sample_data(struct_packet,struct_cfg);

   // i2s_slave_seq_item_converter::to_class(struct_packet, i2s_slave_seq_item_h);    

    //$cast(txn_packet,  i2s_slave_seq_item_h.clone());
    //`uvm_info(get_type_name(),$sformatf("Packet received from sample_data clone packet is \n %s",txn_packet.sprint()),UVM_HIGH)   
 
    //slave_analysis_port.write(txn_packet);
   
 //end


endtask : run_phase

`endif
