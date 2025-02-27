`ifndef I2SWRITEOPERATIONWITH8BITDATATXMASTERRXSLAVETEST_INCLUDED_
`define I2SWRITEOPERATIONWITH8BITDATATXMASTERRXSLAVETEST_INCLUDED_

class I2sWriteOperationWith8bitdataTxMasterRxSlaveTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationWith8bitdataTxMasterRxSlaveTest)

  I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq i2sVirtual8bitWriteOperationTxMasterRxSlaveSeq;
  
  extern function new(string name = "I2sWriteOperationWith8bitdataTxMasterRxSlaveTest", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void build_phase(uvm_phase phase);
  extern function void setupReceiverAgentConfig();

endclass : I2sWriteOperationWith8bitdataTxMasterRxSlaveTest

function I2sWriteOperationWith8bitdataTxMasterRxSlaveTest::new(string name = "I2sWriteOperationWith8bitdataTxMasterRxSlaveTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sWriteOperationWith8bitdataTxMasterRxSlaveTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive     = uvm_active_passive_enum'(UVM_PASSIVE);
endfunction:setupReceiverAgentConfig


function void I2sWriteOperationWith8bitdataTxMasterRxSlaveTest::build_phase(uvm_phase phase);
  super.build_phase(phase);
    i2sVirtual8bitWriteOperationTxMasterRxSlaveSeq =  I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq::type_id::create(" i2sVirtual8bitWriteOperationTxMasterRxSlaveSeq",this);
  endfunction : build_phase

task I2sWriteOperationWith8bitdataTxMasterRxSlaveTest::run_phase(uvm_phase phase);

  i2sVirtual8bitWriteOperationTxMasterRxSlaveSeq=I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq::type_id::create("i2sVirtual8bitWriteOperationTxMasterRxSlaveSeq");
  `uvm_info(get_type_name(),$sformatf("Inside run_phase I2sWriteOperationWith8bitdataTxMasterRxSlaveTest"),UVM_LOW);
  phase.raise_objection(this);
  i2sVirtual8bitWriteOperationTxMasterRxSlaveSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
  `uvm_info(get_type_name(),$sformatf("Test ended"),UVM_LOW);
endtask : run_phase

`endif


