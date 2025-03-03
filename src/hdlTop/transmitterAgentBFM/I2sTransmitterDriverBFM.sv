`ifndef I2STRANSMITTERDRIVERBFM_INCLUDED_
`define I2STRANSMITTERDRIVERBFM_INCLUDED_

import I2sGlobalPkg::*;

interface I2sTransmitterDriverBFM(input clk, 
                                input rst,
                                input sclkInput,
                                output reg sclkOutput,
                                input wsInput,
                                output reg wsOutput,
                                output reg sd);
    int clkPeriod;
    int timeoutSclk;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  import I2sTransmitterPkg::I2sTransmitterDriverProxy;

  I2sTransmitterDriverProxy i2sTransmitterDriverProxy;
  
  string name = "I2sTransmitterDriverBFM";
  initial begin
    $display(name);
  end

  task waitForReset();
        @(posedge rst);
         sd <= 1'b0;
         wsOutput <= 1'bx;
         sclkOutput<=1'b0;
         `uvm_info(name,$sformatf("SYSTEM RESET ACTIVATED"),UVM_NONE)
         @(negedge rst);
         `uvm_info(name,$sformatf("SYSTEM RESET DEACTIVATED"),UVM_NONE)

  endtask: waitForReset

  

  task driveData(inout i2sTransferPacketStruct dataPacketStruct, 
                 input i2sTransferCfgStruct configPacketStruct);

    `uvm_info(name, $sformatf("IN DRIVER- Starting the drive data method mode=%d",configPacketStruct.mode), UVM_NONE);

    if(configPacketStruct.mode == TX_MASTER)

    begin

      fork
      genSclk(dataPacketStruct,configPacketStruct);
      
      genWs(dataPacketStruct);
     
      repeat(2) 
        begin
          if(dataPacketStruct.ws==1'b1) 
            begin
            `uvm_info(name, $sformatf("IN DRIVER- Driving data from left channel"), UVM_NONE);

            for(int i=0; i<dataPacketStruct.numOfBitsTransfer/DATA_WIDTH;i++) 
              begin
              driveSdWhenTxMaster(dataPacketStruct.sd[i]);
             end
          end

        else
           begin
            `uvm_info(name, $sformatf("IN DRIVER- Driving data from Right channel"), UVM_NONE);

            for(int i=0; i<dataPacketStruct.numOfBitsTransfer/DATA_WIDTH;i++) begin
              driveSdWhenTxMaster(dataPacketStruct.sd[i]);
            end
          end
        end
    join

  end

    
    else if(configPacketStruct.mode == TX_SLAVE)
    begin
      initialDetectWsfromUnknown(); 
      repeat(2)
       begin
      	detectWsToggleAndDriveSdWhenTxSlave(dataPacketStruct);
       end
 
   end  

  endtask: driveData

 task initialDetectWsfromUnknown();
     logic [1:0] wsLocal;

  if (wsInput===1'bx)
   begin
      $display("................IN DRIVER- In detect WS task before WS change from unknown............., WS= %0d at %0t",wsInput,$time);

      wsLocal <= 2'b01;
      do begin
        @(posedge sclkInput);

       wsLocal = {wsLocal[0], wsInput};
      end while (wsLocal===2'b1x);
    end
     $display("................IN DRIVER-In detect WS task after WS change from unknown............., WS= %0d at %0t",wsInput,$time);
     
 
  endtask: initialDetectWsfromUnknown

  task detectWsToggleAndDriveSdWhenTxSlave(inout i2sTransferPacketStruct dataPacketStruct);
   bit [1:0] wsLocal;
   if(wsInput == 1) begin
      wsLocal = 2'b11;
     do begin

         `uvm_info(name, $sformatf("IN DRIVER- Driving data from left channel"), UVM_NONE);

      for(int i=0; i<MAXIMUM_SIZE;i++) 
      begin
         driveSerialDataTxSlave(dataPacketStruct.sd[i]);
         if(wsInput!=1)
           break;
      
      end
       wsLocal = {wsLocal[0], wsInput}; 
     end while((wsLocal == 2'b11) );

   end
    
     else begin
        wsLocal = 2'b00;
     do begin

      for(int i=0; i<MAXIMUM_SIZE;i++) 
      begin
         driveSerialDataTxSlave(dataPacketStruct.sd[i]);
 
         if(wsInput!=0)
           break;
      
      end

       wsLocal = {wsLocal[0], wsInput};
     end while((wsLocal == 2'b00) );
   
    end
    
  endtask: detectWsToggleAndDriveSdWhenTxSlave


 function void sclkPeriod(inout i2sTransferPacketStruct dataStr, input i2sTransferCfgStruct cfgStr );
    
    cfgStr.sclkFrequency = dataStr.clockratefrequency * dataStr.numOfBitsTransfer *NUM_OF_CHANNEL;

    
    clkPeriod = ((10**9)/cfgStr.sclkFrequency);

    `uvm_info(name, $sformatf("clockperiod=%0d ns",clkPeriod), UVM_NONE)
       
  endfunction

  task genWs(inout i2sTransferPacketStruct dataPacketStruct);
   static int counter=0;
   static int timeout_ws = 2;
   
   `uvm_info(name, $sformatf("IN DRIVER-Generating the WS"), UVM_NONE)

  $display("wsp=%0d",dataPacketStruct.wordSelectPeriod); 
   
    forever begin
     @(posedge sclkOutput);  
    counter++;
    wsOutput <= dataPacketStruct.ws;  
    if (counter == (dataPacketStruct.wordSelectPeriod/2)+1 ) 
    begin
      dataPacketStruct.ws = ~ dataPacketStruct.ws;
      counter = 1;
      timeout_ws=timeout_ws-1;
    end
     wsOutput <= dataPacketStruct.ws; 

    if(timeout_ws==0) begin
      break;
    end
  end
  counter=0;
  timeout_ws=2;
  `uvm_info(name, $sformatf("IN DRIVER-Generating the WS ended"), UVM_NONE)
  endtask: genWs                
   
 task genSclk (inout i2sTransferPacketStruct dataPacketStruct, 
               input i2sTransferCfgStruct configPacketStruct);
  
     time target_time;
    `uvm_info(name, $sformatf("IN DRIVER-Generating the Serial clock"), UVM_NONE)
 
  
    sclkPeriod(dataPacketStruct, configPacketStruct);  
    $display("IN DRIVER-inside gen sclk task clockPeriod=%0d",clkPeriod);

    timeoutSclk = ((dataPacketStruct.numOfBitsTransfer * 4)+1); 
   
    target_time = clkPeriod/2;
    sclkOutput <= dataPacketStruct.sclk;
    forever begin
    @(posedge clk);
    
    if ($time >= target_time) begin
        dataPacketStruct.sclk = ~dataPacketStruct.sclk;
        target_time = $time + clkPeriod/2;  // Set next toggle time
        timeoutSclk = timeoutSclk -1;
    end
    sclkOutput <= dataPacketStruct.sclk;
    if (timeoutSclk==0) begin
      break;
     end

   end
  `uvm_info(name, $sformatf("IN DRIVER- Generating the Serial clock end"), UVM_NONE)
  endtask: genSclk

  task driveSdWhenTxMaster(input bit[7:0] serialdata);
    `uvm_info("DEBUG", $sformatf("IN DRIVER- Driving SerialData = %b",serialdata), UVM_NONE)

    for(int k=0; k<DATA_WIDTH; k++) begin
      static int bit_no=0;
      bit_no = (DATA_WIDTH - 1) - k;
      @(posedge sclkOutput)
        sd <= serialdata[bit_no];
      //`uvm_info("DEBUG", $sformatf("IN DRIVER- Driving Serial data[%0d] = %b",bit_no, sd), UVM_NONE)
    end
    `uvm_info(name, $sformatf("IN DRIVER- Generating serial data end"), UVM_NONE)
  endtask: driveSdWhenTxMaster

  task driveSerialDataTxSlave(input bit[7:0] serialdata);
    `uvm_info("DEBUG", $sformatf("IN DRIVER- Driving SerialData = %b",serialdata), UVM_NONE)
    
    for(int k=0; k<DATA_WIDTH; k++) begin
      static int bit_no=0;
      bit_no = (DATA_WIDTH - 1) - k;
     sd <= serialdata[bit_no];
    `uvm_info("DEBUG", $sformatf("IN DRIVER- Driving Serial data[%0d] = %b",bit_no, sd), UVM_NONE)

          @(posedge sclkInput );
    end
    `uvm_info(name, $sformatf("IN DRIVER- Generating serial data end"), UVM_NONE)
  endtask: driveSerialDataTxSlave


endinterface : I2sTransmitterDriverBFM
`endif
