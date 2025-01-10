module new_mux_3to1 (
    input [31:0] a,         // ALU result input
    input [31:0] l,         // Load result input
    input [31:0] p,         // Program counter input
    input sel0,             // Select line 0
    input sel1,             // Select line 1
    output reg [31:0] result // Mux output
);

    always @(*) begin
        case ({sel1, sel0}) // Concatenate sel1 and sel0 to create a 2-bit selection
            2'b00: result = a; // If sel1, sel0 is 00, select ALU result
            2'b01: result = l; // If sel1, sel0 is 01, select Load result
            2'b10: result = p; // If sel1, sel0 is 10, select Program counter
            2'b11: result = p; // If sel1, sel0 is 11, also select Program counter
        endcase
    end

endmodule
