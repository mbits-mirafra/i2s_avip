`ifndef I2SWRITEOPERATIONWITH24BITDATATXMASTERRXSLAVEWITH24KHZTEST_INCLUDED_
`define I2SWRITEOPERATIONWITH24BITDATATXMASTERRXSLAVEWITH24KHZTEST_INCLUDED_

class I2sWriteOperationWith24bitdataTxMasterRxSlaveWith24khzTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationWith24bitdataTxMasterRxSlaveWith24khzTest)

  I2sVirtual24bitWriteOperationTxMasterRxSlaveSeq i2sVirtual24bitWriteOperationTxMasterRxSlaveSeq;
  
  extern function new(string name = "I2sWriteOperationWith24bitdataTxMasterRxSlaveWith24khzTest", uvm_component parent = null);
  extern function void setupTransmitterAgentConfig();
  extern function void setupReceiverAgentConfig();
  extern virtual task run_phase(uvm_phase phase);

endclass : I2sWriteOperationWith24bitdataTxMasterRxSlaveWith24khzTest

function I2sWriteOperationWith24bitdataTxMasterRxSlaveWith24khzTest::new(string name = "I2sWriteOperationWith24bitdataTxMasterRxSlaveWith24khzTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new


function void I2sWriteOperationWith24bitdataTxMasterRxSlaveWith24khzTest::setupTransmitterAgentConfig();
  super.setupTransmitterAgentConfig();
     i2sEnvConfig.i2sTransmitterAgentConfig.clockratefrequency  = clockrateFrequencyEnum'(KHZ_24);
     i2sEnvConfig.i2sTransmitterAgentConfig.Sclk  = 1; 
     i2sEnvConfig.i2sTransmitterAgentConfig.numOfChannels  = numOfChannelsEnum'(MONO);
     i2sEnvConfig.i2sTransmitterAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_6_BYTE);
          
endfunction:setupTransmitterAgentConfig


function void I2sWriteOperationWith24bitdataTxMasterRxSlaveWith24khzTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive     = uvm_active_passive_enum'(UVM_PASSIVE);
   i2sEnvConfig.i2sReceiverAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
   i2sEnvConfig.i2sReceiverAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_6_BYTE);
  
 endfunction:setupReceiverAgentConfig


task I2sWriteOperationWith24bitdataTxMasterRxSlaveWith24khzTest::run_phase(uvm_phase phase);

  i2sVirtual24bitWriteOperationTxMasterRxSlaveSeq=I2sVirtual24bitWriteOperationTxMasterRxSlaveSeq::type_id::create("i2sVirtual24bitWriteOperationTxMasterRxSlaveSeq");
  `uvm_info(get_type_name(),$sformatf("Inside run_phase I2sWriteOperationWith24bitdataTxMasterRxSlaveWith24khzTest"),UVM_LOW);
    phase.raise_objection(this);
    i2sVirtual24bitWriteOperationTxMasterRxSlaveSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);

endtask : run_phase

`endif


