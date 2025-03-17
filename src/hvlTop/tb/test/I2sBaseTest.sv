`ifndef I2SBASETEST_INCLUDED_
`define I2SBASETEST_INCLUDED_

class I2sBaseTest extends uvm_test;
  `uvm_component_utils(I2sBaseTest)

  I2sEnv i2sEnv;
  I2sEnvConfig i2sEnvConfig;
  I2sVirtualBaseSeq i2sVirtualBaseSeq;

  extern function new(string name = "I2sBaseTest", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void setupEnvConfig();
  extern virtual function void setupTransmitterAgentConfig();
  extern virtual function void setupReceiverAgentConfig();
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
endclass : I2sBaseTest

function I2sBaseTest::new(string name = "I2sBaseTest",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sBaseTest::build_phase(uvm_phase phase);
  super.build_phase(phase);
  i2sEnvConfig = I2sEnvConfig::type_id::create("i2sEnvConfig");
  i2sEnv = I2sEnv::type_id::create("i2sEnv",this);
  setupEnvConfig();
endfunction
  
function void I2sBaseTest::setupEnvConfig();  
  i2sEnvConfig.hasScoreboard = 1;
  i2sEnvConfig.hasVirtualSequencer = 1;

  uvm_config_db #(I2sEnvConfig)::set(this,"*","I2sEnvConfig",i2sEnvConfig);
  `uvm_info(get_type_name(),$sformatf("i2sEnvConfig = \n %0p", i2sEnvConfig.sprint()),UVM_NONE)
  setupTransmitterAgentConfig();  
  setupReceiverAgentConfig();
endfunction: setupEnvConfig

function void I2sBaseTest::setupTransmitterAgentConfig();
    i2sEnvConfig.i2sTransmitterAgentConfig=I2sTransmitterAgentConfig::type_id::create("I2sTransmitterAgentConfig", this);
    i2sEnvConfig.i2sTransmitterAgentConfig.isActive     = uvm_active_passive_enum'(UVM_ACTIVE);
    i2sEnvConfig.i2sTransmitterAgentConfig.hasCoverage  = hasCoverageEnum'(TRUE);
    i2sEnvConfig.i2sTransmitterAgentConfig.mode  = modeTypeEnum'(TX_MASTER);
    uvm_config_db #(I2sTransmitterAgentConfig)::set(this,"*","I2sTransmitterAgentConfig",i2sEnvConfig.i2sTransmitterAgentConfig);
endfunction: setupTransmitterAgentConfig

function void I2sBaseTest::setupReceiverAgentConfig();
    i2sEnvConfig.i2sReceiverAgentConfig=I2sReceiverAgentConfig::type_id::create("I2sReceiverAgentConfig", this);
    i2sEnvConfig.i2sReceiverAgentConfig.isActive     = uvm_active_passive_enum'(UVM_ACTIVE);
    i2sEnvConfig.i2sReceiverAgentConfig.hasCoverage  = hasCoverageEnum'(TRUE);
    i2sEnvConfig.i2sReceiverAgentConfig.mode  = modeTypeEnum'(RX_SLAVE);
    uvm_config_db #(I2sReceiverAgentConfig)::set(this,"*","I2sReceiverAgentConfig",i2sEnvConfig.i2sReceiverAgentConfig);
endfunction: setupReceiverAgentConfig

function void I2sBaseTest::end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
  uvm_test_done.set_drain_time(this,100ns);
endfunction : end_of_elaboration_phase

task I2sBaseTest::run_phase(uvm_phase phase);
 i2sVirtualBaseSeq = I2sVirtualBaseSeq :: type_id :: create("i2sVirtualBaseSeq");
 $display("base test mode=%d", i2sEnvConfig.i2sTransmitterAgentConfig.mode);
  phase.raise_objection(this);
  i2sVirtualBaseSeq.start(i2sEnv.i2sVirtualSequencer);
  `uvm_info(get_type_name(), $sformatf("Inside I2sBaseTest"), UVM_NONE);
  #10;
  `uvm_info(get_type_name(), $sformatf("Done I2sBaseTest"), UVM_NONE);
  phase.drop_objection(this);

endtask : run_phase
`endif
