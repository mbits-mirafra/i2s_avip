class I2sTest extends uvm_test;
  
  `uvm_component_utils(I2sTest)

  I2sEnv i2sEnv;
  I2sEnvConfig i2sEnvConfig;
  I2sTransmitterSeq i2sTransmitterSeq;
  
  extern function new(string name = "I2sTest", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void setupEnvConfig();
  
endclass : I2sTest

function I2sTest::new(string name = "I2sTest",uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sTest::build_phase(uvm_phase phase);
  super.build_phase(phase);
  i2sEnvConfig = I2sEnvConfig::type_id::create("i2sEnvConfig");
  i2sEnv = I2sEnv::type_id::create("i2sEnv",this);
  i2sTransmitterSeq = I2sTransmitterSeq::type_id::create("i2sTransmitterSeq");
  i2sEnvConfig.i2sTransmitterAgentConfig = I2sTransmitterAgentConfig::type_id::create("i2sTransmitterAgentConfig",this);
  i2sEnvConfig.i2sReceiverAgentConfig = I2sReceiverAgentConfig::type_id::create("i2sReceiverAgentConfig",this);
  setupEnvConfig();
  endfunction : build_phase

  function void I2sTest::setupEnvConfig();
     i2sEnvConfig.hasScoreboard = 1;
     i2sEnvConfig.hasVirtualSequencer = 1;
    uvm_config_db #(I2sEnvConfig)::set(this,"*","I2sEnvConfig",i2sEnvConfig);
    uvm_config_db#(I2sReceiverAgentConfig)::set(this, "*", "I2sReceiverAgentConfig", i2sEnvConfig.i2sReceiverAgentConfig);
    uvm_config_db#(I2sTransmitterAgentConfig)::set(this, "*", "I2sTransmitterAgentConfig", i2sEnvConfig.i2sTransmitterAgentConfig);
  endfunction

function void I2sTest::end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
endfunction : end_of_elaboration_phase

task I2sTest::run_phase(uvm_phase phase);

  phase.raise_objection(this, "I2sBaseTest");
  `uvm_info(get_type_name(), $sformatf("Inside I2sBaseTest"), UVM_NONE);
  super.run_phase(phase);
  #10;
  i2sTransmitterSeq.start(i2sEnv.i2sTransmitterAgent.i2sTransmitterSequencer);
  `uvm_info(get_type_name(), $sformatf("Done I2sBaseTest"), UVM_NONE);
  phase.drop_objection(this);

endtask : run_phase

