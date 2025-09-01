`timescale 1ns / 1ps

module sim1_clafourbit1();
  reg [3:0] A, B;
  reg Cin;
  wire [3:0] Sum;
  wire Cout;

  // Instantiate the DUT (replace 'cla4' with your module name)
  cla_fourbit_trial1 uut (
    .a(A),
    .b(B),
    .cin(Cin),
    .sum(Sum),
    .cout(Cout)
    ) ; 
    initial begin
    // TestBench Cases from Perplexity
    
    /*$display("A      B      Cin | Sum    Cout | Expected Sum Cout");

    // Case 1
    A=4'b0000; B=4'b0000; Cin=0; #1;
    $display("%b %b %b | %b %b | 0000 0", A, B, Cin, Sum, Cout);

    // Case 2
    A=4'b0000; B=4'b0000; Cin=1; #1;
    $display("%b %b %b | %b %b | 0001 0", A, B, Cin, Sum, Cout);
    
    // Case 3
    A=4'b1111; B=4'b1111; Cin=0; #1;
    $display("%b %b %b | %b %b | 1110 1", A, B, Cin, Sum, Cout);

    // Case 4
    A=4'b1111; B=4'b1111; Cin=1; #1;
    $display("%b %b %b | %b %b | 1111 1", A, B, Cin, Sum, Cout);
    
    // Case 5
    A=4'b1001; B=4'b1001; Cin=1; #1;
    $display("%b %b %b | %b %b | 0011 1", A, B, Cin, Sum, Cout);

    // Case 6
    A=4'b1010; B=4'b0101; Cin=0; #1;
    $display("%b %b %b | %b %b | 1111 0", A, B, Cin, Sum, Cout);
    
    // Case 7
    A=4'b0001; B=4'b0001; Cin=0; #1;
    $display("%b %b %b | %b %b | 0010 0", A, B, Cin, Sum, Cout);

    // Case 8
    A=4'b0111; B=4'b0001; Cin=0; #1;
    $display("%b %b %b | %b %b | 1000 0", A, B, Cin, Sum, Cout);
    
    // Case 9
    A=4'b1111; B=4'b0001; Cin=0; #1;
    $display("%b %b %b | %b %b | 0000 1", A, B, Cin, Sum, Cout);

    // Case 10
    A=4'b0110; B=4'b0010; Cin=1; #1;
    $display("%b %b %b | %b %b | 0111 0", A, B, Cin, Sum, Cout);*/
    
    //Grok Testbench Cases 
    $display("A      B      Cin | Sum    Cout | Expected Sum Cout");
    
    //Case 1
    A=4'b0001; B=4'b0000; Cin=0; #1;
    $display("%b %b %b | %b %b | 0000 0", A, B, Cin, Sum, Cout);
    
     
    // Case 2
    A=4'b1111; B=4'b0000; Cin=1; #1;
    $display("%b %b %b | %b %b | 0000 1", A, B, Cin, Sum, Cout);
    
    // Case 3
    A=4'b1111; B=4'b0000; Cin=0; #1;
    $display("%b %b %b | %b %b | 0000 0", A, B, Cin, Sum, Cout);
    
    // Case 4
    A=4'b0010; B=4'b0011; Cin=0; #1;
    $display("%b %b %b | %b %b | 0101 0", A, B, Cin, Sum, Cout);
    
    // Case 5
    A=4'b0100; B=4'b0100; Cin=0; #1;
    $display("%b %b %b | %b %b | 1000 0", A, B, Cin, Sum, Cout);
    
    // Case 6
    A=4'b1001; B=4'b0010; Cin=1; #1;
    $display("%b %b %b | %b %b | 1100 0", A, B, Cin, Sum, Cout);
    
    // Case 7
    A=4'b0110; B=4'b0001; Cin=0; #1;
    $display("%b %b %b | %b %b | 0111 0", A, B, Cin, Sum, Cout);
    
    // Case 8
    A=4'b1011; B=4'b0100; Cin=1; #1;
    $display("%b %b %b | %b %b | 0000 1", A, B, Cin, Sum, Cout);
    
    // Case 9
    A=4'b1100; B=4'b0011; Cin=0; #1;
    $display("%b %b %b | %b %b | 1111 0", A, B, Cin, Sum, Cout);
    
    // Case 10
    A=4'b0001; B=4'b1110; Cin=0; #1;
    $display("%b %b %b | %b %b | 1111 0", A, B, Cin, Sum, Cout);
    
    // Case 11
    A=4'b0111; B=4'b1000; Cin=1; #1;
    $display("%b %b %b | %b %b | 0000 1", A, B, Cin, Sum, Cout);
    
    // Case 12
    A=4'b1010; B=4'b0111; Cin=0; #1;
    $display("%b %b %b | %b %b | 0001 1", A, B, Cin, Sum, Cout);

   // Case 13
    A=4'b0101; B=4'b1010; Cin=1; #1;
    $display("%b %b %b | %b %b | 0000 1", A, B, Cin, Sum, Cout);

    $finish;
  end
  
endmodule
