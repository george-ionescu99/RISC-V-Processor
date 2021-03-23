`timescale 1ns / 1ps



module data_memory(input clk,       
                   input mem_read,
                   input mem_write,
                   input [31:0] address,
                   input [31:0] write_data,
                   output reg [31:0] read_data
                   );

reg [31:0] memory[0:1023];

integer i;
  initial begin
    for (i = 0; i < 1024; i = i + 1) begin
      memory[i] = 0;
    end
  end
                   
always@(posedge clk) begin
    if(mem_read)
        read_data <= memory[address];
end                   

always@(write_data) begin
    if(mem_write)
        memory[address] = write_data;
end
                       
endmodule
