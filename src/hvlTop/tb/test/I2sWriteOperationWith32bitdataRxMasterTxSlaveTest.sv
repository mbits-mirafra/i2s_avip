`ifndef I2SWRITEOPERATIONWITH32BITDATARXMASTERTXSLAVETEST_INCLUDED_
`define I2SWRITEOPERATIONWITH32BITDATARXMASTERTXSLAVETEST_INCLUDED_

class I2sWriteOperationWith32bitdataRxMasterTxSlaveTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationWith32bitdataRxMasterTxSlaveTest)

  I2sVirtual32bitWriteOperationRxMasterTxSlaveSeq i2sVirtual32bitWriteOperationRxMasterTxSlaveSeq;

  extern function new(string name = "I2sWriteOperationWith32bitdataRxMasterTxSlaveTest", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);

endclass : I2sWriteOperationWith32bitdataRxMasterTxSlaveTest

function I2sWriteOperationWith32bitdataRxMasterTxSlaveTest::new(string name = "I2sWriteOperationWith32bitdataRxMasterTxSlaveTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new


task I2sWriteOperationWith32bitdataRxMasterTxSlaveTest::run_phase(uvm_phase phase);

  i2sVirtual32bitWriteOperationRxMasterTxSlaveSeq = I2sVirtual32bitWriteOperationRxMasterTxSlaveSeq::type_id::create("i2sVirtual32bitWriteOperationRxMasterTxSlaveSeq");
  `uvm_info(get_type_name(), $sformatf("Inside run_phase I2sWriteOperationWith32bitdataRxMasterTxSlaveTest"), UVM_LOW);
  
  phase.raise_objection(this);
  i2sVirtual32bitWriteOperationRxMasterTxSlaveSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
endtask : run_phase

`endif



