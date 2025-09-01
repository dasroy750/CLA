`timescale 1ns / 1ps


/*module tb_cla_4bit_onlyperplexity();


// DUT inputs and outputs
    reg  [3:0] A, B;
    reg        Cin;
    wire [3:0] Sum;
    wire       Cout;
    
    // Instantiate Device Under Test (DUT)
    cla_4bit_trial2_perplexity dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );
     // Dump simulation for waveform
    initial begin
        $dumpfile("cla_4bit_tb.vcd");
        $dumpvars(0, tb_cla_4bit);
    end
    
    task check_result;
        input [3:0] a_in, b_in;
        input       cin_in;
        reg   [4:0] expected;
    begin
        expected = a_in + b_in + cin_in;
        if ({Cout,Sum} !== expected) begin
            $display("ERROR @ %0t: A=%b, B=%b, Cin=%b => DUT={Cout=%b,Sum=%b}, Expected=%b",
                     $time, a_in, b_in, cin_in, Cout, Sum, expected);
        end else begin
            $display("PASS  @ %0t: A=%b, B=%b, Cin=%b => {Cout,Sum}=%b",
                     $time, a_in, b_in, cin_in, {Cout, Sum});
        end
    end
    endtask

 // Apply stimulus
    initial begin
        // Corner cases first
        $display("===== Corner Case Testing =====");
        A=4'b0000; B=4'b0000; Cin=0; #5; check_result(A,B,Cin);
        A=4'b1111; B=4'b1111; Cin=0; #5; check_result(A,B,Cin);
        A=4'b1111; B=4'b1111; Cin=1; #5; check_result(A,B,Cin);
        A=4'b1010; B=4'b0101; Cin=1; #5; check_result(A,B,Cin);

        // Explicit directed OVERFLOW case
        $display("===== Directed Overflow Testing =====");
        A=4'b1000; B=4'b1000; Cin=1; #5; check_result(A,B,Cin);  // 8+8+1 = 17 => Sum=0001, Cout=1
        A=4'b1110; B=4'b0011; Cin=1; #5; check_result(A,B,Cin);  // 14+3+1 = 18 => Sum=0010, Cout=1
        
         // Randomized stimulus
        $display("===== Random Testing =====");
        repeat(20) begin
            A   = $random;
            B   = $random;
            Cin = $random;
            #5;
            check_result(A,B,Cin);
        end

        $display("===== Simulation Completed =====");
        $finish;
    end

endmodule*/

module tb_cla_4bit_onlyperplexity();

    reg  [3:0] A, B;
    reg        Cin;
    wire [3:0] Sum;
    wire       Cout;

    // Instantiate your correct DUT module here:
    cla_4bit_trial2_perplexity dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );
    
    initial begin
        $dumpfile("cla_4bit_tb.vcd");
        $dumpvars(0, tb_cla_4bit_onlyperplexity);  // Match testbench module name exactly
    end
    
    task check_result;
        input [3:0] a_in, b_in;
        input       cin_in;
        reg   [4:0] expected;
    begin
        expected = a_in + b_in + cin_in;
        if ({Cout,Sum} !== expected) begin
            $display("ERROR @ %0t: A=%b, B=%b, Cin=%b => DUT={Cout=%b, Sum=%b}, Expected=%b",
                     $time, a_in, b_in, cin_in, Cout, Sum, expected);
        end else begin
            $display("PASS  @ %0t: A=%b, B=%b, Cin=%b => {Cout,Sum}=%b",
                     $time, a_in, b_in, cin_in, {Cout, Sum});
        end
    end
    endtask
    
    initial begin
        // Corner cases
        $display("===== Corner Case Testing =====");
        A=4'b0000; B=4'b0000; Cin=0; #5; check_result(A,B,Cin);
        A=4'b1111; B=4'b1111; Cin=0; #5; check_result(A,B,Cin);
        A=4'b1111; B=4'b1111; Cin=1; #5; check_result(A,B,Cin);
        A=4'b1010; B=4'b0101; Cin=1; #5; check_result(A,B,Cin);

        // Directed overflow cases
        $display("===== Directed Overflow Testing =====");
        A=4'b1000; B=4'b1000; Cin=1; #5; check_result(A,B,Cin);
        A=4'b1110; B=4'b0011; Cin=1; #5; check_result(A,B,Cin);
        

         // Random tests
        $display("===== Random Testing =====");
        repeat(20) begin
            A   = $random;
            B   = $random;
            Cin = $random;
            #5;
            check_result(A,B,Cin);
        end

        $display("===== Simulation Completed =====");
        $finish;
    end

endmodule
    