`timescale 1ns / 1ps
module mem  #(parameter width =$clog2(depth), data=8, depth= 8)(
    input  [data-1:0] wrt_data,
    output reg [data-1:0] rd_data,
    input rd_clk,wrt_clk,w_en,r_en,wrt_full,rd_empty,
    input [width-1:0] rd_ptr,wrt_ptr
    );
    //reg [data-1:0]connect;
    reg [data-1:0] mem[0:depth];
    always @(posedge wrt_clk) begin
      if(w_en && !wrt_full) begin
        mem[wrt_ptr] <= wrt_data;
        end
    end

  always @(posedge rd_clk) begin
    if (r_en && ~rd_empty) begin
        rd_data <= mem[rd_ptr];
        end
end

             
    
endmodule
