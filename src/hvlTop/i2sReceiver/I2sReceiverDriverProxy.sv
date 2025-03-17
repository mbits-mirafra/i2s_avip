`ifndef I2SRECEIVERDRIVERPROXY_INCLUDED_
`define I2SRECEIVERDRIVERPROXY_INCLUDED_

class I2sReceiverDriverProxy extends uvm_driver#(I2sReceiverTransaction);
  `uvm_component_utils(I2sReceiverDriverProxy)
 
  I2sReceiverAgentConfig i2sReceiverAgentConfig;
  i2sTransferPacketStruct packetStruct;
  i2sTransferCfgStruct configStruct;
  I2sReceiverTransaction i2sReceiverTransaction;

  virtual I2sReceiverDriverBFM i2sReceiverDriverBFM;
  

  extern function new(string name = "I2sReceiverDriverProxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task driveToBFM(inout i2sTransferPacketStruct packetStruct, 
                                   input i2sTransferCfgStruct configStruct);
  extern virtual task driveToBFMSclk(input i2sTransferCfgStruct configStruct);
  extern virtual task  driverBFMWhenRXMaster(inout i2sTransferPacketStruct packetStruct, 
                                   input i2sTransferCfgStruct configStruct);

endclass : I2sReceiverDriverProxy


function I2sReceiverDriverProxy::new(string name = "I2sReceiverDriverProxy",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new


function void I2sReceiverDriverProxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
i2sReceiverTransaction=I2sReceiverTransaction::type_id::create("i2sReceiverTransaction");
 if(!uvm_config_db#(virtual I2sReceiverDriverBFM)::get(this,"","I2sReceiverDriverBFM",i2sReceiverDriverBFM))
`uvm_fatal("FATAL_MDP_CANNOT_GET_controller_DRIVER_BFM","cannot get () i2sReceiverDriverBFM from uvm_config_db")
endfunction : build_phase


function void I2sReceiverDriverProxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase


function void I2sReceiverDriverProxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  i2sReceiverDriverBFM.i2sReceiverDriverProxy = this;
endfunction  : end_of_elaboration_phase


task I2sReceiverDriverProxy::run_phase(uvm_phase phase);
  super.run_phase(phase);
   `uvm_info("START", "start of run phase in receiver Driver Proxy", UVM_HIGH);

  `uvm_info(get_type_name(), "Receiver Driver Proxy:: Waiting for reset", UVM_HIGH);
  i2sReceiverDriverBFM.waitForReset();
  `uvm_info(get_type_name(), "Receiver Driver Proxy :: Reset detected", UVM_HIGH);

   I2sReceiverConfigConverter::fromReceiverClass(i2sReceiverAgentConfig, configStruct);
    `uvm_info(get_type_name(), $sformatf("Converted cfg struct\n%p",configStruct), UVM_HIGH)
 
  if(configStruct.mode == RX_MASTER)
   begin

     fork
       
       driveToBFMSclk(configStruct);
       driverBFMWhenRXMaster(packetStruct,configStruct);
     join_any
    
   end
   else if(configStruct.mode == RX_SLAVE)
    begin
    `uvm_info(get_type_name(), $sformatf("Receiver will act as passive agent"), UVM_HIGH);
    end
 
 endtask : run_phase


task I2sReceiverDriverProxy::driverBFMWhenRXMaster(inout i2sTransferPacketStruct packetStruct,input i2sTransferCfgStruct configStruct);
  `uvm_info("START", "Inside I2sReceiverDriverProxy", UVM_HIGH);

  forever begin
        
    seq_item_port.get_next_item(i2sReceiverTransaction);

    `uvm_info(get_type_name(), $sformatf("Received req\n%s",i2sReceiverTransaction.sprint()), UVM_HIGH)
    I2sReceiverSeqItemConverter::fromReceiverClass(i2sReceiverTransaction, packetStruct);
    `uvm_info(get_type_name(), $sformatf("Converted req struct\n%p",packetStruct), UVM_HIGH)
     I2sReceiverConfigConverter::fromReceiverClass(i2sReceiverAgentConfig, configStruct);
    `uvm_info(get_type_name(), $sformatf("Converted cfg struct\n%p",configStruct), UVM_HIGH)
   
    driveToBFM(packetStruct,configStruct);
  
    I2sReceiverSeqItemConverter::toReceiverClass(packetStruct,i2sReceiverTransaction);
    `uvm_info(get_type_name(), $sformatf("After :: Received req\n%s",i2sReceiverTransaction.sprint()), UVM_HIGH)
 
   seq_item_port.item_done();
     
  end
endtask 

task I2sReceiverDriverProxy::driveToBFM(inout i2sTransferPacketStruct packetStruct, 
                                   input i2sTransferCfgStruct configStruct);

  i2sReceiverDriverBFM.drivePacket(packetStruct,configStruct);
   
  `uvm_info(get_type_name(),$sformatf("AFTER STRUCT PACKET : , \n %p",configStruct),UVM_LOW);

endtask: driveToBFM

task I2sReceiverDriverProxy::driveToBFMSclk(input i2sTransferCfgStruct configStruct);

  i2sReceiverDriverBFM.genSclk(configStruct);
   
  `uvm_info(get_type_name(),$sformatf("AFTER STRUCT PACKET : , \n %p",configStruct),UVM_LOW);

endtask: driveToBFMSclk


`endif
