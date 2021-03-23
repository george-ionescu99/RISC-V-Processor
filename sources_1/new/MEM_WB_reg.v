`timescale 1ns / 1ps



module MEM_WB_reg(input clk, write, reset,
                    input [31:0] readData_MEM, ALUresult_MEM, rd_MEM,
                    output reg [31:0] readData_WB, ALUresult_WB, rd_WB);
                    
     always@(posedge clk) begin
        if(reset) begin
            readData_WB <= 32'b0;
            ALUresult_WB <= 32'b0;
            rd_WB <= 32'b0;
        end
        else begin
            if(write) begin
                readData_WB <= readData_MEM;
                ALUresult_WB <= ALUresult_MEM;
                rd_WB <= rd_MEM;
            end
        end
     end                   
                    
endmodule
