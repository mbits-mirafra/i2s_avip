`ifndef I2SWRITEOPERATIONWITH32BITDATATXMASTERRXSLAVETEST_INCLUDED_
`define I2SWRITEOPERATIONWITH32BITDATATXMASTERRXSLAVETEST_INCLUDED_

class I2sWriteOperationWith32bitdataTxMasterRxSlaveTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationWith32bitdataTxMasterRxSlaveTest)

  I2sVirtual32bitWriteOperationTxMasterRxSlaveSeq i2sVirtual32bitWriteOperationTxMasterRxSlaveSeq;
  
  extern function new(string name = "I2sWriteOperationWith32bitdataTxMasterRxSlaveTest", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void build_phase(uvm_phase phase);
  extern function void setupReceiverAgentConfig();

endclass : I2sWriteOperationWith32bitdataTxMasterRxSlaveTest

function I2sWriteOperationWith32bitdataTxMasterRxSlaveTest::new(string name = "I2sWriteOperationWith32bitdataTxMasterRxSlaveTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sWriteOperationWith32bitdataTxMasterRxSlaveTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive     = uvm_active_passive_enum'(UVM_PASSIVE);
endfunction:setupReceiverAgentConfig


function void I2sWriteOperationWith32bitdataTxMasterRxSlaveTest::build_phase(uvm_phase phase);
  super.build_phase(phase);
    i2sVirtual32bitWriteOperationTxMasterRxSlaveSeq =  I2sVirtual32bitWriteOperationTxMasterRxSlaveSeq::type_id::create(" i2sVirtual32bitWriteOperationTxMasterRxSlaveSeq",this);
  endfunction : build_phase

task I2sWriteOperationWith32bitdataTxMasterRxSlaveTest::run_phase(uvm_phase phase);

  i2sVirtual32bitWriteOperationTxMasterRxSlaveSeq=I2sVirtual32bitWriteOperationTxMasterRxSlaveSeq::type_id::create("i2sVirtual32bitWriteOperationTxMasterRxSlaveSeq");
  `uvm_info(get_type_name(),$sformatf("Inside run_phase I2sWriteOperationWith32bitdataTxMasterRxSlaveTest"),UVM_LOW);
  phase.raise_objection(this);
  i2sVirtual32bitWriteOperationTxMasterRxSlaveSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
  `uvm_info(get_type_name(),$sformatf("Test ended"),UVM_LOW);
endtask : run_phase

`endif



