`ifndef I2SWRITEOPERATIONWITHINVALIDWSPTEST_INCLUDED_
`define I2SWRITEOPERATIONWITHINVALIDWSPTEST_INCLUDED_

class I2sWriteOperationWithInvalidWSPErrorTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationWithInvalidWSPErrorTest)

  
  I2sVirtualWriteOperationWithInvalidWSPErrorSeq i2sVirtualWriteOperationWithInvalidWSPErrorSeq;
  
  extern function new(string name = "I2sWriteOperationWithInvalidWSPErrorTest", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void build_phase(uvm_phase phase);
   extern function void setupTransmitterAgentConfig();
  extern function void setupReceiverAgentConfig();

endclass : I2sWriteOperationWithInvalidWSPErrorTest

function I2sWriteOperationWithInvalidWSPErrorTest::new(string name = "I2sWriteOperationWithInvalidWSPErrorTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sWriteOperationWithInvalidWSPErrorTest::setupTransmitterAgentConfig();
  super.setupTransmitterAgentConfig();
     i2sEnvConfig.i2sTransmitterAgentConfig.clockratefrequency  = clockrateFrequencyEnum'(KHZ_48);
     i2sEnvConfig.i2sTransmitterAgentConfig.Sclk  = 1; 
     i2sEnvConfig.i2sTransmitterAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
     i2sEnvConfig.i2sTransmitterAgentConfig.dataTransferDirection  = dataTransferDirectionEnum'(MSB_FIRST);
     i2sEnvConfig.i2sTransmitterAgentConfig.wordSelectPeriod  =  wordSelectPeriodEnum'(WS_PERIOD_INVALID);

endfunction:setupTransmitterAgentConfig



function void I2sWriteOperationWithInvalidWSPErrorTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive     = uvm_active_passive_enum'(UVM_PASSIVE);
   i2sEnvConfig.i2sReceiverAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
    i2sEnvConfig.i2sReceiverAgentConfig.wordSelectPeriod  =  wordSelectPeriodEnum'(WS_PERIOD_INVALID);


endfunction:setupReceiverAgentConfig


function void I2sWriteOperationWithInvalidWSPErrorTest::build_phase(uvm_phase phase);
  super.build_phase(phase);
    i2sVirtualWriteOperationWithInvalidWSPErrorSeq =  I2sVirtualWriteOperationWithInvalidWSPErrorSeq::type_id::create(" i2sVirtualWriteOperationWithInvalidWSPErrorSeq");
  endfunction : build_phase

task I2sWriteOperationWithInvalidWSPErrorTest::run_phase(uvm_phase phase);
  super.run_phase(phase);

  `uvm_info(get_type_name(),$sformatf("Inside run_phase I2sWriteOperationWith8bitdataTxMasterRxSlaveWith48khzTest"),UVM_LOW);
  phase.raise_objection(this);
  i2sVirtualWriteOperationWithInvalidWSPErrorSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
  `uvm_info(get_type_name(),$sformatf("Test ended"),UVM_LOW);

endtask : run_phase

`endif


