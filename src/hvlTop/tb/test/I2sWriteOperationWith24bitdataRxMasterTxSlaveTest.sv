`ifndef I2SWRITEOPERATIONWITH24BITDATARXMASTERTXSLAVETEST_INCLUDED_
`define I2SWRITEOPERATIONWITH24BITDATARXMASTERTXSLAVETEST_INCLUDED_

class I2sWriteOperationWith24bitdataRxMasterTxSlaveTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationWith24bitdataRxMasterTxSlaveTest)

  I2sVirtual24bitWriteOperationRxMasterTxSlaveSeq i2sVirtual24bitWriteOperationRxMasterTxSlaveSeq;

  extern function new(string name = "I2sWriteOperationWith24bitdataRxMasterTxSlaveTest", uvm_component parent = null);
  extern virtual function void setupReceiverAgentConfig();
  extern virtual task run_phase(uvm_phase phase);

endclass : I2sWriteOperationWith24bitdataRxMasterTxSlaveTest

function I2sWriteOperationWith24bitdataRxMasterTxSlaveTest::new(string name = "I2sWriteOperationWith24bitdataRxMasterTxSlaveTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sWriteOperationWith24bitdataRxMasterTxSlaveTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
endfunction: setupReceiverAgentConfig

task I2sWriteOperationWith24bitdataRxMasterTxSlaveTest::run_phase(uvm_phase phase);

  i2sVirtual24bitWriteOperationRxMasterTxSlaveSeq = I2sVirtual24bitWriteOperationRxMasterTxSlaveSeq::type_id::create("i2sVirtual24bitWriteOperationRxMasterTxSlaveSeq");
  `uvm_info(get_type_name(), $sformatf("Inside run_phase I2sWriteOperationWith24bitdataRxMasterTxSlaveTest"), UVM_LOW);
  
  phase.raise_objection(this);
  i2sVirtual24bitWriteOperationRxMasterTxSlaveSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
endtask : run_phase

`endif



