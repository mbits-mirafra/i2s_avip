`ifndef I2SBASETEST_INCLUDED_
`define I2SBASETEST_INCLUDED_

class I2sBaseTest extends uvm_test;
  `uvm_component_utils(I2sBaseTest)

  I2sEnv i2sEnv;
  I2sEnvConfig i2sEnvConfig;

  extern function new(string name = "I2sBaseTest", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
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
  endfunction : build_phase

function void I2sBaseTest::end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
endfunction : end_of_elaboration_phase

task I2sBaseTest::run_phase(uvm_phase phase);

  phase.raise_objection(this, "I2sBaseTest");
  `uvm_info(get_type_name(), $sformatf("Inside I2sBaseTest"), UVM_NONE);
  super.run_phase(phase);
  #100;
  `uvm_info(get_type_name(), $sformatf("Done I2sBaseTest"), UVM_NONE);
  phase.drop_objection(this);

endtask : run_phase
`endif
