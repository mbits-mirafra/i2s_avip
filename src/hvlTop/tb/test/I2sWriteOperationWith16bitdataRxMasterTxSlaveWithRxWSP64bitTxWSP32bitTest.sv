`ifndef I2SWRITEOPERATIONWITH16BITDATARXMASTERTXSLAVEWITHRXWSP64BITTXWSP32BITTEST_INCLUDED_
`define I2SWRITEOPERATIONWITH16BITDATARXMASTERTXSLAVEWITHRXWSP64BITTXWSP32BITTEST_INCLUDED_

class I2sWriteOperationWith16bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP32bitTest extends I2sBaseTest; 
  `uvm_component_utils(I2sWriteOperationWith16bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP32bitTest)

  I2sVirtual16bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP32bitSeq i2sVirtual16bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP32bitSeq;

  extern function new(string name = "I2sWriteOperationWith16bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP32bitTest", uvm_component parent = null);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void setupTransmitterAgentConfig();
  extern virtual function void setupReceiverAgentConfig();


endclass : I2sWriteOperationWith16bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP32bitTest

function I2sWriteOperationWith16bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP32bitTest::new(string name = "I2sWriteOperationWith16bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP32bitTest", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sWriteOperationWith16bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP32bitTest::setupReceiverAgentConfig();
  super.setupReceiverAgentConfig();
   i2sEnvConfig.i2sReceiverAgentConfig.isActive = uvm_active_passive_enum'(UVM_ACTIVE);
  i2sEnvConfig.i2sReceiverAgentConfig.mode  = modeTypeEnum'(RX_MASTER);
endfunction:setupReceiverAgentConfig

function void I2sWriteOperationWith16bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP32bitTest::setupTransmitterAgentConfig();
  super.setupTransmitterAgentConfig();
     i2sEnvConfig.i2sTransmitterAgentConfig.mode  = modeTypeEnum'(TX_SLAVE);
endfunction:setupTransmitterAgentConfig

task I2sWriteOperationWith16bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP32bitTest::run_phase(uvm_phase phase);

  i2sVirtual16bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP32bitSeq = I2sVirtual16bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP32bitSeq::type_id::create("i2sVirtual16bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP32bitSeq");
  `uvm_info(get_type_name(), $sformatf("Inside run_phase I2sWriteOperationWith16bitdataRxMasterTxSlaveWithRxWSP64bitTxWSP32bitTest"), UVM_LOW);
  
  phase.raise_objection(this);
  i2sVirtual16bitWriteOperationRxMasterTxSlaveWithRxWSP64bitTxWSP32bitSeq.start(i2sEnv.i2sVirtualSequencer);
  #10;
  phase.drop_objection(this);
endtask : run_phase

`endif


