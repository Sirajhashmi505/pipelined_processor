module forwarding_unit1 (
    input [31:0] A,        // 32-bit instruction A
    input [31:0] B,        // 32-bit instruction B
    output reg conflict    // Conflict flag
);

    // Define opcodes for reference
    localparam NOP  = 5'b01101;
    localparam BEQ  = 5'b10000;
    localparam BGT  = 5'b10001;
    localparam CALL = 5'b10011;
    localparam NOT  = 5'b01000;
    localparam MOV  = 5'b01001;
    localparam CMP  = 5'b00101;
    localparam ST   = 5'b01111;
    localparam B_check = 5'b10010;
    localparam RET  = 5'b10100;

    reg [4:0] opcode_A;   // Opcode for instruction A
    reg [4:0] opcode_B;   // Opcode for instruction B
    wire [3:0] ra =4'b1111;
    reg [3:0] rs1_A;      // Source register 1 of instruction A
    reg [3:0] rd_B;       // Destination register of instruction B

    reg [3:0] src1;        // Calculated source 1 register for A
    reg [3:0] dest;        // Calculated destination register for B

    // Extract fields from instruction A

    

    always @(*) begin
        // Step 1: Initialize conflict to false
        conflict = 1'b0;
        opcode_A = A[31:27];
        opcode_B = B[31:27];

        // Step 2: Check if A's opcode reads from rs1
        if (opcode_A == B_check || opcode_A == NOP || opcode_A == BEQ || opcode_A == BGT || opcode_A == CALL || opcode_A == NOT || opcode_A == MOV) begin
            conflict = 1'b0;
        end
        // Step 3: Check if B's opcode writes to any register
        else if (opcode_A == B_check || opcode_B == NOP || opcode_B == CMP || opcode_B == ST || opcode_B == BEQ || opcode_B == BGT || opcode_B == RET) begin
            conflict = 1'b0;
        end
        else begin
             rd_B     = B[25:22];
             rs1_A    = A[21:18];
            // Step 4: Set src1 based on A's opcode
            src1 = (opcode_A == RET) ? ra : rs1_A;

            // Step 5: Set dest based on B's opcode
            dest = (opcode_B == CALL) ? ra : rd_B;

            // Step 6: Detect conflict
            if (src1 == dest) begin
                conflict = 1'b1;
            end
        end
    end

endmodule
