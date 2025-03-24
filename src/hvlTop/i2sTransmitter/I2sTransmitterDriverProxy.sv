`ifndef I2STRANSMITTERDRIVERPROXY_INCLUDED_
`define I2STRANSMITTERDRIVERPROXY_INCLUDED_

class I2sTransmitterDriverProxy extends uvm_driver#(I2sTransmitterTransaction);
  
  `uvm_component_utils(I2sTransmitterDriverProxy)

   virtual I2sTransmitterDriverBFM i2sTransmitterDriverBFM;
 
   I2sTransmitterAgentConfig i2sTransmitterAgentConfig;
   I2sTransmitterTransaction i2sTransmitterTransaction;
   i2sTransferPacketStruct packetStruct;
   i2sTransferCfgStruct configStruct;


  extern function new(string name = "I2sTransmitterDriverProxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task driveToBFM(inout i2sTransferPacketStruct packetStruct, 
                                   input i2sTransferCfgStruct configStruct);
  extern virtual task driveToBFMSclk(input i2sTransferCfgStruct configStruct);

  extern virtual task  driverBFMWhenTXMaster(inout i2sTransferPacketStruct packetStruct, 
                                   input i2sTransferCfgStruct configStruct);
  extern virtual task  driverBFMWhenTXSlave(inout i2sTransferPacketStruct packetStruct, 
                                   input i2sTransferCfgStruct configStruct);
  
  

endclass : I2sTransmitterDriverProxy


function I2sTransmitterDriverProxy::new(string name = "I2sTransmitterDriverProxy",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new


function void I2sTransmitterDriverProxy::build_phase(uvm_phase phase);
  super.build_phase(phase);
 i2sTransmitterTransaction=I2sTransmitterTransaction::type_id::create("i2sTransmitterTransaction");
  if(!uvm_config_db#(virtual I2sTransmitterDriverBFM)::get(this,"","I2sTransmitterDriverBFM",i2sTransmitterDriverBFM))
  `uvm_fatal("FATAL_MDP_CANNOT_GET_TRANSMITTER_DRIVER_BFM","cannot get () i2sTransmitterDriverBFM from uvm_config_db")
endfunction : build_phase


function void I2sTransmitterDriverProxy::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase


function void I2sTransmitterDriverProxy::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  i2sTransmitterDriverBFM.i2sTransmitterDriverProxy = this;
endfunction  : end_of_elaboration_phase


task I2sTransmitterDriverProxy::run_phase(uvm_phase phase);
  super.run_phase(phase);

  `uvm_info(get_type_name(), "Running the transmitter Driver", UVM_NONE)

   i2sTransmitterDriverBFM.waitForReset();
  `uvm_info(get_type_name(), "I2S :: Reset detected", UVM_NONE);

   
     I2sTransmitterConfigConverter::fromTransmitterClass(i2sTransmitterAgentConfig, configStruct);
    `uvm_info(get_type_name(), $sformatf("IN DRIVER- Converted cfg struct\n%p",configStruct), UVM_NONE)

    `uvm_info("DEBUG", "IN DRIVER-Inside I2sTransmitterDriverProxy", UVM_NONE)

     if(configStruct.mode == TX_MASTER)

     begin

     fork
       driveToBFMSclk(configStruct);
       driverBFMWhenTXMaster(packetStruct,configStruct);
     join_any
    
     end
    else if(configStruct.mode == TX_SLAVE)
    begin
      driverBFMWhenTXSlave(packetStruct,configStruct);
    end	
 

 endtask : run_phase

 task I2sTransmitterDriverProxy::driverBFMWhenTXMaster(inout i2sTransferPacketStruct packetStruct,input i2sTransferCfgStruct configStruct);

  forever begin

    seq_item_port.get_next_item(i2sTransmitterTransaction);
    
    `uvm_info(get_type_name(), $sformatf("IN DRIVER- Received i2sTransmitterTransaction\n%s",i2sTransmitterTransaction.sprint()), UVM_NONE)


    I2sTransmitterSeqItemConverter::fromTransmitterClass(i2sTransmitterTransaction, packetStruct);
    `uvm_info(get_type_name(), $sformatf("IN DRIVER- Converted i2sTransmitterTransaction to struct\n%p",packetStruct), UVM_NONE)

     I2sTransmitterConfigConverter::fromTransmitterClass(i2sTransmitterAgentConfig, configStruct);
    `uvm_info(get_type_name(), $sformatf("IN DRIVER- Converted cfg struct\n%p",configStruct), UVM_NONE)

     driveToBFM(packetStruct,configStruct);
       
    I2sTransmitterSeqItemConverter::toTransmitterClass(packetStruct,i2sTransmitterTransaction);
    `uvm_info(get_type_name(), $sformatf("IN DRIVER-After driving data to interface :: Received i2sTransmitterTransaction\n%s",i2sTransmitterTransaction.sprint()), UVM_NONE)

    seq_item_port.item_done();
    
  end
  
  endtask

   task I2sTransmitterDriverProxy::driverBFMWhenTXSlave(inout i2sTransferPacketStruct packetStruct,input i2sTransferCfgStruct configStruct);
    
   forever begin
     seq_item_port.get_next_item(i2sTransmitterTransaction);
       
    `uvm_info(get_type_name(), $sformatf("IN DRIVER- Received i2sTransmitterTransaction\n%s",i2sTransmitterTransaction.sprint()), UVM_NONE)

    I2sTransmitterSeqItemConverter::fromTransmitterClass(i2sTransmitterTransaction, packetStruct);
    `uvm_info(get_type_name(), $sformatf("IN DRIVER- Converted i2sTransmitterTransaction to struct\n%p",packetStruct), UVM_NONE)

     I2sTransmitterConfigConverter::fromTransmitterClass(i2sTransmitterAgentConfig, configStruct);
    `uvm_info(get_type_name(), $sformatf("IN DRIVER- Converted cfg struct\n%p",configStruct), UVM_NONE)
     i2sTransmitterDriverBFM.detectWsandDriveSD(packetStruct,configStruct);
    
    I2sTransmitterSeqItemConverter::toTransmitterClass(packetStruct,i2sTransmitterTransaction);
    `uvm_info(get_type_name(), $sformatf("IN DRIVER-After driving data to interface :: Received i2sTransmitterTransaction\n%s",i2sTransmitterTransaction.sprint()), UVM_NONE)

    seq_item_port.item_done();

  end
  
  endtask:driverBFMWhenTXSlave


task I2sTransmitterDriverProxy::driveToBFM(inout i2sTransferPacketStruct packetStruct, 
                                   input i2sTransferCfgStruct configStruct);
  `uvm_info("DEBUG", "IN DRIVER- Inside drive to bfm", UVM_NONE);
  i2sTransmitterDriverBFM.driveData(packetStruct,configStruct); 
  `uvm_info(get_type_name(),$sformatf("IN DRIVER- AFTER STRUCT PACKET : , \n %p",configStruct),UVM_LOW);
endtask: driveToBFM

task I2sTransmitterDriverProxy::driveToBFMSclk(input i2sTransferCfgStruct configStruct);
  `uvm_info("DEBUG", "IN DRIVER- Inside drive to bfm Sclk", UVM_NONE);
  i2sTransmitterDriverBFM.genSclk(configStruct);
  `uvm_info(get_type_name(),$sformatf("IN DRIVER- AFTER STRUCT PACKET : , \n %p",configStruct),UVM_LOW);
endtask: driveToBFMSclk


`endif
