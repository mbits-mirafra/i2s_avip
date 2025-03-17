`ifndef I2SWRITEOPERATIONWITH8BITDATATXMASTERRXSLAVEWITH48KHZTEST_INCLUDED_
`define I2SWRITEOPERATIONWITH8BITDATATXMASTERRXSLAVEWITH48KHZTEST_INCLUDED_

class I2sWriteOperationWith8bitdataTxMasterRxSlaveWith48khzTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationWith8bitdataTxMasterRxSlaveWith48khzTest)

  I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq i2sVirtual8bitWriteOperationTxMasterRxSlaveSeq;
  
  extern function new(string name = "I2sWriteOperationWith8bitdataTxMasterRxSlaveWith48khzTest", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void build_phase(uvm_phase phase);
   extern function void setupTransmitterAgentConfig();
  extern function void setupReceiverAgentConfig();

endclass : I2sWriteOperationWith8bitdataTxMasterRxSlaveWith48khzTest

function I2sWriteOperationWith8bitdataTxMasterRxSlaveWith48khzTest::new(string name = "I2sWriteOperationWith8bitdataTxMasterRxSlaveWith48khzTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sWriteOperationWith8bitdataTxMasterRxSlaveWith48khzTest::setupTransmitterAgentConfig();
  super.setupTransmitterAgentConfig();
     i2sEnvConfig.i2sTransmitterAgentConfig.clockratefrequency  = clockrateFrequencyEnum'(KHZ_48);
     i2sEnvConfig.i2sTransmitterAgentConfig.numOfBitsTransfer  = numOfBitsTransferEnum'(BITS_8); 
     i2sEnvConfig.i2sTransmitterAgentConfig.Sclk  = 1; 
          
endfunction:setupTransmitterAgentConfig



function void I2sWriteOperationWith8bitdataTxMasterRxSlaveWith48khzTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive     = uvm_active_passive_enum'(UVM_PASSIVE);
   i2sEnvConfig.i2sReceiverAgentConfig.numOfBitsTransfer  = numOfBitsTransferEnum'(BITS_8); 

endfunction:setupReceiverAgentConfig


function void I2sWriteOperationWith8bitdataTxMasterRxSlaveWith48khzTest::build_phase(uvm_phase phase);
  super.build_phase(phase);
    i2sVirtual8bitWriteOperationTxMasterRxSlaveSeq =  I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq::type_id::create(" i2sVirtual8bitWriteOperationTxMasterRxSlaveSeq",this);
  endfunction : build_phase

task I2sWriteOperationWith8bitdataTxMasterRxSlaveWith48khzTest::run_phase(uvm_phase phase);

  i2sVirtual8bitWriteOperationTxMasterRxSlaveSeq=I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq::type_id::create("i2sVirtual8bitWriteOperationTxMasterRxSlaveSeq");
  `uvm_info(get_type_name(),$sformatf("Inside run_phase I2sWriteOperationWith8bitdataTxMasterRxSlaveWith48khzTest"),UVM_LOW);
  phase.raise_objection(this);
  i2sVirtual8bitWriteOperationTxMasterRxSlaveSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
  `uvm_info(get_type_name(),$sformatf("Test ended"),UVM_LOW);
endtask : run_phase

`endif


