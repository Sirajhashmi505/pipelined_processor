module ControlUnit_tb;
    // Inputs
    reg [31:0] instruction;
    // Outputs
    wire [21:0] control_signals;

    // Instantiate the ControlUnit
    ControlUnit dut (
        .instruction(instruction),
        .control_signals(control_signals)
    );

    // Task to display control signals with labels for clarity
    task display_control_signals;
        begin
            $display("Instruction: %h", instruction);
            $display("Control Signals:");
            $display("isSt=%b, isLd=%b, isBeq=%b, isBgt=%b, isRet=%b, isImmediate=%b", 
                control_signals[0], control_signals[1], control_signals[2], control_signals[3], control_signals[4], control_signals[5]);
            $display("isWb=%b, isUbranch=%b, isCall=%b, isAdd=%b, isSub=%b, isCmp=%b", 
                control_signals[6], control_signals[7], control_signals[8], control_signals[9], control_signals[10], control_signals[11]);
            $display("isMul=%b, isDiv=%b, isMod=%b, isLsl=%b, isLsr=%b, isAsr=%b", 
                control_signals[12], control_signals[13], control_signals[14], control_signals[15], control_signals[16], control_signals[17]);
            $display("isOr=%b, isAnd=%b, isNot=%b, isMov=%b\n", 
                control_signals[18], control_signals[19], control_signals[20], control_signals[21]);
        end
    endtask

    // Test different opcodes and I_bit values
    initial begin
        // Test Case: Using instruction 4c000005
        instruction = 32'h4c000005; // Set the instruction
        #10; 
        display_control_signals;

        // Additional test cases can be added here if needed
        
        // Complete simulation
        $finish;
    end
endmodule
