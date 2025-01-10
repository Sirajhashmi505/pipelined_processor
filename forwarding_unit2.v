module forwarding_unit2 (
    input clk,
    input [31:0] A,         // 32-bit instruction A
    input [31:0] B,         // 32-bit instruction B
    output reg conflict     // Conflict flag
);

    // Define opcodes for reference 
    localparam NOP  = 5'b01101;
    localparam BEQ  = 5'b10000;
    localparam BGT  = 5'b10001;
    localparam CALL = 5'b10011;
    localparam B_check = 5'b10010;
    localparam NOT  = 5'b01000;
    localparam MOV  = 5'b01001;
    localparam CMP  = 5'b00101;
    localparam ST   = 5'b01111;
    localparam RET  = 5'b10100;

    reg [4:0] opcode_A;     // Opcode for instruction A
    reg [4:0] opcode_B;     // Opcode for instruction B
    reg [3:0] rs2_A;        // Source register 2 of instruction A
    reg [3:0] rd_B;         // Destination register of instruction B
    wire [3:0] ra = 4'b1111; // Register address for CALL
    wire I_A;               // Immediate flag for instruction A
    reg [3:0] src2;         // Calculated source 2 register for A
    reg [3:0] dest;         // Calculated destination register for B

    assign I_A = A[26];

    always @(*) begin
        // Step 1: Initialize conflict to false
        conflict = 1'b0;

        // Step 2: Extract opcodes and registers
        opcode_A = A[31:27];
        opcode_B = B[31:27];
        
        // Step 3: Check if A's opcode reads from rs2
        if (opcode_A == NOP || opcode_A == BEQ || opcode_A == BGT || opcode_A == CALL || opcode_A == B_check) begin
            // A does not read from any register, so no conflict
            conflict = 1'b0;
        end
        // Step 4: Check if B's opcode writes to any register
        else if (opcode_B == NOP || opcode_B == CMP || opcode_B== B_check || opcode_B == ST || opcode_B == BEQ || opcode_B == BGT || opcode_B == RET) begin
            // B does not write to any register, so no conflict
            conflict = 1'b0;
        end
        else begin
            // Extract source and destination registers
            rs2_A = A[17:14];
            rd_B = B[25:22];

            // Determine if instruction A uses an immediate or a register
            if (I_A == 1'b1 && opcode_A != ST) begin
                // If A uses an immediate, no conflict
                conflict = 1'b0;
            end else begin
                // Calculate src2 based on ST opcode or rs2_A
                src2 = (opcode_A == ST) ? A[25:22] : rs2_A;

                // Set destination for B (special handling for CALL)
                dest = (opcode_B == CALL) ? ra : rd_B;

                // Step 5: Detect conflict if source and destination registers match
                if (src2 == dest) begin
                    conflict = 1'b1;
                end
            end
        end
    end

endmodule
