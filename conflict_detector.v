module Conflict_Detector_unit (
    input [31:0] instructionA, instructionB,
    output reg has_hazard
);

// Define the opcode for both instructions
wire [4:0] opcodeA = instructionA[31:27];
wire [4:0] opcodeB = instructionB[31:27];

// Handle source and destination registers for both instructions
wire [3:0] src1 = (opcodeA == 5'b10100) ? 4'b1111 : instructionA[21:18];
wire [3:0] src2 = (opcodeA == 5'b01111) ? instructionA[25:22] : instructionA[17:14];

// Determine the destination register for instructionB
wire [3:0] dest = (opcodeB == 5'b10011) ? 4'b1111 : instructionB[25:22];

// Flags to indicate the presence of source registers
wire hasSrc1 = (opcodeA == 5'b01000 || opcodeA == 5'b01001) ? 1'b0 : 1'b1;
wire hasSrc2 = (opcodeA == 5'b01111) ? 1'b1 : (instructionA[26]) ? 1'b0 : 1'b1;

always @(*) begin
    // Default case: no hazard if either instruction is zero
    if (instructionA == 0 || instructionB == 0) begin
        has_hazard <= 1'b0;
    end 
    // Check for specific opcodeB condition
    else if (opcodeB == 5'b01110) begin
        // Instructions that don't cause a hazard
        if (opcodeA == 5'b01101 || opcodeA == 5'b10010 || 
            opcodeA == 5'b10000 || opcodeA == 5'b10001 || 
            opcodeA == 5'b10011 || opcodeA == 5'b01111) begin
            has_hazard <= 1'b0;
        end
        // Check for hazard conditions based on sources
        else if (hasSrc1 && src1 == dest || hasSrc2 && src2 == dest) begin
            has_hazard <= 1'b1;
        end else begin
            has_hazard <= 1'b0;
        end
    end
    else begin
        has_hazard <= 1'b0;
    end
end

endmodule
