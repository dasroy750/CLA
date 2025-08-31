`timescale 1ns / 1ps


module cla_fourbit_trial1(
    input [3:0] a,    // First 4-bit input
    input [3:0] b,    // Second 4-bit input
    input cin,        // Carry input
    output [3:0] sum, // 4-bit sum output
    output cout       // Carry output
    );
    
    wire [3:0] p, g;  // Propagate and generate
    wire [4:0] c;     // Carry

    // Assign carry input
    assign c[0] = cin;

    // Generate and propagate
    assign p = a ^ b; // Propagate
    assign g = a & b; // Generate

    // Carry lookahead logic
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & c[1]);
    assign c[3] = g[2] | (p[2] & c[2]);
    assign c[4] = g[3] | (p[3] & c[3]);

    // Sum calculation
    assign sum = p ^ c[3:0];

    // Carry out
    assign cout = c[4];


endmodule
