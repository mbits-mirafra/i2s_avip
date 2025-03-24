`ifndef I2SWRITEOPERATIONWITH24BITDATARXMASTERTXSLAVEWITHRXWSP64BITTXWSP48WITH48KHZBITTEST_INCLUDED_
`define I2SWRITEOPERATIONWITH24BITDATARXMASTERTXSLAVEWITHRXWSP64BITTXWSP48BITWITH48KHZTEST_INCLUDED_

class I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP48bitWith48khzTest extends I2sBaseTest; 
  `uvm_component_utils(I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP48bitWith48khzTest)

  I2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP48bitSeq i2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP48bitSeq;

  extern function new(string name = "I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP48bitWith48khzTest", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void setupTransmitterAgentConfig();
  extern virtual function void setupReceiverAgentConfig();

endclass : I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP48bitWith48khzTest

function I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP48bitWith48khzTest::new(string name = "I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP48bitWith48khzTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP48bitWith48khzTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive = uvm_active_passive_enum'(UVM_ACTIVE);
   i2sEnvConfig.i2sReceiverAgentConfig.mode  = modeTypeEnum'(RX_MASTER);
   i2sEnvConfig.i2sReceiverAgentConfig.clockratefrequency  = clockrateFrequencyEnum'(KHZ_48);
   i2sEnvConfig.i2sReceiverAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
   i2sEnvConfig.i2sReceiverAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_8_BYTE);
   i2sEnvConfig.i2sReceiverAgentConfig.Sclk=1; 

endfunction:setupReceiverAgentConfig

function void I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP48bitWith48khzTest::setupTransmitterAgentConfig();
  super.setupTransmitterAgentConfig();
     i2sEnvConfig.i2sTransmitterAgentConfig.mode  = modeTypeEnum'(TX_SLAVE);
     i2sEnvConfig.i2sTransmitterAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
     i2sEnvConfig.i2sTransmitterAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_6_BYTE);

endfunction:setupTransmitterAgentConfig


task I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP48bitWith48khzTest::run_phase(uvm_phase phase);

  i2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP48bitSeq = I2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP48bitSeq::type_id::create("i2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP48bitSeq");
  `uvm_info(get_type_name(), $sformatf("Inside run_phase I2sWriteOperationWith24bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP48bitWith48khzTest"), UVM_LOW);
  
  phase.raise_objection(this);
  i2sVirtual24bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP48bitSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
endtask : run_phase

`endif


