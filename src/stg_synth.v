`timescale 1ns / 1ps

module stg_synth #(parameter width=3)(
    input [width:0]gray_in,
    input clk,
    input rst,
    output reg [width:0] gray_out
    );
    reg [width:0] q;
    always @(posedge clk) begin
            if (rst) begin
                q        <= 0;
                gray_out <= 0;
            end else begin
                q        <= gray_in;
                gray_out <= q;
            end
    end
    
endmodule
