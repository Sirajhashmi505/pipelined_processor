module TopTri (
    input clk,                      // Clock signal
    input rst,                      // Reset signal
    output [31:0] pc,               // Current program counter (PC) from OF_stage
    output [31:0] instruction,      // Instruction fetched from OF_stage
    output [21:0] control_signals_OF, // Control signals from OF_stage
    output [31:0] immx,             // Immediate operand output from OF_stage
    output [31:0] branchTarget,      // Branch target output from OF_stage
    output [31:0] OP1,              // Operand 1 output from OF_stage
    output [31:0] OP2,              // Operand 2 output from OF_stage
    output [31:0] B,                // B output from OF_stage
    output [31:0] A                 // A output from OF_stage
);

    // Internal signals to connect IF_stage and IF_stage_latch
    wire isBranchTaken_latch;
    wire [31:0] branchPC_latch;

    // Signals for IF_OF_Latch
    wire [31:0] pc_out_IF;
    wire [31:0] pc_out_IF_out;
    wire [31:0] instruction_out_IF;
    wire [31:0] instruction_out_IF_out;

    // Signals for OF_stage
    wire [31:0] pc_out_IF_lat;
    wire [31:0] instruction_out_IF_lat;
    wire [21:0] control_signals_OF_latch;

    // Instantiate IF_stage_latch
    IF_stage_latch latch (
        .clk(clk),
        .rst(rst),
        .isBranchTaken(1'b0),          // Assuming no branching in this simplified version
        .branchPC(32'b0),
        .isBranchTaken_out(isBranchTaken_latch),
        .branchPC_out(branchPC_latch)
    );

    // Instantiate IF_stage
    Fetch_Unit IF_stage (
        .clk(clk),
        .rst(rst),
        .isBranchTaken(isBranchTaken_latch),
        .branchPC(branchPC_latch),
        .pc(pc_out_IF),
        .instruction(instruction_out_IF)
    );

    // Instantiate IF_OF_Latch
    IF_OF_Latch if_of_latch (
        .clk(clk),
        .rst(rst),
        .pc_in(pc_out_IF),
        .instruction_in(instruction_out_IF),
        .pc_out(pc_out_IF_out),
        .instruction_out(instruction_out_IF_out)
    );

    // Instantiate OF_stage
    OF_stage of_stage (
        .clk(clk),
        .pc(pc_out_IF_out),
        .inst(instruction_out_IF_out),
        .inst_out(instruction_out_IF_lat),
        .pc_out(pc_out_IF_lat),
        .immx(immx),                   // Immediate value output
        .branchTarget(branchTarget),    // Branch target output
        .OP1(OP1),                     // Operand 1 output
        .OP2(OP2),                     // Operand 2 output
        .B(B),                         // B output
        .A(A),                         // A output
        .control_signals_out(control_signals_OF_latch)
    );

    // Connect OF_stage outputs to TopTri module outputs
    assign pc = pc_out_IF_lat;
    assign instruction = instruction_out_IF_lat;
    assign control_signals_OF = control_signals_OF_latch;

endmodule
