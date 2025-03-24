`ifndef I2SWRITEOPERATIONWITH32BITDATATXMASTERRXSLAVEWITH192KHZTEST_INCLUDED_
`define I2SWRITEOPERATIONWITH32BITDATATXMASTERRXSLAVEWITH192KHZTEST_INCLUDED_

class I2sWriteOperationWith32bitdataTxMasterRxSlaveWith192khzTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationWith32bitdataTxMasterRxSlaveWith192khzTest)

  I2sVirtual32bitWriteOperationTxMasterRxSlaveSeq i2sVirtual32bitWriteOperationTxMasterRxSlaveSeq;
  
  extern function new(string name = "I2sWriteOperationWith32bitdataTxMasterRxSlaveWith192khzTest", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);
  extern function void setupTransmitterAgentConfig();
  extern function void setupReceiverAgentConfig();
  
endclass : I2sWriteOperationWith32bitdataTxMasterRxSlaveWith192khzTest

function I2sWriteOperationWith32bitdataTxMasterRxSlaveWith192khzTest::new(string name = "I2sWriteOperationWith32bitdataTxMasterRxSlaveWith192khzTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sWriteOperationWith32bitdataTxMasterRxSlaveWith192khzTest::setupTransmitterAgentConfig();
  super.setupTransmitterAgentConfig();
     i2sEnvConfig.i2sTransmitterAgentConfig.clockratefrequency  = clockrateFrequencyEnum'(KHZ_192);
     i2sEnvConfig.i2sTransmitterAgentConfig.Sclk  = 1; 
     i2sEnvConfig.i2sTransmitterAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
     i2sEnvConfig.i2sTransmitterAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_8_BYTE);
          
endfunction:setupTransmitterAgentConfig


function void I2sWriteOperationWith32bitdataTxMasterRxSlaveWith192khzTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive     = uvm_active_passive_enum'(UVM_PASSIVE);
   i2sEnvConfig.i2sReceiverAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
   i2sEnvConfig.i2sReceiverAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_8_BYTE);
   
endfunction:setupReceiverAgentConfig

task I2sWriteOperationWith32bitdataTxMasterRxSlaveWith192khzTest::run_phase(uvm_phase phase);

  i2sVirtual32bitWriteOperationTxMasterRxSlaveSeq=I2sVirtual32bitWriteOperationTxMasterRxSlaveSeq::type_id::create("i2sVirtual32bitWriteOperationTxMasterRxSlaveSeq");
  `uvm_info(get_type_name(),$sformatf("Inside run_phase I2sWriteOperationWith32bitdataTxMasterRxSlaveWith192khzTest"),UVM_LOW);
  phase.raise_objection(this);
  i2sVirtual32bitWriteOperationTxMasterRxSlaveSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
  `uvm_info(get_type_name(),$sformatf("Test ended"),UVM_LOW);
endtask : run_phase

`endif



