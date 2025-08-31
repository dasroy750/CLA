`timescale 1ns / 1ps

/*module pg_unit(
    input  wire a,
    input  wire b,
    output wire p,
    output wire g
    );
    
    assign p = a ^ b;  // propagate
    assign g = a & b;  // generate
endmodule
*/
// [10] Propagate/Generate unit
module pg_unit(
    input  wire a,
    input  wire b,
    output wire p,
    output wire g
);
    assign p = a ^ b;
    assign g = a & b;
endmodule
