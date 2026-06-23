`timescale 1ns / 1ps

module rd_src #(parameter width = 3)(
    input rd_clk,
    input rd_rst, r_en,
    output reg rd_empty,
    output reg [width:0] rd_out,
    //input [width:0] rd_ptr,
    input  [width:0] wrt_gray
    );
    wire rd_empty_next;
    wire [width:0] rd_ptr_next;
    wire [width:0] rd_gray_next;
	
    assign rd_ptr_next = rd_out + (r_en && !rd_empty);
    bin_gray g1(.b(rd_ptr_next), .g(rd_gray_next));
  assign rd_empty_next=(rd_gray_next == wrt_gray);
    always @(posedge rd_clk) begin
        if (rd_rst) begin
            rd_empty <= 1'b1;
            rd_out   <= 0;
        end
        else rd_empty <= rd_empty_next;
        if( ~rd_rst && r_en && ~rd_empty) begin
        rd_out<= rd_ptr_next;
        end
    end
endmodule
