module MA_stage (
    input rst,                           // Reset signal
    input [31:0] pc_MA_in,               // Program counter input
    input [31:0] aluResult,              // Computed memory address (imm + reg[rs1])
    input [31:0] op2,                    // Operand 2, used as data for store (reg[rd])
    input [31:0] inst_out_ex,            // Instruction output from EX stage
    input [21:0] control_signals_ex,     // Control signals from EX stage (includes isLd and isSt)
    input [31:0] Data_from_rw_for_MA,
    input signal1_from_forwarding_RW_MA,
    input signal2_from_forwarding_RW_MA,
    input signal_from_forwarding,
    output reg [31:0] pc_MA_out,         // Program counter output
    output reg [31:0] ldResult,          // Result of load instruction (data read from memory)
    output reg [31:0] inst_out_ma,       // Instruction output for MA stage
    output reg [31:0] alu_res_MA,        // ALU result to pass to the next stage
    output reg [21:0] control_MA         // Control signals to pass to the next stage
);

    // Data memory array (for simulation purposes, this could be replaced with actual memory access)
    reg [31:0] data_memory[0:10000];  // 26,214,400 entries for 100 MB


    // Temporary registers for MAR (memory address register) and MDR (memory data register)
    reg [31:0] MAR;                      // Holds the memory address for load/store
    reg [31:0] MDR;                      // Holds the data for store (op2)
    wire [31:0] output_of_op2_data_rw;

    Mux2x1_32bit ma_forwarding_mux(
        .in0(op2),
        .in1(Data_from_rw_for_MA),
        .sel(signal2_from_forwarding_RW_MA),
        .out(output_of_op2_data_rw)
    );
    // Control signal extraction
    wire isLd = control_signals_ex[1];   // Load signal (assuming it's the first bit in control_signals_ex)
    wire isSt = control_signals_ex[0];   // Store signal (assuming it's the second bit in control_signals_ex)

    always @(*) begin
        if (rst) begin
            // Reset outputs
            ldResult = 32'b0;
            //inst_out_ma = 32'b0;
            pc_MA_out = 32'b0;
            alu_res_MA = 32'b0;
            control_MA = 22'b0;
            MAR = 32'b0;
            MDR = 32'b0;
        end else begin
            // Pass-through signals
            control_MA = control_signals_ex;
            inst_out_ma = inst_out_ex;
            alu_res_MA = aluResult;
            pc_MA_out = pc_MA_in;       // Directly assign pc_MA_in to pc_MA_out

            // Memory Access Logic
            MAR = aluResult;                     // Set MAR to the computed address

            if (isLd) begin
                // Load operation: Read data from memory at `aluResult`
                ldResult = data_memory[MAR];         // Read 4 bytes from memory into ldResult
            end else begin
                ldResult = 32'b0;  // Default value if not loading
            end

            if (isSt) begin  
                    ldResult = 32'b0;
                    $display("MDRRRR  %h",inst_out_ex);
                    data_memory[MAR] = output_of_op2_data_rw;         // Additional condition to check if MDR (op2) is not zero  
            

            end
        end
    end
endmodule