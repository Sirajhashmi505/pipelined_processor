module regfile (    
    input clk,                         // Clock signal
    input write_enable,                    // Write enable signal for synchronous write
    input [3:0] read_reg1, read_reg2,      // Register addresses for read ports (4 bits wide for 16 registers)
    input [3:0] write_reg,                 // Register address for write port (4 bits wide for 16 registers)
    input [31:0] write_data,               // Data to write to the register
    output wire [31:0] read_data1, read_data2   // Data outputs for read ports
);

    // Define 16 registers, each 32 bits wide
    reg [31:0] registers [15:0];
    // Asynchronous read process
      
    assign read_data1 = registers[read_reg1]; // Read register 1 value
    assign read_data2 = registers[read_reg2]; // Read register 2 value


    // Synchronous write process
    always @(posedge clk) begin
        if (write_enable) begin
            registers[write_reg] = write_data;  // Write data to register on the rising edge of the clock
            $display("%h ----", write_data);
        end
            
    end


    // Initialize register 0 to always be zero
        initial begin        
        registers[0] = 32'b0;  // Set r0 to 5
        registers[1] = 32'b0;  // Set r1 to 2
        registers[2] = 32'b0;
        registers[3] = 32'b0;
        registers[4] = 32'b0;
        registers[5] = 32'b0;
        registers[6] = 32'b0;
        registers[7] = 32'b0;
        registers[8] = 32'b0;
        registers[9] = 32'b0;
        registers[10] = 32'b0;
        registers[11] = 32'b0;
        registers[12] = 32'b0;
        registers[13] = 32'b0;
        registers[14] = 10000;
        registers[15] = 32'b0;
    end

endmodule
