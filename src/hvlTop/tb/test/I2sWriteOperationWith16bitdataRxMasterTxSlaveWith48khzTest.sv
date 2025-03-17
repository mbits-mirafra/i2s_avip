`ifndef I2SWRITEOPERATIONWITH16BITDATARXMASTERTXSLAVEWITH48KHZTEST_INCLUDED_
`define I2SWRITEOPERATIONWITH16BITDATARXMASTERTXSLAVEWITH48KHZTEST_INCLUDED_

class I2sWriteOperationWith16bitdataRxMasterTxSlaveWith48khzTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationWith16bitdataRxMasterTxSlaveWith48khzTest)

  I2sVirtual16bitWriteOperationRxMasterTxSlaveSeq i2sVirtual16bitWriteOperationRxMasterTxSlaveSeq;

  extern function new(string name = "I2sWriteOperationWith16bitdataRxMasterTxSlaveWith48khzTest", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void setupTransmitterAgentConfig();
  extern virtual function void setupReceiverAgentConfig();

endclass : I2sWriteOperationWith16bitdataRxMasterTxSlaveWith48khzTest

function I2sWriteOperationWith16bitdataRxMasterTxSlaveWith48khzTest::new(string name = "I2sWriteOperationWith16bitdataRxMasterTxSlaveWith48khzTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sWriteOperationWith16bitdataRxMasterTxSlaveWith48khzTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive = uvm_active_passive_enum'(UVM_ACTIVE);
   i2sEnvConfig.i2sReceiverAgentConfig.mode  = modeTypeEnum'(RX_MASTER);
   i2sEnvConfig.i2sReceiverAgentConfig.clockratefrequency  = clockrateFrequencyEnum'(KHZ_48);
   i2sEnvConfig.i2sReceiverAgentConfig.numOfBitsTransfer  = numOfBitsTransferEnum'(BITS_16); 
   i2sEnvConfig.i2sReceiverAgentConfig.Sclk=1; 
  
endfunction:setupReceiverAgentConfig

function void I2sWriteOperationWith16bitdataRxMasterTxSlaveWith48khzTest::setupTransmitterAgentConfig();
  super.setupTransmitterAgentConfig();
     i2sEnvConfig.i2sTransmitterAgentConfig.mode  = modeTypeEnum'(TX_SLAVE);
     i2sEnvConfig.i2sTransmitterAgentConfig.numOfBitsTransfer  = numOfBitsTransferEnum'(BITS_16); 

endfunction:setupTransmitterAgentConfig

task I2sWriteOperationWith16bitdataRxMasterTxSlaveWith48khzTest::run_phase(uvm_phase phase);

  i2sVirtual16bitWriteOperationRxMasterTxSlaveSeq = I2sVirtual16bitWriteOperationRxMasterTxSlaveSeq::type_id::create("i2sVirtual16bitWriteOperationRxMasterTxSlaveSeq");
  `uvm_info(get_type_name(), $sformatf("Inside run_phase I2sWriteOperationWith16bitdataRxMasterTxSlaveWith48khzTest"), UVM_LOW);
  
  phase.raise_objection(this);
  i2sVirtual16bitWriteOperationRxMasterTxSlaveSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
endtask : run_phase

`endif




