`timescale 1ns / 1ps

module fourbitcla_lowprompt(
    input  [3:0] a,      // 4-bit input A
    input  [3:0] b,      // 4-bit input B
    input        cin,    // Carry input
    output [3:0] sum,    // 4-bit sum output
    output       cout    // Carry output
    );
    wire [3:0] p, g;     // Propagate and generate
    wire [3:1] c;        // Internal carries

    // Propagate and generate
    assign p = a ^ b;
    assign g = a & b;

    // Carry lookahead logic
    assign c[1] = g[0] | (p[0] & cin);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);
    assign cout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & cin);

    // Sum logic
    assign sum[0] = p[0] ^ cin;
    assign sum[1] = p[1] ^ c[1];
    assign sum[2] = p[2] ^ c[2];
    assign sum[3] = p[3] ^ c[3];
endmodule
