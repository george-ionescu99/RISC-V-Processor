`timescale 1ns / 1ps



module WB(input sel,
          input [31:0] a, b,
          input [4:0] reg_in,
          output [31:0] result,
          output [4:0] register,
          output RegWrite_WB);
          
mux2_1 alege(a, b, sel, result);

assign RegWrite_WB = 1'b1;
assign register = reg_in;          
          
endmodule
