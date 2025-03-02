`ifndef I2SWRITEOPERATIONWITH32BITDATARXMASTERTXSLAVEWITHRXWSP48BITTXWSP64BITTEST_INCLUDED_
`define I2SWRITEOPERATIONWITH32BITDATARXMASTERTXSLAVEWITHRXWSP48BITTXWSP64BITTEST_INCLUDED_

class I2sWriteOperationWith32bitdataRxMasterTxSlaveWithRxWSP48bitTxWSP64bitTest extends I2sBaseTest; 
  `uvm_component_utils(I2sWriteOperationWith32bitdataRxMasterTxSlaveWithRxWSP48bitTxWSP64bitTest)

  I2sVirtual32bitWriteOperationRxMasterTxSlaveWithRxWSP48bitTxWSP64bitSeq i2sVirtual32bitWriteOperationRxMasterTxSlaveWithRxWSP48bitTxWSP64bitSeq;

  extern function new(string name = "I2sWriteOperationWith32bitdataRxMasterTxSlaveWithRxWSP48bitTxWSP64bitTest", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void setupTransmitterAgentConfig();
  extern virtual function void setupReceiverAgentConfig();


endclass : I2sWriteOperationWith32bitdataRxMasterTxSlaveWithRxWSP48bitTxWSP64bitTest

function I2sWriteOperationWith32bitdataRxMasterTxSlaveWithRxWSP48bitTxWSP64bitTest::new(string name = "I2sWriteOperationWith32bitdataRxMasterTxSlaveWithRxWSP48bitTxWSP64bitTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new


function void I2sWriteOperationWith32bitdataRxMasterTxSlaveWithRxWSP48bitTxWSP64bitTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive = uvm_active_passive_enum'(UVM_ACTIVE);
  i2sEnvConfig.i2sReceiverAgentConfig.mode  = modeTypeEnum'(RX_MASTER);
endfunction:setupReceiverAgentConfig

function void I2sWriteOperationWith32bitdataRxMasterTxSlaveWithRxWSP48bitTxWSP64bitTest::setupTransmitterAgentConfig();
  super.setupTransmitterAgentConfig();
     i2sEnvConfig.i2sTransmitterAgentConfig.mode  = modeTypeEnum'(TX_SLAVE);
endfunction:setupTransmitterAgentConfig




task I2sWriteOperationWith32bitdataRxMasterTxSlaveWithRxWSP48bitTxWSP64bitTest::run_phase(uvm_phase phase);

  i2sVirtual32bitWriteOperationRxMasterTxSlaveWithRxWSP48bitTxWSP64bitSeq = I2sVirtual32bitWriteOperationRxMasterTxSlaveWithRxWSP48bitTxWSP64bitSeq::type_id::create("i2sVirtual32bitWriteOperationRxMasterTxSlaveWithRxWSP48bitTxWSP64bitSeq");
  `uvm_info(get_type_name(), $sformatf("Inside run_phase I2sWriteOperationWith32bitdataRxMasterTxSlaveWithRxWSP48bitTxWSP64bitTest"), UVM_LOW);
  
  phase.raise_objection(this);
  i2sVirtual32bitWriteOperationRxMasterTxSlaveWithRxWSP48bitTxWSP64bitSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
endtask : run_phase

`endif



