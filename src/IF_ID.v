`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2026 15:48:42
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
    input clk,
    input reset,

    input [31:0] PC_in,
    input [31:0] instr_in,

    output reg [31:0] PC_out,
    output reg [31:0] instr_out
);

always @(posedge clk or posedge reset) begin
    if(reset) begin
        PC_out <= 0;
        instr_out <= 0;
    end
    else begin
        PC_out <= PC_in;
        instr_out <= instr_in;
    end
end

endmodule