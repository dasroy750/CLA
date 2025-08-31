`timescale 1ns / 1ps



module fourbitcla_highprompt(
    input  [3:0] a,    // 4-bit input operand A
    input  [3:0] b,    // 4-bit input operand B
    input        cin,  // Carry-in
    output [3:0] sum,  // 4-bit sum output
    output       cout  // Carry-out
    );
     // Step 1: Generate and Propagate signals
    wire [3:0] g; // Generate
    wire [3:0] p; // Propagate
    assign g = a & b;
    assign p = a ^ b;

    // Step 2: Carry Lookahead Logic
    wire c1, c2, c3;
    assign c1 = g[0] | (p[0] & cin);
    assign c2 = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
    assign c3 = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);
    assign cout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & cin);

    // Step 3: Sum Calculation
    assign sum[0] = p[0] ^ cin;
    assign sum[1] = p[1] ^ c1;
    assign sum[2] = p[2] ^ c2;
    assign sum[3] = p[3] ^ c3;
endmodule
