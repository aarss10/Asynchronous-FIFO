`timescale 1ns / 1ps
module wrt_src #(parameter width = 3)(
    input wrt_clk,
    input wrt_rst, w_en,
    output reg wrt_full,
    output reg [width:0] wrt_out,
    //input [width:0] wrt_ptr,
    input  [width:0] rd_gray
    );
    wire wrt_full_next;
    wire [width:0] wrt_ptr_next;
    wire [width:0] wrt_gray_next;
	
    assign wrt_ptr_next = wrt_out + (w_en && !wrt_full);
    bin_gray g1(.b(wrt_ptr_next), .g(wrt_gray_next));
 assign wrt_full_next= (wrt_gray_next == {~rd_gray[width:width-1], rd_gray[width-2:0]});    
 always @(posedge wrt_clk) begin
        if (wrt_rst) begin
            wrt_full <= 1'b0;
            wrt_out<= 0;
            
        end
        else wrt_full <= wrt_full_next;
        if(~wrt_rst && w_en && ~wrt_full) begin
        wrt_out<= wrt_ptr_next;
        end
    end
endmodule
