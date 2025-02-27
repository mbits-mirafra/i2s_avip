`ifndef I2SSCOREBOARD_INCLUDED_
`define I2SSCOREBOARD_INCLUDED_

class I2sScoreboard extends uvm_component;
 `uvm_component_utils(I2sScoreboard)

  I2sTransmitterTransaction i2sTransmitterTransaction;
  I2sReceiverTransaction i2sReceiverTransaction;
  I2sEnvConfig i2sEnvConfig;

  uvm_tlm_analysis_fifo#(I2sTransmitterTransaction)i2sTransmitterAnalysisFIFO;
  uvm_tlm_analysis_fifo#(I2sReceiverTransaction)i2sReceiverAnalysisFIFO;

  int serialDataComparisonSuccessCount;
  int serialDataComparisonFailedCount;
  
  extern function new(string name = "I2sScoreboard", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase (uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void check_phase (uvm_phase phase);
  extern virtual task  dataComparison();
endclass : I2sScoreboard


function I2sScoreboard::new(string name = "I2sScoreboard", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

function void I2sScoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
  i2sTransmitterAnalysisFIFO=new("i2sTransmitterAnalysisFIFO",this);
  i2sReceiverAnalysisFIFO=new("i2sReceiverAnalysisFIFO",this);

  if(!uvm_config_db #(I2sEnvConfig)::get(this,"","I2sEnvConfig",i2sEnvConfig)) begin
    `uvm_fatal("FATAL_ENV_CONFIG", $sformatf("Scoreboard :: Couldn't get the Env Config from the config db"))
    end
  `uvm_info(get_full_name(),"Inside i2s sb build phase",UVM_NONE)

endfunction : build_phase

function void I2sScoreboard::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
  `uvm_info(get_full_name(),"Inside i2s sb connect phase",UVM_NONE)
endfunction : connect_phase

function void I2sScoreboard::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
endfunction: end_of_elaboration_phase

task I2sScoreboard::run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info(get_full_name(),"Inside i2s sb run phase",UVM_NONE)
  
  forever begin
    i2sTransmitterAnalysisFIFO.get(i2sTransmitterTransaction);
    i2sReceiverAnalysisFIFO.get(i2sReceiverTransaction);
    dataComparison();
  end

endtask : run_phase

task I2sScoreboard::dataComparison();

  if(i2sTransmitterTransaction.txWs == i2sReceiverTransaction.rxWs) begin    
        
    if(i2sTransmitterTransaction.txWordSelectPeriod == i2sReceiverTransaction.rxWordSelectPeriod) begin
         
        for(int i=0; i<i2sTransmitterTransaction.txSd.size(); i++) begin
         if(i2sTransmitterTransaction.txSd[i] == i2sReceiverTransaction.rxSd[i]) begin

          `uvm_info(get_type_name(),$sformatf("i2s serial data from transmitter and receiver is equal"),UVM_NONE);
          `uvm_info("SB_serialData_MATCHED", $sformatf("Transmitter SerialData = %0h and Receiver SerialData = %0h",i2sTransmitterTransaction.txSd[i],i2sReceiverTransaction.rxSd[i]),UVM_NONE);
          serialDataComparisonSuccessCount++;
        end
        else
          begin
          `uvm_error(get_type_name(),$sformatf("i2s serialData from Transmitter and receiver is Not equal"));
          `uvm_info("SB_serialData_MISMATCHED", $sformatf("Transmitter SerialData = %0h and Receiver SerialData = %0h",i2sTransmitterTransaction.txSd[i],i2sReceiverTransaction.rxSd[i]),UVM_NONE);
 
          serialDataComparisonFailedCount++;
        end
    end
  end
    else if (i2sTransmitterTransaction.txWordSelectPeriod < i2sReceiverTransaction.rxWordSelectPeriod) begin
       for(int i=0; i<i2sTransmitterTransaction.txSd.size(); i++) begin
         if(i2sTransmitterTransaction.txSd[i] == i2sReceiverTransaction.rxSd[i]) begin
          `uvm_info(get_type_name(),$sformatf("i2s serial data from transmitter and receiver is equal"),UVM_NONE);
          `uvm_info("SB_serialData_MATCHED", $sformatf("Transmitter SerialData = %0h and Receiver SerialData = %0h",i2sTransmitterTransaction.txSd[i],i2sReceiverTransaction.rxSd[i]),UVM_NONE);
          serialDataComparisonSuccessCount++;
        end
        else
          begin
          `uvm_error(get_type_name(),$sformatf("i2s serialData from Transmitter and receiver is Not equal"));
          `uvm_info("SB_serialData_MISMATCHED", $sformatf("Transmitter SerialData = %0h and Receiver SerialData = %0h",i2sTransmitterTransaction.txSd[i],i2sReceiverTransaction.rxSd[i]),UVM_NONE);
 
          serialDataComparisonFailedCount++;
        end
    end

    end
    else if (i2sTransmitterTransaction.txWordSelectPeriod > i2sReceiverTransaction.rxWordSelectPeriod) begin
       for(int i=0; i<i2sReceiverTransaction.rxSd.size(); i++) begin
         if(i2sTransmitterTransaction.txSd[i] == i2sReceiverTransaction.rxSd[i]) begin
          `uvm_info(get_type_name(),$sformatf("i2s serial data from transmitter and receiver is equal"),UVM_NONE);
          `uvm_info("SB_serialData_MATCHED", $sformatf("Transmitter SerialData = %0h and Receiver SerialData = %0h",i2sTransmitterTransaction.txSd[i],i2sReceiverTransaction.rxSd[i]),UVM_NONE);
          serialDataComparisonSuccessCount++;
        end
        else
          begin
          `uvm_error(get_type_name(),$sformatf("i2s serialData from Transmitter and receiver is Not equal"));
          `uvm_info("SB_serialData_MISMATCHED", $sformatf("Transmitter SerialData = %0h and Receiver SerialData = %0h",i2sTransmitterTransaction.txSd[i],i2sReceiverTransaction.rxSd[i]),UVM_NONE);
 
          serialDataComparisonFailedCount++;
        end
    end

    end

  end
