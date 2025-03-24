`ifndef I2SINTERFACE_INCLUDED_
`define I2SINTERFACE_INCLUDED_

import I2sGlobalPkg::*;
interface I2sInterface(input bit clk,input bit rst);

  logic sclk;
  logic ws;
  logic sd;
  
  logic wsInput;
  logic wsOutput;
  logic sclkInput;
  logic sclkOutput;
 
  import uvm_pkg::*;
  `include "uvm_macros.svh";

  import I2sTransmitterPkg::I2sTransmitterAgentConfig;
  import I2sReceiverPkg::I2sReceiverAgentConfig;

  I2sTransmitterAgentConfig i2sTransmitterAgentConfig;
  I2sReceiverAgentConfig i2sReceiverAgentConfig;


  initial begin
    start_of_simulation_ph.wait_for_state(UVM_PHASE_STARTED);
 
    if(!uvm_config_db#(I2sTransmitterAgentConfig)::get(null, "*", "I2sTransmitterAgentConfig",i2sTransmitterAgentConfig)) begin
    `uvm_fatal("FATAL_TRANSMITTER_CANNOT_GET_IN_INTERFACE","cannot get() i2sTransmitterAgentConfig"); 
    end

    forever begin
      if(i2sTransmitterAgentConfig.mode == TX_MASTER) begin
        sclk <= sclkOutput;
        ws <= wsOutput;
      end
      else begin
        sclkInput <= sclk;
        wsInput <= ws;
      end
      @(posedge clk);
    end
  end

  initial begin
    start_of_simulation_ph.wait_for_state(UVM_PHASE_STARTED);
 
    if(!uvm_config_db#(I2sReceiverAgentConfig)::get(null, "*", "I2sReceiverAgentConfig",i2sReceiverAgentConfig)) begin
    `uvm_fatal("FATAL_RECEIVER_CANNOT_GET_IN_INTERFACE","cannot get() i2sReceiverAgentConfig"); 
    end

    forever begin
      if(i2sReceiverAgentConfig.mode == RX_MASTER) begin
        sclk <= sclkOutput;
        ws <= wsOutput;
      end
      else begin
        sclkInput <= sclk;
        wsInput <= ws;
      end
      @(posedge clk);
    end
  end

endinterface:I2sInterface
 
`endif
