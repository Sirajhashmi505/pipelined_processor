module Mux2x1_32bit (
    input [31:0] in0,     // 4-bit input 0
    input [31:0] in1,     // 4-bit input 1
    input sel,           // Select signal
    output [31:0] out     // 4-bit output
);

    assign out = (sel) ? in1 : in0;   // If sel=1, choose in1; if sel=0, choose in0

endmodule
