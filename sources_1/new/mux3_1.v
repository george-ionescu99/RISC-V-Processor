`timescale 1ns / 1ps



module mux3_1(input [31:0] registerFile, res_WB, memory,
              input[1:0] sel,
              output reg [31:0] out);
              
always@(*) begin
    case(sel)
    2'b00: out <= registerFile;
    2'b10: out <= memory;
    2'b01: out <= res_WB;
    endcase
end              
              
endmodule
