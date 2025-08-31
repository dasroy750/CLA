`timescale 1ns / 1ps


/*module cla_carryGen(
    input  wire [3:0] P,
    input  wire [3:0] G,
    input  wire       C0,
    output wire [4:1] C   // carries C1..C4
    );
    
   //assign C[1] = G | (P & C0);
   // assign C = G | (P & G) | (P & P & C0);
   // assign C = G | (P & G) | (P & P & G) | (P & P & P & C0);
   // assign C = G | (P & G) | (P & P & G) |
                  (P & P & P & G) |
                  (P & P & P & P & C0);
                  
    assign C[1] = G | (P & C0);
    assign C[2] = G[1] | (P[1] & G) | (P[1] & P & C0);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G) | (P[2] & P[1] & P & C0);
    assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) |
                  (P[3] & P[2] & P[1] & G) |
                  (P[3] & P[2] & P[1] & P & C0);
                  
endmodule */
// [11] Carry Generator
module cla_carryGen(
    input  wire [3:0] P,
    input  wire [3:0] G,
    input  wire       C0,
    output wire [4:1] C // carries: C1, C2, C3, C4
);
    assign C[10] = G | (P & C0);
    assign C[11] = G[10] | (P[10] & G) | (P[10] & P & C0);
    assign C[12] = G[11] | (P[11] & G[10]) | (P[11] & P[10] & G) | (P[11] & P[10] & P & C0);
    assign C[13] = G[12] | (P[12] & G[11]) | (P[12] & P[11] & G[10]) |
                  (P[12] & P[11] & P[10] & G) |
                  (P[12] & P[11] & P[10] & P & C0);
endmodule


