`ifndef I2SRECEIVERDRIVERBFM_INCLUDED_
`define I2SRECEIVERDRIVERBFM_INCLUDED_
 
import I2sGlobalPkg::*;
 
interface I2sReceiverDriverBFM(input clk, 
                                input rst,
                                input sclkInput,
                                output reg sclkOutput,
                                input wsInput,
                                output reg wsOutput,
                                output reg sd);


    
  import uvm_pkg::*;
  `include "uvm_macros.svh" 
  import I2sReceiverPkg::I2sReceiverDriverProxy;
 
  int clkPeriod;
  int timeoutSclk; 
 

  I2sReceiverDriverProxy i2sReceiverDriverProxy;
string name = "I2sTransmitterDriverBFM";
  initial begin
    $display(name);
  end
 
 task waitForReset();
        @(posedge rst);
         wsOutput <= 1'dx;
         sclkOutput<=1'b0;
         `uvm_info(name,$sformatf("SYSTEM RESET ACTIVATED"),UVM_HIGH)
         @(negedge rst);
         `uvm_info(name,$sformatf("SYSTEM RESET DEACTIVATED"),UVM_HIGH)

  endtask: waitForReset

task drivePacket(inout i2sTransferPacketStruct dataPacketStruct, 
                  input i2sTransferCfgStruct configPacketStruct);

    `uvm_info(name, $sformatf("Starting the drive packet method"), UVM_HIGH);
 if(configPacketStruct.mode == RX_MASTER)
    begin
      fork
      genSclk(dataPacketStruct,configPacketStruct);
      genWs(dataPacketStruct);
    join
    end
  else if(configPacketStruct.mode == RX_SLAVE)
  begin
    `uvm_info(name, $sformatf("Receiver will act as passive agent"), UVM_HIGH);
  end
endtask: drivePacket

 function void sclkPeriod(inout i2sTransferPacketStruct dataStr, input i2sTransferCfgStruct cfgStr );

    cfgStr.sclkFrequency = dataStr.clockratefrequency * dataStr.numOfBitsTransfer * NUM_OF_CHANNEL;
    $display("------------------------Clockfreq=%0d, No_of_bits_Transfer:%0d, No_of_channels:%0d--------------",dataStr.clockratefrequency,dataStr.numOfBitsTransfer,NUM_OF_CHANNEL);
    
    clkPeriod = ((10**9)/cfgStr.sclkFrequency);
   `uvm_info(name, $sformatf("clockperiod=%0d ns",clkPeriod), UVM_NONE)

  endfunction


task genWs(inout i2sTransferPacketStruct dataPacketStruct);
   static int counter=0;
   static int timeout_ws = 2;
   
   `uvm_info(name, $sformatf("IN Receiver DRIVER-Generating the WS"), UVM_NONE)

   
    forever begin
     @(posedge sclkOutput); 

    counter++;
    wsOutput = dataPacketStruct.ws;  
    if (counter == ((dataPacketStruct.wordSelectPeriod/2)+1) ) 
    begin
      dataPacketStruct.ws = ~ dataPacketStruct.ws;
      wsOutput = dataPacketStruct.ws; 
      counter = 1;
      timeout_ws=timeout_ws-1;
    end

    if(timeout_ws==0) begin
      break;
    end
  end
  counter=0;
  timeout_ws=2;
  `uvm_info(name, $sformatf("IN Receiver DRIVER-Generating the WS ended"), UVM_NONE)
 
  endtask: genWs  


task genSclk (inout i2sTransferPacketStruct dataPacketStruct, 
                  input i2sTransferCfgStruct configPacketStruct);
   time target_time;
  `uvm_info(name, $sformatf("IN DRIVER-Generating the Serial clock"), UVM_NONE)

  sclkPeriod(dataPacketStruct, configPacketStruct);  
  timeoutSclk = ((dataPacketStruct.numOfBitsTransfer * 4)+1);
 

target_time = clkPeriod/2;
sclkOutput <= dataPacketStruct.sclk;
forever begin
    @(posedge clk);
    
    if ($time >= target_time) begin
        dataPacketStruct.sclk = ~dataPacketStruct.sclk;
        target_time = $time + clkPeriod/2;  
        timeoutSclk = timeoutSclk -1;
    end
    sclkOutput <= dataPacketStruct.sclk;
    if (timeoutSclk==0) begin
      break;
    end

end
 timeoutSclk = ((dataPacketStruct.numOfBitsTransfer * 4)+1);

   `uvm_info(name, $sformatf("IN DRIVER- Generating the Serial clock end"), UVM_NONE)
endtask: genSclk
    
endinterface : I2sReceiverDriverBFM
`endif
