module mux3to1 (
    input [31:0] a,   // ALU result input
    input [31:0] l,    // Load result input
    input [31:0] p,          // Program counter input
    input isLd,               // Control signal for load
    input isCall,             // Control signal for call
    output reg [31:0] result  // Mux output
);

    always @(*) begin
        if (isCall)
            result = p;       // If isCall is active, select the PC value
        else if (isLd)
            result = l; // If isLd is active, select the Load result
        else
            result = a; // Default to ALU result
    end

endmodule
