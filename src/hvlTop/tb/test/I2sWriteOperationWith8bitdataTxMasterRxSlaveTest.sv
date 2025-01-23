`ifndef I2SWRITEOPERATIONWITH8BITDATATXMASTERRXSLAVETEST_INCLUDED_
`define I2SWRITEOPERATIONWITH8BITDATATXMASTERRXSLAVETEST_INCLUDED_

class I2sWriteOperationWith8bitdataTxMasterRxSlaveTest extends I2sBaseTest;
  `uvm_component_utils(I2sWriteOperationWith8bitdataTxMasterRxSlaveTest)

  I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq i2sVirtual8bitWriteOperationTxMasterRxSlaveSeq;
  
  extern function new(string name = "I2sWriteOperationWith8bitdataTxMasterRxSlaveTest", uvm_component parent = null);
  extern function void setupI2sEnvConfig();
  extern virtual task run_phase(uvm_phase phase);

endclass : I2sWriteOperationWith8bitdataTxMasterRxSlaveTest

function I2sWriteOperationWith8bitdataTxMasterRxSlaveTest::new(string name = "I2sWriteOperationWith8bitdataTxMasterRxSlaveTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sWriteOperationWith8bitdataTxMasterRxSlaveTest::setupI2sEnvConfig();
 super.setupI2sEnvConfig();
  //i2sEnvConfig.transactionType = I2sGlobalPackage::WRITE;
  i2sEnvConfig.masterMode = I2sGlobalPackage::TX_MASTER;   
  i2sEnvConfig.slaveMode = I2sGlobalPackage::RX_SLAVE;     
endfunction : setupI2sEnvConfig

task I2sWriteOperationWith8bitdataTxMasterRxSlaveTest::run_phase(uvm_phase phase);

  i2sVirtual8bitWriteOperationTxMasterRxSlaveSeq=I2sVirtual8bitWriteOperationTxMasterRxSlaveSeq::type_id::create("i2sVirtual8bitWriteOperationTxMasterRxSlaveSeq");
  `uvm_info(get_type_name(),$sformatf("Inside run_phase I2sWriteOperationWith8bitdataTxMasterRxSlaveTest"),UVM_LOW);
    phase.raise_objection(this);
    i2sVirtual8bitWriteOperationTxMasterRxSlaveSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);

endtask : run_phase

`endif