endtask

function void I2sScoreboard::check_phase(uvm_phase phase);
  super.check_phase(phase);
  `uvm_info(get_full_name(),"Inside i2s sb check phase",UVM_NONE)
  `uvm_info(get_type_name(),$sformatf("--\n--------SCOREBOARD CHECK PHASE----------------"),UVM_HIGH) 
  if((serialDataComparisonSuccessCount != 0) && (serialDataComparisonFailedCount == 0)) begin
      `uvm_info (get_type_name(), $sformatf ("Transmitter And Receiver serialData comparisions are equal = %0d",serialDataComparisonSuccessCount),UVM_HIGH);
    end
    else begin
      `uvm_info (get_type_name(), $sformatf ("serialDataComparisonSuccessCount : %0d",
                                              serialDataComparisonSuccessCount),UVM_HIGH);
      `uvm_info (get_type_name(), $sformatf ("serialDataComparisonFailedCount : %0d",
                                              serialDataComparisonFailedCount),UVM_HIGH);
      `uvm_error("SC_CheckPhase", $sformatf ("Transmitter And Receiver serialData comparisions Not equal"));
    end
  
      
  if(i2sTransmitterAnalysisFIFO.size() == 0)begin
    `uvm_info ("SC_CheckPhase", $sformatf ("I2s Transmitter analysis FIFO is empty"),UVM_HIGH);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("i2s Transmitter analysis_fifo:%0d",i2sTransmitterAnalysisFIFO.size() ),UVM_HIGH);
    `uvm_error ("SC_CheckPhase", $sformatf ("i2s Transmitter analysis FIFO is not empty"));
  end

  if(i2sReceiverAnalysisFIFO.size() == 0)begin
    `uvm_info ("SC_CheckPhase", $sformatf ("I2s Receiver analysis FIFO is empty"),UVM_HIGH);
  end
  else begin
    `uvm_info (get_type_name(), $sformatf ("i2s Receiver analysis_fifo:%0d",i2sReceiverAnalysisFIFO.size() ),UVM_HIGH);
    `uvm_error ("SC_CheckPhase", $sformatf ("i2s Receiver analysis FIFO is not empty"));
  end

  `uvm_info(get_type_name(),$sformatf("--\n-----END OF SCOREBOARD CHECK PHASE-------"),UVM_HIGH)

endfunction : check_phase
`endif

