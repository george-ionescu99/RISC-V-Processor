`timescale 1ns / 1ps


module EX_MEM_reg(input clk, reset, write,
                    input [31:0] ALUresult_EX, data2_EX,
                    input MemRead_EX, MemWrite_EX,
                    input RS2_ID,
                    input ZERO_EX,
                    output reg [31:0] ALUresult_MEM, data2_MEM,
                    output reg MemRead_MEM, MemWrite_MEM,
                    output reg zero_MEM);
                    
    always@(posedge clk) begin
        if(reset) begin
            data2_MEM <= 32'b0;
            ALUresult_MEM <= 32'b0;
            zero_MEM <= 1'b0;
            MemRead_MEM <= 1'b0;
            MemWrite_MEM <= 1'b0;
        end
        else begin
            if(write) begin
                data2_MEM <= data2_EX;
                ALUresult_MEM <= ALUresult_EX;
                zero_MEM <= ZERO_EX;
                MemRead_MEM <= MemRead_EX;
                MemWrite_MEM <= MemWrite_EX;
            end
        end
    end                    
                    
endmodule
