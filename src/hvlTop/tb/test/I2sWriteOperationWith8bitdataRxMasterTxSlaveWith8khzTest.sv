`ifndef I2SWRITEOPERATIONWITH8BITDATARXMASTERTXSLAVEWITH8KHZTEST_INCLUDED_
`define I2SWRITEOPERATIONWITH8BITDATARXMASTERTXSLAVEWITH8KHZTEST_INCLUDED_

class I2sWriteOperationWith8bitdataRxMasterTxSlaveWith8khzTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationWith8bitdataRxMasterTxSlaveWith8khzTest)

  I2sVirtual8bitWriteOperationRxMasterTxSlaveSeq i2sVirtual8bitWriteOperationRxMasterTxSlaveSeq;

  extern function new(string name = "I2sWriteOperationWith8bitdataRxMasterTxSlaveWith8khzTest", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void setupTransmitterAgentConfig();
  extern virtual function void setupReceiverAgentConfig();

endclass : I2sWriteOperationWith8bitdataRxMasterTxSlaveWith8khzTest

function I2sWriteOperationWith8bitdataRxMasterTxSlaveWith8khzTest::new(string name = "I2sWriteOperationWith8bitdataRxMasterTxSlaveWith8khzTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sWriteOperationWith8bitdataRxMasterTxSlaveWith8khzTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive = uvm_active_passive_enum'(UVM_ACTIVE);
   i2sEnvConfig.i2sReceiverAgentConfig.mode  = modeTypeEnum'(RX_MASTER);
   i2sEnvConfig.i2sReceiverAgentConfig.clockratefrequency  = clockrateFrequencyEnum'(KHZ_8);
   i2sEnvConfig.i2sReceiverAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
   i2sEnvConfig.i2sReceiverAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_2_BYTE);
   i2sEnvConfig.i2sReceiverAgentConfig.Sclk=1; 
  
endfunction:setupReceiverAgentConfig

function void I2sWriteOperationWith8bitdataRxMasterTxSlaveWith8khzTest::setupTransmitterAgentConfig();
  super.setupTransmitterAgentConfig();
     i2sEnvConfig.i2sTransmitterAgentConfig.mode  = modeTypeEnum'(TX_SLAVE);
     i2sEnvConfig.i2sTransmitterAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
     i2sEnvConfig.i2sTransmitterAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_2_BYTE);

endfunction:setupTransmitterAgentConfig

task I2sWriteOperationWith8bitdataRxMasterTxSlaveWith8khzTest::run_phase(uvm_phase phase);

  i2sVirtual8bitWriteOperationRxMasterTxSlaveSeq = I2sVirtual8bitWriteOperationRxMasterTxSlaveSeq::type_id::create("i2sVirtual8bitWriteOperationRxMasterTxSlaveSeq");
  `uvm_info(get_type_name(), $sformatf("Inside run_phase I2sWriteOperationWith8bitdataRxMasterTxSlaveWith8khzTest"), UVM_LOW);
  
  phase.raise_objection(this);
  i2sVirtual8bitWriteOperationRxMasterTxSlaveSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
endtask : run_phase

`endif



