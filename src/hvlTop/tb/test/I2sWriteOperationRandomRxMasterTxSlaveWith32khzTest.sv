`ifndef I2SWRITEOPERATIONRANDOMRXMASTERTXSLAVEWITH32KHZTEST_INCLUDED_
`define I2SWRITEOPERATIONRANDOMRXMASTERTXSLAVEWITH32KHZTEST_INCLUDED_

class I2sWriteOperationRandomRxMasterTxSlaveWith32khzTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationRandomRxMasterTxSlaveWith32khzTest)

  I2sVirtualRandomWriteOperationRxMasterTxSlaveSeq i2sVirtualRandomWriteOperationRxMasterTxSlaveSeq;

  extern function new(string name = "I2sWriteOperationRandomRxMasterTxSlaveWith32khzTest", uvm_component parent = null);
  extern virtual function void setupTransmitterAgentConfig();
  extern virtual function void setupReceiverAgentConfig();
  extern virtual task run_phase(uvm_phase phase);

endclass : I2sWriteOperationRandomRxMasterTxSlaveWith32khzTest

function I2sWriteOperationRandomRxMasterTxSlaveWith32khzTest::new(string name = "I2sWriteOperationRandomRxMasterTxSlaveWith32khzTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sWriteOperationRandomRxMasterTxSlaveWith32khzTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive = uvm_active_passive_enum'(UVM_ACTIVE);
   i2sEnvConfig.i2sReceiverAgentConfig.mode  = modeTypeEnum'(RX_MASTER);
   i2sEnvConfig.i2sReceiverAgentConfig.clockratefrequency  = clockrateFrequencyEnum'(KHZ_32);
   i2sEnvConfig.i2sReceiverAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
   i2sEnvConfig.i2sReceiverAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_4_BYTE);
   i2sEnvConfig.i2sReceiverAgentConfig.Sclk=1;   
endfunction:setupReceiverAgentConfig

function void I2sWriteOperationRandomRxMasterTxSlaveWith32khzTest::setupTransmitterAgentConfig();
  super.setupTransmitterAgentConfig();
     i2sEnvConfig.i2sTransmitterAgentConfig.mode  = modeTypeEnum'(TX_SLAVE);
     i2sEnvConfig.i2sTransmitterAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
     i2sEnvConfig.i2sTransmitterAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_8_BYTE);

endfunction:setupTransmitterAgentConfig

task I2sWriteOperationRandomRxMasterTxSlaveWith32khzTest::run_phase(uvm_phase phase);

  i2sVirtualRandomWriteOperationRxMasterTxSlaveSeq = I2sVirtualRandomWriteOperationRxMasterTxSlaveSeq::type_id::create("i2sVirtualRandomWriteOperationRxMasterTxSlaveSeq");
  `uvm_info(get_type_name(), $sformatf("Inside run_phase I2sWriteOperationRandomRxMasterTxSlaveWith32khzTest"), UVM_LOW);
  
  phase.raise_objection(this);
  i2sVirtualRandomWriteOperationRxMasterTxSlaveSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
endtask : run_phase

`endif




