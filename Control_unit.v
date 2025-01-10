module ControlUnit (
    input [31:0] instruction,  
    output reg [21:0] control_signals // Array of control signals
);

    // Constants for the control signal indices (for readability)
    localparam isSt       = 0;
    localparam isLd       = 1;
    localparam isBeq      = 2;
    localparam isBgt      = 3;
    localparam isRet      = 4;
    localparam isImmediate= 5;
    localparam isWb       = 6;
    localparam isUbranch  = 7;
    localparam isCall     = 8;
    localparam isAdd      = 9;
    localparam isSub      = 10;
    localparam isCmp      = 11;
    localparam isMul      = 12;
    localparam isDiv      = 13;
    localparam isMod      = 14;
    localparam isLsl      = 15;
    localparam isLsr      = 16;
    localparam isAsr      = 17;
    localparam isOr       = 18;
    localparam isAnd      = 19;
    localparam isNot      = 20;
    localparam isMov      = 21;

    // Extract the opcode and I_bit from the instruction
    wire [4:0] opcode = instruction[31:27];  // Adjusted based on opcode bit positions
    wire I_bit = instruction[26];            // Bit 26 (Immediate bit)
    wire op5 = instruction[31];
    wire op4 = instruction[30];
    wire op3 = instruction[29];
    wire op2 = instruction[28];
    wire op1 = instruction[27];
    // Combinational logic for control signals
    always @(*) begin
        // Reset all control signals to 0 at the beginning of each evaluation
        control_signals = 22'b0;
         $display("op1 is %h",op1);
         $display("op2 is %h",op2);
         $display("op3 is %h",op3);
         $display("op4 is %h",op4);
         $display("op5 is %h",op5);
        // Set control signals based on opcode conditions
        control_signals[isSt] = (~(op5) & op4 & op3 & op2 & op1);

        control_signals[isLd] = (~(op5) & op4 & op3 & op2 & ~(op1));
        control_signals[isBeq] = (op5 & (~(op4)) & (~(op3)) & (~(op2)) & (~(op1)));
        control_signals[isBgt] = (op5 & (~(op4)) & (~(op3)) & (~op2) & op1);
        control_signals[isRet] = (op5 & (~op4) & op3 & (~op2) & (~op1));
        control_signals[isImmediate] = I_bit;
        control_signals[isWb] = ~(op5 | (~(op5) & op3 & op1 & (op4 | ~(op2)))) | op5 & ~(op4) & ~(op3) & op2 & op1;
        control_signals[isUbranch] = op5 & ~(op4) & (~(op3) & op2 | op3 & ~(op2) & ~(op1));
        control_signals[isCall] = op5 & ~(op4) & ~(op3) & op2 & op1;

        // ALU operation signals based on opcode conditions
        control_signals[isAdd] = ((~op5) & (~op4) & (~op3) & (~op2) & (~op1) )| ((~op5) & (op4) & op3 & op2 & op1);
        control_signals[isSub] = (~op5) & (~op4) & (~op3) & (~op2) & op1;
        control_signals[isCmp] = (~op5) & (~op4) & op3 & (~op2) & (op1);
        control_signals[isMul] = (~op5) & (~op4) & (~op3) & op2 & (~op1);
        control_signals[isDiv] = (~op5) & (~op4) & (~op3) & op2 & op1;
        control_signals[isMod] = ~(op5) & ~(op4) & op3 & ~(op2) & ~(op1);
        control_signals[isLsl] = ~(op5) & op4 & ~(op3) & op2 & ~(op1);
        control_signals[isLsr] = ~(op5) & op4 & ~(op3) & op2 & op1;
        control_signals[isAsr] = ~(op5) & op4 & op3 & ~(op2) & ~(op1);
        control_signals[isOr] = ~(op5) & ~(op4) & op3 & op2 & op1;
        control_signals[isAnd] = ~(op5) & ~(op4)  & op3 & op2 & ~(op1);
        control_signals[isNot] = ~(op5) & op4 & ~(op3) & ~(op2) & ~(op1);
        control_signals[isMov] = ~(op5) & op4 & ~(op3) & ~(op2) & op1;
    end
endmodule
