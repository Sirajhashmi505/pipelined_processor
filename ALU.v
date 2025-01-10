module ALU (
    input [31:0] A,
    input [31:0] B,
    input [21:0] control_signals,

    output reg signed [31:0] aluResult,
    output wire [3:0] flags // Changed to wire
);

// Internal wires for results of each module
wire [31:0] adder_result, multiplier_result, divider_result, shift_result, logical_result, mov_result;

wire isSt = control_signals[0];
wire isLd = control_signals[1];
wire isAdd = control_signals[9];
wire isSub = control_signals[10];
wire isCmp = control_signals[11];
wire isMul = control_signals[12];
wire isDiv = control_signals[13];
wire isMod = control_signals[14];
wire isLsl = control_signals[15];
wire isLsr = control_signals[16];
wire isAsr = control_signals[17];
wire isOr = control_signals[18];
wire isNot = control_signals[20];
wire isAnd = control_signals[19];
wire isMov = control_signals[21];

// Instantiate the Adder module

Adder adder (
    .A(A),
    .B(B),
    .isSt(isSt),
    .isLd(isLd),
    .isAdd(isAdd),
    .isSub(isSub),
    .isCmp(isCmp),
    .result(adder_result),
    .flags(flags) // Connect to flags
);

// Instantiate the Multiplier module
Multiplier multiplier (
    .A(A),
    .B(B),
    .isMul(isMul),
    .result(multiplier_result)
);

// Instantiate the Divider module
Divider divider (
    .A(A),
    .B(B),
    .isDiv(isDiv),
    .isMod(isMod),
    .result(divider_result)
);

// Instantiate the Shift unit module
ShiftUnit shift_unit (
    .A(A),
    .B(B),
    .isLsl(isLsl),
    .isLsr(isLsr),
    .isAsr(isAsr),
    .result(shift_result)
);

// Instantiate the Logical unit module
LogicalUnit logical_unit (
    .A(A),
    .B(B),
    .isOr(isOr),
    .isNot(isNot),
    .isAnd(isAnd),
    .result(logical_result)
);

// Instantiate the Mov module
Mov mov (
    .B(B),
    .isMov(isMov),
    .result(mov_result)
);

// Select the result based on the control signals
always @(*) begin
    // Default values
    aluResult = 32'b0; // Initialize the output

    case (1'b1)
        isAdd,isLd,isSub,isSt ,isCmp: begin
            aluResult = adder_result;
        end
        isMul: begin
            aluResult = multiplier_result;
        end
        isDiv, isMod: begin
            aluResult = divider_result;
        end
        isLsl, isLsr, isAsr: begin
            aluResult = shift_result;
        end
        isOr, isNot, isAnd: begin
            aluResult = logical_result;
        end
        isMov: begin
            aluResult = mov_result;
        end
        default: begin
            aluResult = 32'b0;
        end
    endcase
end

endmodule

// Define each module separately below

module Adder (
    input [31:0] A, B,
    input isAdd, isSub, isCmp,isLd,isSt,
    output reg signed [31:0] result,
    output reg [3:0] flags
);
    // Internal register to hold flags
    reg [3:0] sticky_flags;

    always @(*) begin
        // Perform the operation based on control signals
        if (isAdd) begin
            result = A + B;
        end
        else if (isSt) begin
            result = A + B;  // Adding two's complement of B (equivalent to A - B)
        end
        else if (isLd) begin
            result = A + B;  // Adding two's complement of B (equivalent to A - B)
        end
        else if (isSub) begin
            result = A + (1 + ~B);  // Adding two's complement of B (equivalent to A - B)
        end
        else if (isCmp) begin
            result = A - B;
            // Update flags based on the comparison result
            sticky_flags[0] = (result == 0);                    // E: Set if result is zero
            sticky_flags[1] = (result >0 );  // GT: Set if result is positive
            //sticky_flags[2] = result[31];                       // Sign: Set if result is negative
        end
    end

    // Output flags only change when isCmp is active
    always @(*) begin
        if (isCmp)
            flags = sticky_flags;
    end
endmodule



module Multiplier (
    input [31:0] A, B,
    input isMul,
    output reg [31:0] result
);
    always @(*) begin
        if (isMul) result = A * B;
        else result = 32'b0; // Default output if not multiplying
    end
endmodule

module Divider (
    input [31:0] A, B,
    input isDiv, isMod,
    output reg [31:0] result
);
    always @(*) begin
        if (isDiv) result = A / B;
        else if (isMod) result = A % B;
        else result = 32'b0; // Default output if not dividing
    end
endmodule

module ShiftUnit (
    input [31:0] A, B,
    input isLsl, isLsr, isAsr,
    output reg [31:0] result
);
    always @(*) begin
        if (isLsl) result = A << B;
        else if (isLsr) result = A >> B;
        else if (isAsr) result = A >>> B;
        else result = 32'b0; // Default output if no shift operation
    end
endmodule

module LogicalUnit (
    input [31:0] A, B,
    input isOr, isNot, isAnd,
    output reg [31:0] result
);
    always @(*) begin
        if (isOr) result = A | B;
        else if (isNot) result = ~A;
        else if (isAnd) result = A & B;
        else result = 32'b0; // Default output if no logical operation
    end
endmodule

module Mov (
    input [31:0] B,
    input isMov,
    output reg [31:0] result
);
    always @(*) begin
        if (isMov) result = B;
        else result = 32'b0; // Default output if not moving
    end
endmodule
