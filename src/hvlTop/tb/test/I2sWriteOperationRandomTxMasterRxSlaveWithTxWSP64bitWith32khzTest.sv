`ifndef I2SWRITEOPERATIONRANDOMTXMASTERRXSLAVEWITHTXWSP64BITWITH32KHZTEST_INCLUDED_
`define I2SWRITEOPERATIONRANDOMTXMASTERRXSLAVEWITHTXWSP64BITWITH32KHZTEST_INCLUDED_

class I2sWriteOperationRandomTxMasterRxSlaveWithTxWSP64bitWith32khzTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationRandomTxMasterRxSlaveWithTxWSP64bitWith32khzTest)

  I2sVirtualRandomWriteOperationTxMasterRxSlaveWithTxWSP64bitSeq i2sVirtualRandomWriteOperationTxMasterRxSlaveWithTxWSP64bitSeq;
  
  extern function new(string name = "I2sWriteOperationRandomTxMasterRxSlaveWithTxWSP64bitWith32khzTest", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void build_phase(uvm_phase phase);
  extern function void setupTransmitterAgentConfig();
  extern function void setupReceiverAgentConfig();

endclass : I2sWriteOperationRandomTxMasterRxSlaveWithTxWSP64bitWith32khzTest

function I2sWriteOperationRandomTxMasterRxSlaveWithTxWSP64bitWith32khzTest::new(string name = "I2sWriteOperationRandomTxMasterRxSlaveWithTxWSP64bitWith32khzTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sWriteOperationRandomTxMasterRxSlaveWithTxWSP64bitWith32khzTest::setupTransmitterAgentConfig();
  super.setupTransmitterAgentConfig();
     i2sEnvConfig.i2sTransmitterAgentConfig.clockratefrequency  = clockrateFrequencyEnum'(KHZ_32);
     i2sEnvConfig.i2sTransmitterAgentConfig.Sclk  = 1; 
     i2sEnvConfig.i2sTransmitterAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
     i2sEnvConfig.i2sTransmitterAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_8_BYTE);

endfunction:setupTransmitterAgentConfig


function void I2sWriteOperationRandomTxMasterRxSlaveWithTxWSP64bitWith32khzTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive     = uvm_active_passive_enum'(UVM_PASSIVE);
   i2sEnvConfig.i2sReceiverAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
   i2sEnvConfig.i2sTransmitterAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_8_BYTE);

endfunction:setupReceiverAgentConfig


function void I2sWriteOperationRandomTxMasterRxSlaveWithTxWSP64bitWith32khzTest::build_phase(uvm_phase phase);
  super.build_phase(phase);
    i2sVirtualRandomWriteOperationTxMasterRxSlaveWithTxWSP64bitSeq =  I2sVirtualRandomWriteOperationTxMasterRxSlaveWithTxWSP64bitSeq::type_id::create(" i2sVirtualRandomWriteOperationTxMasterRxSlaveWithTxWSP64bitSeq",this);
  endfunction : build_phase

task I2sWriteOperationRandomTxMasterRxSlaveWithTxWSP64bitWith32khzTest::run_phase(uvm_phase phase);

  i2sVirtualRandomWriteOperationTxMasterRxSlaveWithTxWSP64bitSeq=I2sVirtualRandomWriteOperationTxMasterRxSlaveWithTxWSP64bitSeq::type_id::create("i2sVirtualRandomWriteOperationTxMasterRxSlaveWithTxWSP64bitSeq");
  `uvm_info(get_type_name(),$sformatf("Inside run_phase I2sWriteOperationRandomTxMasterRxSlaveWithTxWSP64bitWith32khzTest"),UVM_LOW);
  phase.raise_objection(this);
  i2sVirtualRandomWriteOperationTxMasterRxSlaveWithTxWSP64bitSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
  `uvm_info(get_type_name(),$sformatf("Test ended"),UVM_LOW);
endtask : run_phase

`endif




