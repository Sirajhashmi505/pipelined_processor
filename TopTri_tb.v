module TopTri_tb;

    // Testbench signals
    reg clk;
    reg rst;
    wire [31:0] pc;
    wire [31:0] instruction;
    wire [21:0] control_signals_OF;
    wire [31:0] immx;
    wire [31:0] branchTarget;
    wire [31:0] OP1;
    wire [31:0] OP2;
    wire [31:0] B;
    wire [31:0] A;

    // Instantiate the TopTri module
    TopTri uut (
        .clk(clk),
        .rst(rst),
        .pc(pc),
        .instruction(instruction),
        .control_signals_OF(control_signals_OF),
        .immx(immx),
        .branchTarget(branchTarget),
        .OP1(OP1),
        .OP2(OP2),
        .B(B),
        .A(A)
    );

    // Generate clock signal
    always #5 clk = ~clk; // 10 time units period (100 MHz)

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;

        // Apply reset
        #10 rst = 0; // Release reset after 10 time units

        // Observe output after reset
        #10; // Wait for one clock cycle
        $display("After reset:");
        $display("PC: %h, Instruction: %h", pc, instruction);
        $display("Control Signals OF: %b", control_signals_OF);
        $display("Immediate (immx): %h", immx);
        $display("Branch Target: %h", branchTarget);
        $display("OP1: %h, OP2: %h, B: %h, A: %h", OP1, OP2, B, A);

        // Test different scenarios
        #20;
        $display("At time %0t:", $time);
        $display("PC: %h, Instruction: %h", pc, instruction);
        $display("Control Signals OF: %b", control_signals_OF);
        $display("Immediate (immx): %h", immx);
        $display("Branch Target: %h", branchTarget);
        $display("OP1: %h, OP2: %h, B: %h, A: %h", OP1, OP2, B, A);

        #20;
        $display("At time %0t:", $time);
        $display("PC: %h, Instruction: %h", pc, instruction);
        $display("Control Signals OF: %b", control_signals_OF);
        $display("Immediate (immx): %h", immx);
        $display("Branch Target: %h", branchTarget);
        $display("OP1: %h, OP2: %h, B: %h, A: %h", OP1, OP2, B, A);

        // Finish simulation
        #50 $finish;
    end

endmodule
