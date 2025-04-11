`ifndef I2SWRITEOPERATIONDATATRANSFERERRORTEST_INCLUDED_
`define I2SWRITEOPERATIONDATATRANSFERERRORTEST_INCLUDED_

class I2sWriteOperationDataTransferErrorTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationDataTransferErrorTest)

   I2sVirtualWriteOperationDataTransferErrorSeq  i2sVirtualWriteOperationDataTransferErrorSeq;
  
  extern function new(string name = "I2sWriteOperationDataTransferErrorTest", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void build_phase(uvm_phase phase);
   extern function void setupTransmitterAgentConfig();
  extern function void setupReceiverAgentConfig();

endclass :I2sWriteOperationDataTransferErrorTest

function I2sWriteOperationDataTransferErrorTest::new(string name = "I2sWriteOperationDataTransferErrorTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sWriteOperationDataTransferErrorTest::setupTransmitterAgentConfig();
  super.setupTransmitterAgentConfig();
     i2sEnvConfig.i2sTransmitterAgentConfig.clockratefrequency  = clockrateFrequencyEnum'(KHZ_48);
     i2sEnvConfig.i2sTransmitterAgentConfig.Sclk  = 1; 
     i2sEnvConfig.i2sTransmitterAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
     i2sEnvConfig.i2sTransmitterAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_2_BYTE);
     i2sEnvConfig.i2sTransmitterAgentConfig.dataTransferDirection  = dataTransferDirectionEnum'(LSB_FIRST);

endfunction:setupTransmitterAgentConfig



function void I2sWriteOperationDataTransferErrorTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive     = uvm_active_passive_enum'(UVM_PASSIVE);
   i2sEnvConfig.i2sReceiverAgentConfig.numOfChannels  = numOfChannelsEnum'(STEREO);
   i2sEnvConfig.i2sReceiverAgentConfig.wordSelectPeriod  = wordSelectPeriodEnum'(WS_PERIOD_2_BYTE);

endfunction:setupReceiverAgentConfig


function void I2sWriteOperationDataTransferErrorTest::build_phase(uvm_phase phase);
  super.build_phase(phase);
     i2sVirtualWriteOperationDataTransferErrorSeq=   I2sVirtualWriteOperationDataTransferErrorSeq::type_id::create("i2sVirtualWriteOperationDataTransferErrorSeq");
  endfunction : build_phase

task I2sWriteOperationDataTransferErrorTest::run_phase(uvm_phase phase); 
  super.run_phase(phase);

  `uvm_info(get_type_name(),$sformatf("Inside run_phase I2sWriteOperationDataTransferErrorTest"),UVM_LOW);
  phase.raise_objection(this);
  i2sVirtualWriteOperationDataTransferErrorSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
  `uvm_info(get_type_name(),$sformatf("Test ended"),UVM_LOW);
endtask : run_phase

`endif



