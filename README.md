# Fully Pipelined Processor in Verilog  

## 📜 Overview  
This repository contains the Verilog implementation of a fully pipelined processor. The processor is designed to execute instructions efficiently by utilizing instruction-level parallelism. The design incorporates all the essential pipeline stages, including:  

1. **Instruction Fetch (IF)**  
2. **Operand Fetch (OF)**  
3. **Execute (EX)**  
4. **Memory Access (MA)**  
5. **Register Write-back (RW)**  

It also handles data hazards, control hazards, and ensures smooth operation using forwarding and stalling mechanisms.  

## 🛠️ Features  
- **Pipeline Stages**: Fully pipelined with five stages.  
- **Hazard Handling**: Implemented mechanisms for RAW (Read After Write) dependencies and branch prediction.  
- **Control Signals**: Designed for efficient data flow between stages.  
- **Modular Design**: Each stage is implemented as a separate Verilog module.  

## 📂 Project Structure  
- `IF_stage.v`: Instruction Fetch Stage  
- `OF_stage.v`: Operand Fetch Stage  
- `Ex_stage.v`: Execute Stage  
- `MA_stage.v`: Memory Access Stage  
- `RW_stage.v`: Register Write-back Stage  
- Latches: Stage-to-stage communication modules  
- `mux3to1.v`: 3-to-1 Multiplexer for selecting data in the RW stage  
- `Top.v`: Top-level module integrating all components  
