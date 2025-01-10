module MA_stage_tb;

    // Testbench signals
    reg clk;
    reg rst;
    reg [31:0] pc_MA_in;
    reg [31:0] aluResult;
    reg [31:0] op2;
    reg [31:0] inst_out_ex;
    reg [21:0] control_signals_ex;

    wire [31:0] pc_MA_out;
    wire [31:0] ldResult;
    wire [31:0] inst_out_ma;
    wire [31:0] alu_res_MA;
    wire [21:0] control_MA;

    // Instantiate the MA_stage module
    MA_stage uut (
        .clk(clk),
        .rst(rst),
        .pc_MA_in(pc_MA_in),
        .aluResult(aluResult),
        .op2(op2),
        .inst_out_ex(inst_out_ex),
        .control_signals_ex(control_signals_ex),
        .pc_MA_out(pc_MA_out),
        .ldResult(ldResult),
        .inst_out_ma(inst_out_ma),
        .alu_res_MA(alu_res_MA),
        .control_MA(control_MA)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        pc_MA_in = 32'h00000000;
        aluResult = 32'h00000010;       // Set the address to write to/load from
        op2 = 32'hA5A5A5A5;             // Data to store
        inst_out_ex = 32'h12345678;     // Example instruction output from EX stage
        control_signals_ex = 22'b0;

        // Release reset after some time
        #10 rst = 0;

        // Test Store Operation
        control_signals_ex[1] = 1;  // Enable store operation (isSt = 1)
        #10;

        // Display output after store
        $display("After Store Operation:");
        $display("pc_MA_out: %h, ldResult: %h, inst_out_ma: %h, alu_res_MA: %h, control_MA: %b",
                 pc_MA_out, ldResult, inst_out_ma, alu_res_MA, control_MA);
        #10;

        // Test Load Operation
        control_signals_ex[1] = 0;  // Disable store
        control_signals_ex[0] = 1;  // Enable load operation (isLd = 1)
        #10;

        // Display output after load
        $display("After Load Operation:");
        $display("pc_MA_out: %h, ldResult: %h, inst_out_ma: %h, alu_res_MA: %h, control_MA: %b",
                 pc_MA_out, ldResult, inst_out_ma, alu_res_MA, control_MA);
        #10;

        // End simulation
        $finish;
    end

endmodule
