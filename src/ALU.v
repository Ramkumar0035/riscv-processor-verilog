`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2026 20:14:11
// Design Name: 
// Module Name: ALU
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


module ALU (
    input  [31:0] A,
    input  [31:0] B,
    input  [3:0]  ALU_Sel,
    output reg [31:0] Result,
    output Zero,
    output reg Overflow
);

reg [32:0] temp_sum;

always @(*) begin
    Overflow = 0;

    case(ALU_Sel)

        4'b0000: begin // ADD
            temp_sum = {1'b0, A} + {1'b0, B};
            Result = temp_sum[31:0];
            Overflow = (A[31] == B[31]) && (Result[31] != A[31]);
        end

        4'b0001: begin // SUB
            temp_sum = {1'b0, A} + {1'b0, (~B + 1)};
            Result = temp_sum[31:0];
            Overflow = (A[31] != B[31]) && (Result[31] != A[31]);
        end

        4'b0010: Result = A & B;
        4'b0011: Result = A | B;
        4'b0100: Result = A ^ B;

        default: Result = 32'd0;

    endcase
end

assign Zero = (Result == 32'd0);

endmodule