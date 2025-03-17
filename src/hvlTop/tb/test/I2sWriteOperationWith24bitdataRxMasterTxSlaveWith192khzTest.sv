`ifndef I2SWRITEOPERATIONWITH24BITDATARXMASTERTXSLAVEWITH192KHZTEST_INCLUDED_
`define I2SWRITEOPERATIONWITH24BITDATARXMASTERTXSLAVEWITH192KHZTEST_INCLUDED_

class I2sWriteOperationWith24bitdataRxMasterTxSlaveWith192khzTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationWith24bitdataRxMasterTxSlaveWith192khzTest)

  I2sVirtual24bitWriteOperationRxMasterTxSlaveSeq i2sVirtual24bitWriteOperationRxMasterTxSlaveSeq;

  extern function new(string name = "I2sWriteOperationWith24bitdataRxMasterTxSlaveWith192khzTest", uvm_component parent = null);
  extern virtual function void setupTransmitterAgentConfig();
  extern virtual function void setupReceiverAgentConfig();
  extern virtual task run_phase(uvm_phase phase);

endclass : I2sWriteOperationWith24bitdataRxMasterTxSlaveWith192khzTest

function I2sWriteOperationWith24bitdataRxMasterTxSlaveWith192khzTest::new(string name = "I2sWriteOperationWith24bitdataRxMasterTxSlaveWith192khzTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sWriteOperationWith24bitdataRxMasterTxSlaveWith192khzTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive = uvm_active_passive_enum'(UVM_ACTIVE);
   i2sEnvConfig.i2sReceiverAgentConfig.mode  = modeTypeEnum'(RX_MASTER);
   i2sEnvConfig.i2sReceiverAgentConfig.clockratefrequency  = clockrateFrequencyEnum'(KHZ_192);
   i2sEnvConfig.i2sReceiverAgentConfig.numOfBitsTransfer  = numOfBitsTransferEnum'(BITS_24); 
   i2sEnvConfig.i2sReceiverAgentConfig.Sclk=1; 
  
endfunction:setupReceiverAgentConfig

function void I2sWriteOperationWith24bitdataRxMasterTxSlaveWith192khzTest::setupTransmitterAgentConfig();
  super.setupTransmitterAgentConfig();
     i2sEnvConfig.i2sTransmitterAgentConfig.mode  = modeTypeEnum'(TX_SLAVE);
     i2sEnvConfig.i2sTransmitterAgentConfig.numOfBitsTransfer  = numOfBitsTransferEnum'(BITS_24); 

endfunction:setupTransmitterAgentConfig

task I2sWriteOperationWith24bitdataRxMasterTxSlaveWith192khzTest::run_phase(uvm_phase phase);

  i2sVirtual24bitWriteOperationRxMasterTxSlaveSeq = I2sVirtual24bitWriteOperationRxMasterTxSlaveSeq::type_id::create("i2sVirtual24bitWriteOperationRxMasterTxSlaveSeq");
  `uvm_info(get_type_name(), $sformatf("Inside run_phase I2sWriteOperationWith24bitdataRxMasterTxSlaveWith192khzTest"), UVM_LOW);
  
  phase.raise_objection(this);
  i2sVirtual24bitWriteOperationRxMasterTxSlaveSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
endtask : run_phase

`endif



