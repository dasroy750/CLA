`timescale 1ns / 1ps

module fourbitcla_claudelow(
    input  [3:0] a,      // 4-bit input A
    input  [3:0] b,      // 4-bit input B
    input        cin,    // Carry input
    output [3:0] sum,    // 4-bit sum output
    output       cout    // Carry output
    );
    
     // Internal signals for generate and propagate
    wire [3:0] g;        // Generate signals
    wire [3:0] p;        // Propagate signals
    wire [3:0] c;        // Internal carry signals

    // Generate and Propagate logic for each bit
    assign g[0] = a[0] & b[0];           // Generate for bit 0
    assign g[1] = a[1] & b[1];           // Generate for bit 1
    assign g[2] = a[2] & b[2];           // Generate for bit 2
    assign g[3] = a[3] & b[3];           // Generate for bit 3

    assign p[0] = a[0] ^ b[0];           // Propagate for bit 0
    assign p[1] = a[1] ^ b[1];           // Propagate for bit 1
    assign p[2] = a[2] ^ b[2];           // Propagate for bit 2
    assign p[3] = a[3] ^ b[3];           // Propagate for bit 3

    // Carry lookahead logic
    assign c[0] = cin;                                    // Initial carry
    assign c[1] = g[0] | (p[0] & c[0]);                  // Carry to bit 1
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c[0]);  // Carry to bit 2
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c[0]);  // Carry to bit 3
    assign cout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & c[0]);  // Final carry out

    // Sum calculation
    assign sum[0] = p[0] ^ c[0];         // Sum for bit 0
    assign sum[1] = p[1] ^ c[1];         // Sum for bit 1
    assign sum[2] = p[2] ^ c[2];         // Sum for bit 2
    assign sum[3] = p[3] ^ c[3];         // Sum for bit 3

endmodule

//endmodule
