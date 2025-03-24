`ifndef I2SWRITEOPERATIONWITH32BITDATARXMASTERTXSLAVEWITH96KHZTEST_INCLUDED_
`define I2SWRITEOPERATIONWITH32BITDATARXMASTERTXSLAVEWITH96KHZTEST_INCLUDED_

class I2sWriteOperationWith32bitdataRxMasterTxSlaveWith96khzTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationWith32bitdataRxMasterTxSlaveWith96khzTest)

  I2sVirtual32bitWriteOperationRxMasterTxSlaveSeq i2sVirtual32bitWriteOperationRxMasterTxSlaveSeq;

  extern function new(string name = "I2sWriteOperationWith32bitdataRxMasterTxSlaveWith96khzTest", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void setupTransmitterAgentConfig();
  extern virtual function void setupReceiverAgentConfig();


endclass : I2sWriteOperationWith32bitdataRxMasterTxSlaveWith96khzTest

function I2sWriteOperationWith32bitdataRxMasterTxSlaveWith96khzTest::new(string name = "I2sWriteOperationWith32bitdataRxMasterTxSlaveWith96khzTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new


function void I2sWriteOperationWith32bitdataRxMasterTxSlaveWith96khzTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive = uvm_active_passive_enum'(UVM_ACTIVE);
   i2sEnvConfig.i2sReceiverAgentConfig.mode  = modeTypeEnum'(RX_MASTER);
   i2sEnvConfig.i2sReceiverAgentConfig.clockratefrequency  = clockrateFrequencyEnum'(KHZ_96);
   i2sEnvConfig.i2sReceiverAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
   i2sEnvConfig.i2sReceiverAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_8_BYTE);
   i2sEnvConfig.i2sReceiverAgentConfig.Sclk=1; 
  
endfunction:setupReceiverAgentConfig

function void I2sWriteOperationWith32bitdataRxMasterTxSlaveWith96khzTest::setupTransmitterAgentConfig();
  super.setupTransmitterAgentConfig();
     i2sEnvConfig.i2sTransmitterAgentConfig.mode  = modeTypeEnum'(TX_SLAVE);
     i2sEnvConfig.i2sTransmitterAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
     i2sEnvConfig.i2sTransmitterAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_8_BYTE);

endfunction:setupTransmitterAgentConfig



task I2sWriteOperationWith32bitdataRxMasterTxSlaveWith96khzTest::run_phase(uvm_phase phase);

  i2sVirtual32bitWriteOperationRxMasterTxSlaveSeq = I2sVirtual32bitWriteOperationRxMasterTxSlaveSeq::type_id::create("i2sVirtual32bitWriteOperationRxMasterTxSlaveSeq");
  `uvm_info(get_type_name(), $sformatf("Inside run_phase I2sWriteOperationWith32bitdataRxMasterTxSlaveWith96khzTest"), UVM_LOW);
  
  phase.raise_objection(this);
  i2sVirtual32bitWriteOperationRxMasterTxSlaveSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
endtask : run_phase

`endif



