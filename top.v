`timescale 1ns / 1ps

module top #(parameter width = 8, depth = 8, ptr_w = $clog2(depth))(
    input wrt_clk,rd_clk,
    input rd_rst,
    input wrt_rst,
    input r_en,
    input w_en,
    input [width-1:0] data_in,
    output [width-1:0] data_out,
    output  full, empty
    );
    wire [ptr_w:0] g_wptr, wrt_out, g_rptr, rd_out;
    wire [ptr_w:0] g_wptr_sync, g_rptr_sync;
    
    //Binary to Gray
   bin_gray #(ptr_w)wrt(.b(wrt_out), .g(g_wptr));
   bin_gray #(ptr_w)rd(.b(rd_out), .g(g_rptr));
    //CDC
   stg_synth #(ptr_w)r2w(.gray_in(g_rptr),.clk(wrt_clk),.rst(wrt_rst),.gray_out(g_rptr_sync));
   stg_synth #(ptr_w)w2r(.gray_in(g_wptr),.clk(rd_clk),.rst(rd_rst),.gray_out(g_wptr_sync));
   
   //Empty Flag detection
   rd_src #(ptr_w) e_flag(.rd_clk(rd_clk), .rd_rst(rd_rst),.r_en(r_en),.rd_empty(empty), .rd_out(rd_out),.wrt_gray(g_wptr_sync));
    
   //Full Flag detection
   wrt_src #(ptr_w) f_flag(.wrt_clk(wrt_clk), .wrt_rst(wrt_rst),.w_en(w_en),.wrt_full(full), .wrt_out(wrt_out),.rd_gray(g_rptr_sync));

   //Memory
   mem #(ptr_w,width,depth) memory(.wrt_data(data_in),.rd_data(data_out),.rd_clk(rd_clk),.wrt_clk(wrt_clk),.w_en(w_en),.r_en(r_en),.wrt_full(full),.rd_empty(empty),.rd_ptr(rd_out[ptr_w-1:0]),.wrt_ptr(wrt_out[ptr_w-1:0]));
 
    endmodule
