`ifndef I2SWRITEOPERATIONWITH24BITDATATXMASTERRXSLAVETEST_INCLUDED_
`define I2SWRITEOPERATIONWITH24BITDATATXMASTERRXSLAVETEST_INCLUDED_

class I2sWriteOperationWith24bitdataTxMasterRxSlaveTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationWith24bitdataTxMasterRxSlaveTest)

  I2sVirtual24bitWriteOperationTxMasterRxSlaveSeq i2sVirtual24bitWriteOperationTxMasterRxSlaveSeq;
  
  extern function new(string name = "I2sWriteOperationWith24bitdataTxMasterRxSlaveTest", uvm_component parent = null);
  extern virtual function void setupReceiverAgentConfig(); 
  extern virtual task run_phase(uvm_phase phase);

endclass : I2sWriteOperationWith24bitdataTxMasterRxSlaveTest

function I2sWriteOperationWith24bitdataTxMasterRxSlaveTest::new(string name = "I2sWriteOperationWith24bitdataTxMasterRxSlaveTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new


function void I2sWriteOperationWith24bitdataTxMasterRxSlaveTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
  i2sEnvConfig.i2sReceiverAgentConfig.isActive = uvm_active_passive_enum'(UVM_PASSIVE);
endfunction: setupReceiverAgentConfig


task I2sWriteOperationWith24bitdataTxMasterRxSlaveTest::run_phase(uvm_phase phase);

  i2sVirtual24bitWriteOperationTxMasterRxSlaveSeq=I2sVirtual24bitWriteOperationTxMasterRxSlaveSeq::type_id::create("i2sVirtual24bitWriteOperationTxMasterRxSlaveSeq");
  `uvm_info(get_type_name(),$sformatf("Inside run_phase I2sWriteOperationWith24bitdataTxMasterRxSlaveTest"),UVM_LOW);
    phase.raise_objection(this);
    i2sVirtual24bitWriteOperationTxMasterRxSlaveSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);

endtask : run_phase

`endif


