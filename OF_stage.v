module OF_stage (
    input clk,
    input [31:0] pc,                    // Program counter input
    input [31:0] inst,
    input [31:0] OP1_input,
    input [31:0] OP2_input,  
    input [31:0] Data_from_rw_for_OF, 
    input signal1_from_forwarding1_for_RW_OF,
    input signal2_from_forwarding2_for_RW_OF,
    output [3:0] read_port1,
    output [3:0] read_port2,
    output [31:0] inst_out,
    output [31:0] pc_out,
    output reg [31:0] immx,             // Immediate operand output
    output reg [31:0] branchTarget,     // Branch target output
    output wire [31:0] OP1,             // 32-bit output for OP1
    output wire [31:0] OP2,             // 32-bit output for OP2
    output wire [31:0] B,
    output wire [31:0] A,
    output wire [21:0] control_signals_out // Pass control signals to the next stage
);

    // Internal signals for immediate and offset extraction
    wire [15:0] imm = inst[15:0];          // 16-bit immediate field extracted from instruction
    wire [1:0] modifiers = inst[17:16];    // 2-bit modifier extracted from instruction (bits 17 and 18)
    wire [3:0] ra = 4'b1111;
    wire [3:0] rd = inst[25:22];
    wire [3:0] rs1 = inst[21:18];
    wire [3:0] rs2 = inst[17:14];



    // Instantiate the ControlUnit module
    wire [21:0] control_signals;       // Control signals array
    ControlUnit control_unit_inst (
        .instruction(inst),              // Connect the instruction input to inst
        .control_signals(control_signals) // Get the control signals as an array
    );
    
    // Directly assign control signals output
    assign control_signals_out = control_signals;

    assign OP1 =OP1_input;
    
    Mux2x1_32bit mux_of1(//from right consider it as 1
        .in0(OP1_input),
        .in1(Data_from_rw_for_OF),
        .sel(signal1_from_forwarding1_for_RW_OF),
        .out(A)
    );

    Mux2x1_32bit mux_of2(
        .in0(OP2_input),
        .in1(Data_from_rw_for_OF),
        .sel(signal2_from_forwarding2_for_RW_OF),       
        .out(OP2)
    );
    /* Instantiate the regfile
    regfile regfile_inst (
        .write_enable(1'b0),             // Assuming no writing during this stage (modify as needed)
        .read_reg1(read_port1),          // Connect read port 1 to the output of the mux
        .read_reg2(read_port2),          // Connect read port 2 to the output of the mux
        .write_reg(4'b0),                // No write register for demonstration (modify as needed)
        .write_data(32'b0),              // No write data for demonstration (modify as needed)
        .read_data1(OP1),                // Connect read_data1 to OP1
        .read_data2(OP2)                 // Connect read_data2 to OP2
    );
   */
    // Instantiate the Mux2x1_4bit modules
    Mux2x1_4bit mux_inst1 (
        .in0(rs2),                        // Connect rd to the first input
        .in1(rd),                       // Connect rs2 to the second input
        .sel(control_signals[0]),        // Use control_signals[0] (isSt) as the select signal
        .out(read_port2)                 // Connect the output to read_port2
    );

    Mux2x1_4bit mux_inst2 (
        .in0(rs1),                        // Connect ra to the first input
        .in1(ra),                       // Connect rs1 to the second input
        .sel(control_signals[4]),        // Use control_signals[4] (isRet) as the select signal
        .out(read_port1)                 // Connect the output to read_port1
    );

    // Combinational calculation of immx and branchTarget
    always @(*) begin
        // Calculate the immediate operand (immx)
        case (modifiers)
            2'b00: immx = { {16{imm[15]}}, imm };  // Sign-extend the 16-bit immediate to 32-bit
            2'b01: immx = { 16'b0, imm };          // Zero-extend (u modifier)
            2'b10: immx = { imm, 16'b0 };          // Shift left by 16 bits (h modifier)
            default: immx = 32'b0;                 // Default case (undefined modifier)
        endcase

        // Calculate the branch target
        branchTarget = pc + {{5{inst[26]}}, inst[26:0], 2'b00};  // Shift left by 2 and sign-extend
    end

    // Instantiate the Mux2x1_32bit for B
    Mux2x1_32bit mux(
        .in0(OP2),
        .in1(immx),
        .sel(control_signals[5]),       // Use control_signals[5] (isImmediate)
        .out(B)
    );

    // Directly assign output registers
    // assign A = OP1;
    assign pc_out = pc;
    assign inst_out = inst;

endmodule
