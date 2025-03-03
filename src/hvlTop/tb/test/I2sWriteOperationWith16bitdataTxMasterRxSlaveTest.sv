`ifndef I2SWRITEOPERATIONWITH16BITDATATXMASTERRXSLAVETEST_INCLUDED_
`define I2SWRITEOPERATIONWITH16BITDATATXMASTERRXSLAVETEST_INCLUDED_

class I2sWriteOperationWith16bitdataTxMasterRxSlaveTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationWith16bitdataTxMasterRxSlaveTest)

  I2sVirtual16bitWriteOperationTxMasterRxSlaveSeq i2sVirtual16bitWriteOperationTxMasterRxSlaveSeq;
  
  extern function new(string name = "I2sWriteOperationWith16bitdataTxMasterRxSlaveTest", uvm_component parent = null);
  extern virtual function void setupReceiverAgentConfig(); 
  extern virtual task run_phase(uvm_phase phase);

endclass : I2sWriteOperationWith16bitdataTxMasterRxSlaveTest

function I2sWriteOperationWith16bitdataTxMasterRxSlaveTest::new(string name = "I2sWriteOperationWith16bitdataTxMasterRxSlaveTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new


function void I2sWriteOperationWith16bitdataTxMasterRxSlaveTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
  i2sEnvConfig.i2sReceiverAgentConfig.isActive = uvm_active_passive_enum'(UVM_PASSIVE);
endfunction: setupReceiverAgentConfig


task I2sWriteOperationWith16bitdataTxMasterRxSlaveTest::run_phase(uvm_phase phase);

  i2sVirtual16bitWriteOperationTxMasterRxSlaveSeq=I2sVirtual16bitWriteOperationTxMasterRxSlaveSeq::type_id::create("i2sVirtual16bitWriteOperationTxMasterRxSlaveSeq");
  `uvm_info(get_type_name(),$sformatf("Inside run_phase I2sWriteOperationWith16bitdataTxMasterRxSlaveTest"),UVM_LOW);
    phase.raise_objection(this);
    i2sVirtual16bitWriteOperationTxMasterRxSlaveSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);

endtask : run_phase

`endif



