`timescale 1ns / 1ps


module tb_fourbitcla_claudelow();
    reg  [3:0] a, b;
    reg        cin;
    wire [3:0] sum;
    wire       cout;

    // Instantiate the DUT (Device Under Test)
    fourbitcla_claudelow dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    // Task to apply a test vector and display results
    task test_case;
        input [3:0] ta, tb;
        input tcin;
        input [3:0] expected_sum;
        input expected_cout;
        begin
            a = ta; b = tb; cin = tcin;
            #1; // Wait for outputs to settle
            $display("A=%b, B=%b, Cin=%b | Expected Sum=%b, Expected Cout=%b | Actual Sum=%b, Actual Cout=%b", 
                     ta, tb, tcin, expected_sum, expected_cout, sum, cout);
            
            // Check if results match expected values
            if (sum !== expected_sum || cout !== expected_cout) begin
                $display("ERROR: Mismatch detected!");
            end
        end
    endtask

    initial begin
        $display("Testing 4-bit Carry Lookahead Adder");
        $display("=====================================================");
        $display("A    B    Cin | ExpSum Cout | ActSum Cout");
        $display("---------------------------------------------");
        
        // Non-patterned test cases with mixed cin values
        test_case(4'b1010, 4'b0110, 1'b0, 4'b0000, 1'b1); // 10+6+0=16
        test_case(4'b0011, 4'b1101, 1'b1, 4'b0001, 1'b1); // 3+13+1=17
        test_case(4'b1000, 4'b0101, 1'b0, 4'b1101, 1'b0); // 8+5+0=13
        test_case(4'b0111, 4'b1001, 1'b1, 4'b0001, 1'b1); // 7+9+1=17
        test_case(4'b1100, 4'b0011, 1'b0, 4'b1111, 1'b0); // 12+3+0=15
        test_case(4'b0001, 4'b1110, 1'b1, 4'b0000, 1'b1); // 1+14+1=16
        test_case(4'b1011, 4'b0100, 1'b0, 4'b1111, 1'b0); // 11+4+0=15
        test_case(4'b0110, 4'b1000, 1'b1, 4'b1111, 1'b0); // 6+8+1=15
        test_case(4'b1001, 4'b0010, 1'b0, 4'b1011, 1'b0); // 9+2+0=11
        test_case(4'b0100, 4'b1011, 1'b1, 4'b0000, 1'b1); // 4+11+1=16
        
        test_case(4'b1110, 4'b0001, 1'b0, 4'b1111, 1'b0); // 14+1+0=15
        test_case(4'b0010, 4'b0111, 1'b1, 4'b1010, 1'b0); // 2+7+1=10
        test_case(4'b1101, 4'b1000, 1'b0, 4'b0101, 1'b1); // 13+8+0=21
        test_case(4'b0101, 4'b0011, 1'b1, 4'b1001, 1'b0); // 5+3+1=9
        test_case(4'b1000, 4'b1100, 1'b0, 4'b0100, 1'b1); // 8+12+0=20
        test_case(4'b0111, 4'b0101, 1'b1, 4'b1101, 1'b0); // 7+5+1=13
        test_case(4'b1111, 4'b0001, 1'b0, 4'b0000, 1'b1); // 15+1+0=16
        test_case(4'b0001, 4'b0010, 1'b1, 4'b0100, 1'b0); // 1+2+1=4
        test_case(4'b1001, 4'b1110, 1'b0, 4'b0111, 1'b1); // 9+14+0=23
        test_case(4'b0011, 4'b0100, 1'b1, 4'b1000, 1'b0); // 3+4+1=8
        
        test_case(4'b1010, 4'b1011, 1'b0, 4'b0101, 1'b1); // 10+11+0=21
        test_case(4'b0110, 4'b0001, 1'b1, 4'b1000, 1'b0); // 6+1+1=8
        test_case(4'b1100, 4'b1001, 1'b0, 4'b0101, 1'b1); // 12+9+0=21
        test_case(4'b0100, 4'b0110, 1'b1, 4'b1011, 1'b0); // 4+6+1=11
        test_case(4'b1111, 4'b1111, 1'b1, 4'b1111, 1'b1); // 15+15+1=31
        test_case(4'b0000, 4'b0000, 1'b0, 4'b0000, 1'b0); // 0+0+0=0
        test_case(4'b1011, 4'b0111, 1'b1, 4'b0011, 1'b1); // 11+7+1=19
        test_case(4'b0101, 4'b1010, 1'b0, 4'b1111, 1'b0); // 5+10+0=15
        test_case(4'b1000, 4'b0010, 1'b1, 4'b1011, 1'b0); // 8+2+1=11
        test_case(4'b0011, 4'b1100, 1'b0, 4'b1111, 1'b0); // 3+12+0=15
        // New challenging test cases exploring different sum values and scenarios
        // Testing sum=1 with different input combinations
        test_case(4'b0000, 4'b0000, 1'b1, 4'b0001, 1'b0); // 0+0+1=1
        test_case(4'b0000, 4'b0001, 1'b0, 4'b0001, 1'b0); // 0+1+0=1
        
        // Testing sum=2 with varied approaches
        test_case(4'b0001, 4'b0001, 1'b0, 4'b0010, 1'b0); // 1+1+0=2
        test_case(4'b0000, 4'b0001, 1'b1, 4'b0010, 1'b0); // 0+1+1=2
        
        // Testing sum=3 exploring carry chains
        test_case(4'b0001, 4'b0001, 1'b1, 4'b0011, 1'b0); // 1+1+1=3
        test_case(4'b0010, 4'b0001, 1'b0, 4'b0011, 1'b0); // 2+1+0=3
        
        // Testing sum=5 with different bit patterns
        test_case(4'b0010, 4'b0010, 1'b1, 4'b0101, 1'b0); // 2+2+1=5
        test_case(4'b0100, 4'b0000, 1'b1, 4'b0101, 1'b0); // 4+0+1=5
        
        // Testing sum=6 with challenging patterns
        test_case(4'b0010, 4'b0011, 1'b1, 4'b0110, 1'b0); // 2+3+1=6
        test_case(4'b0101, 4'b0000, 1'b1, 4'b0110, 1'b0); // 5+0+1=6
        
        // Testing sum=7 with complex bit interactions
        test_case(4'b0011, 4'b0011, 1'b1, 4'b0111, 1'b0); // 3+3+1=7
        test_case(4'b0110, 4'b0000, 1'b1, 4'b0111, 1'b0); // 6+0+1=7
        
        // Testing sum=10 with varied inputs
        test_case(4'b0100, 4'b0101, 1'b1, 4'b1010, 1'b0); // 4+5+1=10
        test_case(4'b0111, 4'b0010, 1'b1, 4'b1010, 1'b0); // 7+2+1=10
        
        // Testing sum=12 with different approaches
        test_case(4'b0101, 4'b0110, 1'b1, 4'b1100, 1'b0); // 5+6+1=12
        test_case(4'b1000, 4'b0011, 1'b1, 4'b1100, 1'b0); // 8+3+1=12
        
        // Testing sum=14 exploring high-bit combinations
        test_case(4'b0110, 4'b0111, 1'b1, 4'b1110, 1'b0); // 6+7+1=14
        test_case(4'b1001, 4'b0100, 1'b1, 4'b1110, 1'b0); // 9+4+1=14
        
        // Testing challenging overflow cases (sum > 15)
        test_case(4'b1110, 4'b0010, 1'b1, 4'b0001, 1'b1); // 14+2+1=17
        test_case(4'b1010, 4'b0111, 1'b1, 4'b0010, 1'b1); // 10+7+1=18
        test_case(4'b1101, 4'b0101, 1'b1, 4'b0011, 1'b1); // 13+5+1=19
        test_case(4'b1100, 4'b0110, 1'b1, 4'b0011, 1'b1); // 12+6+1=19
        test_case(4'b1011, 4'b1000, 1'b1, 4'b0100, 1'b1); // 11+8+1=20
        test_case(4'b1110, 4'b0110, 1'b1, 4'b0101, 1'b1); // 14+6+1=21
        test_case(4'b1101, 4'b1001, 1'b0, 4'b0110, 1'b1); // 13+9+0=22
        test_case(4'b1111, 4'b1000, 1'b0, 4'b0111, 1'b1); // 15+8+0=23
        test_case(4'b1110, 4'b1010, 1'b0, 4'b1000, 1'b1); // 14+10+0=24
        test_case(4'b1101, 4'b1100, 1'b0, 4'b1001, 1'b1); // 13+12+0=25
        test_case(4'b1111, 4'b1010, 1'b1, 4'b1010, 1'b1); // 15+10+1=26
        test_case(4'b1110, 4'b1101, 1'b0, 4'b1011, 1'b1); // 14+13+0=27
        test_case(4'b1111, 4'b1100, 1'b1, 4'b1100, 1'b1); // 15+12+1=28
        test_case(4'b1111, 4'b1101, 1'b1, 4'b1101, 1'b1); // 15+13+1=29
        test_case(4'b1111, 4'b1110, 1'b1, 4'b1110, 1'b1); // 15+14+1=30
        
        $display("=====================================================");
        $display("Testbench completed!");
        $finish;
    end
    
    // Monitor to track changes
    initial begin
        $monitor("Time=%0t: A=%b B=%b Cin=%b Sum=%b Cout=%b", 
                 $time, a, b, cin, sum, cout);
    end

endmodule

//endmodule
