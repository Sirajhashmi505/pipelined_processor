module RW_stage (
    input clk,                           // Clock signal
    input rst,                           // Reset signal
    input [31:0] pc_in,                  // Program counter input from MA stage
    input [31:0] ldResult,               // Load result from memory
    input [31:0] aluResult,              // ALU result from MA stage
    input [31:0] inst_in,                // Instruction from MA stage
    input [21:0] control_in,             // Control signals from MA stage

    output wire isEnable,
    output wire [3:0] reg_write_address,  // Write address for register file (4 bits)
    output wire [31:0] reg_write_data     // Write data for register file
);

    // Extract control signals
    wire isLd = control_in[1];           // Load signal
    wire isCall = control_in[8];         // Call signal
    wire isWb = control_in[6];           // Write-back signal
    wire [3:0] rd_rw = inst_in[25:22];
    wire [3:0] ra = 4'b1111;

    // Temporary data register for selected data
    reg [31:0] selected_data;
     mux3to1 hope(
        .a(aluResult),
        .l(ldResult),
        .p(pc_in+4),
        .isLd(isLd),
        .isCall(isCall),
        .result(reg_write_data)
    );
    // Mux to select the register write address based on isCall signal
    Mux2x1_4bit mxlastP(
        .in0(rd_rw),
        .in1(ra),
        .sel(isCall),
        .out(reg_write_address)  // Output should be 4 bits to match the reg_write_address size
    );
   
   
    
    /*always @(*) begin
        // Multiplexer selection for data to write back
        if (isLd) begin
            selected_data = ldResult;    // If load, select load resul
        end else if (isCall) begin
            selected_data = pc_in + 4;   // If call, select PC + 4
        end else begin
            selected_data = aluResult;   // Default to ALU result
        end
    end

    // Connect the selected data to the output for the register file
    assign reg_write_data = selected_data;*/
    
    /* Register file instance
    regfile r2(
        .write_enable(isWb),
        .write_reg(reg_write_address),  // Expecting 4 bits
        .write_data(reg_write_data),
        .read_reg1(4'b0),               // Optional: Can tie unused inputs to a default value
        .read_reg2(4'b0)
    );*/
    assign isEnable =isWb;
endmodule
