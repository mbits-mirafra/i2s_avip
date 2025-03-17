`ifndef I2SWRITEOPERATIONWITH16BITDATATXMASTERRXSLAVETEST_INCLUDED_
`define I2SWRITEOPERATIONWITH16BITDATATXMASTERRXSLAVETEST_INCLUDED_

class I2sWriteOperationWith16bitdataTxMasterRxSlaveWith8khzTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationWith16bitdataTxMasterRxSlaveWith8khzTest)

  I2sVirtual16bitWriteOperationTxMasterRxSlaveSeq i2sVirtual16bitWriteOperationTxMasterRxSlaveSeq;
  
  extern function new(string name = "I2sWriteOperationWith16bitdataTxMasterRxSlaveWith8khzTest", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);
  extern function void setupTransmitterAgentConfig();
  extern function void setupReceiverAgentConfig();


endclass : I2sWriteOperationWith16bitdataTxMasterRxSlaveWith8khzTest

function I2sWriteOperationWith16bitdataTxMasterRxSlaveWith8khzTest::new(string name = "I2sWriteOperationWith16bitdataTxMasterRxSlaveWith8khzTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sWriteOperationWith16bitdataTxMasterRxSlaveWith8khzTest::setupTransmitterAgentConfig();
  super.setupTransmitterAgentConfig();
     i2sEnvConfig.i2sTransmitterAgentConfig.clockratefrequency  = clockrateFrequencyEnum'(KHZ_8);
     i2sEnvConfig.i2sTransmitterAgentConfig.numOfBitsTransfer  = numOfBitsTransferEnum'(BITS_16); 
     i2sEnvConfig.i2sTransmitterAgentConfig.Sclk  = 1; 
          
endfunction:setupTransmitterAgentConfig


function void I2sWriteOperationWith16bitdataTxMasterRxSlaveWith8khzTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive     = uvm_active_passive_enum'(UVM_PASSIVE);
   i2sEnvConfig.i2sReceiverAgentConfig.numOfBitsTransfer  = numOfBitsTransferEnum'(BITS_16); 

endfunction:setupReceiverAgentConfig


task I2sWriteOperationWith16bitdataTxMasterRxSlaveWith8khzTest::run_phase(uvm_phase phase);

  i2sVirtual16bitWriteOperationTxMasterRxSlaveSeq=I2sVirtual16bitWriteOperationTxMasterRxSlaveSeq::type_id::create("i2sVirtual16bitWriteOperationTxMasterRxSlaveSeq");
  `uvm_info(get_type_name(),$sformatf("Inside run_phase I2sWriteOperationWith16bitdataTxMasterRxSlaveWith8khzTest"),UVM_LOW);
    phase.raise_objection(this);
    i2sVirtual16bitWriteOperationTxMasterRxSlaveSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);

endtask : run_phase

`endif



