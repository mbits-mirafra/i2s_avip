`ifndef I2SWRITEOPERATIONWITH24BITDATARXMASTERTXSLAVEWITHRXWSP32BITTXWSP48BITWITH192KHZTEST_INCLUDED_
`define I2SWRITEOPERATIONWITH24BITDATARXMASTERTXSLAVEWITHRXWSP32BITTXWSP48BITWITH192KHZTEST_INCLUDED_

class I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP32bitTxWSP48bitWith192khzTest extends I2sBaseTest; 
  `uvm_component_utils(I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP32bitTxWSP48bitWith192khzTest)

  I2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP32bitTxWSP48bitSeq i2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP32bitTxWSP48bitSeq;

  extern function new(string name = "I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP32bitTxWSP48bitWith192khzTest", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void setupTransmitterAgentConfig();
  extern virtual function void setupReceiverAgentConfig();



endclass : I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP32bitTxWSP48bitWith192khzTest

function I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP32bitTxWSP48bitWith192khzTest::new(string name = "I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP32bitTxWSP48bitWith192khzTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP32bitTxWSP48bitWith192khzTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive = uvm_active_passive_enum'(UVM_ACTIVE);
   i2sEnvConfig.i2sReceiverAgentConfig.mode  = modeTypeEnum'(RX_MASTER);
   i2sEnvConfig.i2sReceiverAgentConfig.clockratefrequency  = clockrateFrequencyEnum'(KHZ_192);
   i2sEnvConfig.i2sReceiverAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
   i2sEnvConfig.i2sReceiverAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_4_BYTE);
   i2sEnvConfig.i2sReceiverAgentConfig.Sclk=1;
endfunction:setupReceiverAgentConfig

function void I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP32bitTxWSP48bitWith192khzTest::setupTransmitterAgentConfig();
  super.setupTransmitterAgentConfig();
     i2sEnvConfig.i2sTransmitterAgentConfig.mode  = modeTypeEnum'(TX_SLAVE);
     i2sEnvConfig.i2sTransmitterAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
     i2sEnvConfig.i2sTransmitterAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_6_BYTE);
endfunction:setupTransmitterAgentConfig



task I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP32bitTxWSP48bitWith192khzTest::run_phase(uvm_phase phase);

  i2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP32bitTxWSP48bitSeq = I2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP32bitTxWSP48bitSeq::type_id::create("i2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP32bitTxWSP48bitSeq");
  `uvm_info(get_type_name(), $sformatf("Inside run_phase I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP32bitTxWSP48bitWith192khzTest"), UVM_LOW);
  
  phase.raise_objection(this);
  i2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP32bitTxWSP48bitSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
endtask : run_phase

`endif


