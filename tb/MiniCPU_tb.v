`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.03.2026 22:31:38
// Design Name: 
// Module Name: MiniCPU_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ps

module MiniCPU_tb;

reg clk;
reg reset;

MiniCPU uut (
    .clk(clk),
    .reset(reset)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    #10;
    reset = 0;

    #100;
    $finish;
end

endmodule