`ifndef I2SRECEIVERDRIVERPROXY_INCLUDED_
`define I2SRECEIVERDRIVERPROXY_INCLUDED_

class I2sReceiverDriverProxy extends uvm_driver#(I2sReceiverTransaction);
  `uvm_component_utils(I2sReceiverDriverProxy)
 
  I2sReceiverAgentConfig i2sReceiverAgentConfig;
  virtual I2sReceiverDriverBFM i2sReceiverDriverBFM;

  extern function new(string name = "I2sReceiverDriverProxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  //extern virtual task drive_to_bfm(inout i2s_transfer_bits_s packet, 
          //                         input i2s_transfer_cfg_s packet1);
endclass : I2sReceiverDriverProxy


function I2sReceiverDriverProxy::new(string name = "I2sReceiverDriverProxy",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new


function void I2sReceiverDriverProxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
 // if(!uvm_config_db#(virtual I2sReceiverDriverBFM)::get(this,"","i2sReceiverDriverBFM",i2sReceiverDriverBFM))
  //`uvm_fatal("FATAL_MDP_CANNOT_GET_controller_DRIVER_BFM","cannot get () i2sReceiverDriverBFM from uvm_config_db")
endfunction : build_phase


function void I2sReceiverDriverProxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase


function void I2sReceiverDriverProxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
 // i2sReceiverDriverBFM.i2sReceiverDriverProxy = this;
endfunction  : end_of_elaboration_phase


task I2sReceiverDriverProxy::run_phase(uvm_phase phase);
  super.run_phase(phase);
   `uvm_info("START", "start of run phase", UVM_HIGH);

  `uvm_info(get_type_name(), "Running the Driver", UVM_HIGH)

  `uvm_info(get_type_name(), "MIRAFRA :: Waiting for reset", UVM_HIGH);
 // i2s_slave_drv_bfm_h.wait_for_reset();
  `uvm_info(get_type_name(), "MIRAFRA :: Reset detected", UVM_HIGH);

  forever begin
  //  i2s_transfer_bits_s struct_packet;
  //  i2s_transfer_cfg_s struct_cfg;

    `uvm_info("START", "Inside i2s_slave_driver_proxy", UVM_HIGH);

    seq_item_port.get_next_item(req);

    `uvm_info(get_type_name(), $sformatf("Received req\n%s",req.sprint()), UVM_HIGH)
   // i2s_slave_seq_item_converter::from_class(req, struct_packet);

    //`uvm_info(get_type_name(), $sformatf("Converted req struct\n%p",struct_packet), UVM_HIGH)
   // i2s_slave_cfg_converter::from_class(i2s_slave_agent_cfg_h, struct_cfg);
    
    //`uvm_info(get_type_name(), $sformatf("Converted cfg struct\n%p",struct_cfg), UVM_HIGH)

   // drive_to_bfm(struct_packet,struct_cfg);
 
  //  i2s_slave_seq_item_converter::to_class(struct_packet,req);
//    `uvm_info(get_type_name(), $sformatf("AFTER CONVERSION:: Received req\n%s",req.sprint()),
    //UVM_HIGH)

    seq_item_port.item_done();
  end
endtask : run_phase

/*task i2s_slave_driver_proxy::drive_to_bfm(inout i2s_transfer_bits_s packet, 
                                            input  i2s_transfer_cfg_s packet1);
  `uvm_info("START", "Inside drive to bfm", UVM_NONE);
  i2s_slave_drv_bfm_h.drive_data(packet,packet1); 
  `uvm_info(get_type_name(),$sformatf("AFTER STRUCT PACKET : , \n %p",packet1),UVM_LOW);
endtask: drive_to_bfm*/

`endif
