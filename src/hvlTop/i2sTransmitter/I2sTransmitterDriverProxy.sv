`ifndef I2STRANSMITTERDRIVERPROXY_INCLUDED_
`define I2STRANSMITTERDRIVERPROXY_INCLUDED_

class I2sTransmitterDriverProxy extends uvm_driver#(I2sTransmitterTransaction);
  `uvm_component_utils(I2sTransmitterDriverProxy)
 
  I2sTransmitterAgentConfig i2sTransmitterAgentConfig;
  virtual I2sTransmitterDriverBFM i2sTransmitterDriverBFM;

  extern function new(string name = "I2sTransmitterDriverProxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  /*extern virtual task drive_to_bfm(inout i2s_transfer_bits_s packet, 
                                   input i2s_transfer_cfg_s packet1);*/
endclass : I2sTransmitterDriverProxy


function I2sTransmitterDriverProxy::new(string name = "I2sTransmitterDriverProxy", uvm_component parent = null);
  super.new(name, parent);
endfunction : new


function void I2sTransmitterDriverProxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
  //if(!uvm_config_db#(virtual I2sTransmitterDriverBFM)::get(this,"","I2sTransmitterDriverBFM",i2sTransmitterDriverBFM))
  //`uvm_fatal("FATAL_MDP_CANNOT_GET_controller_DRIVER_BFM","cannot get () I2sTransmitterDriverBFM from uvm_config_db")
endfunction : build_phase


function void I2sTransmitterDriverProxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase


function void I2sTransmitterDriverProxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
 // i2sTransmitterDriverBFM.i2s_master_drv_proxy_h = this;
endfunction  : end_of_elaboration_phase


task I2sTransmitterDriverProxy::run_phase(uvm_phase phase);
  super.run_phase(phase);

  `uvm_info(get_type_name(), "Running the Driver", UVM_HIGH)

  /*`uvm_info(get_type_name(), "MIRAFRA :: Waiting for reset", UVM_HIGH);
  i2sTransmitterDriverBFM.wait_for_reset();
  `uvm_info(get_type_name(), "MIRAFRA :: Reset detected", UVM_HIGH);

  forever begin
    i2s_transfer_bits_s struct_packet;
    i2s_transfer_cfg_s struct_cfg;

    `uvm_info("START", "Inside I2sTransmitterDriverProxy", UVM_HIGH);

    seq_item_port.get_next_item(req);

    `uvm_info(get_type_name(), $sformatf("Received req\n%s",req.sprint()), UVM_HIGH)
    I2sTransmitterTransaction_converter::from_class(req, struct_packet);

    `uvm_info(get_type_name(), $sformatf("Converted req struct\n%p",struct_packet), UVM_HIGH)
    i2s_master_cfg_converter::from_class(i2sTransmitterAgentConfig, struct_cfg);
    
    `uvm_info(get_type_name(), $sformatf("Converted cfg struct\n%p",struct_cfg), UVM_HIGH)

    drive_to_bfm(struct_packet,struct_cfg);
 
    I2sTransmitterTransaction_converter::to_class(struct_packet,req);
    `uvm_info(get_type_name(), $sformatf("AFTER CONVERSION:: Received req\n%s",req.sprint()), UVM_HIGH)

    seq_item_port.item_done();
  end*/
endtask : run_phase

/*task I2sTransmitterDriverProxy::drive_to_bfm(inout i2s_transfer_bits_s packet, 
                                            input  i2s_transfer_cfg_s packet1);
  `uvm_info("START", "Inside drive to bfm", UVM_NONE);
  i2sTransmitterDriverBFM.drive_data(packet,packet1); 
  `uvm_info(get_type_name(),$sformatf("AFTER STRUCT PACKET : , \n %p",packet1),UVM_LOW);
endtask: drive_to_bfm         */

`endif
