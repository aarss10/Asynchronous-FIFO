`timescale 1ns / 1ps
module bin_gray #(parameter width=3)(
    input [width :0] b,
    output [width :0] g
    );
     assign g = b ^ (b >> 1);
     
endmodule
