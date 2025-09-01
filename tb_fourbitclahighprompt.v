`timescale 1ns / 1ps

module tb_fourbitclahighprompt();

reg  [3:0] a, b;
    reg        cin;
    wire [3:0] sum;
    wire       cout;

    // Instantiate the DUT
    fourbitcla_highprompt dut (
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
            $display("A=%b, B=%b, Cin=%b | Expected Sum=%b, Expected Cout=%b | Actual Sum=%b, Actual Cout=%b", ta, tb, tcin, expected_sum, expected_cout, sum, cout);
        end
    endtask

    initial begin
        $display("A    B    Cin | ExpSum Cout | ActSum Cout");
        $display("---------------------------------------------");
        // Test cases: a, b, cin, expected_sum, expected_cout
        test_case(4'b0000, 4'b0000, 1'b0, 4'b0000, 1'b0); // 0+0+0=0
        test_case(4'b0001, 4'b0010, 1'b0, 4'b0011, 1'b0); // 1+2+0=3
        test_case(4'b0101, 4'b0011, 1'b1, 4'b1001, 1'b0); // 5+3+1=9
        test_case(4'b1111, 4'b0001, 1'b0, 4'b0000, 1'b1); // 15+1+0=16
        test_case(4'b1010, 4'b0101, 1'b1, 4'b0000, 1'b1); // 10+5+1=16
        test_case(4'b0110, 4'b1001, 1'b0, 4'b1111, 1'b0); // 6+9+0=15
        test_case(4'b1100, 4'b0011, 1'b1, 4'b0000, 1'b1); // 12+3+1=16
        test_case(4'b1001, 4'b0110, 1'b1, 4'b0000, 1'b1); // 9+6+1=16
        test_case(4'b0111, 4'b0111, 1'b0, 4'b1110, 1'b0); // 7+7+0=14
        test_case(4'b1111, 4'b1111, 1'b1, 4'b1111, 1'b1); // 15+15+1=31
        test_case(4'b0010, 4'b1101, 1'b1, 4'b0000, 1'b1); // 2+13+1=16
        test_case(4'b0100, 4'b1011, 1'b0, 4'b1111, 1'b0); // 4+11+0=15
        test_case(4'b1000, 4'b1000, 1'b1, 4'b0001, 1'b1); // 8+8+1=17
        test_case(4'b0111, 4'b1001, 1'b1, 4'b0011, 1'b1); // 7+9+1=17
        test_case(4'b0001, 4'b1110, 1'b0, 4'b1111, 1'b0); // 1+14+0=15
        $display("2nd round of testbench cases"); 
        
        //2nd round of testing 
        test_case(4'b1101, 4'b0100, 1'b0, 4'b0001, 1'b1); // 13+4+0=17
        test_case(4'b0011, 4'b1010, 1'b1, 4'b1110, 1'b0); // 3+10+1=14
        test_case(4'b1000, 4'b0111, 1'b0, 4'b1111, 1'b0); // 8+7+0=15
        test_case(4'b0100, 4'b1110, 1'b1, 4'b0011, 1'b1); // 4+14+1=19
        test_case(4'b1010, 4'b0011, 1'b0, 4'b1101, 1'b0); // 10+3+0=13
        test_case(4'b0111, 4'b0100, 1'b1, 4'b1100, 1'b0); // 7+4+1=12
        test_case(4'b0001, 4'b1011, 1'b0, 4'b1100, 1'b0); // 1+11+0=12
        test_case(4'b1110, 4'b0010, 1'b1, 4'b0001, 1'b1); // 14+2+1=17
        test_case(4'b1001, 4'b0100, 1'b1, 4'b1110, 1'b0); // 9+4+1=14
        test_case(4'b0010, 4'b0111, 1'b0, 4'b1001, 1'b0); // 2+7+0=9
        $display("3rd round of testbench cases"); 
        
        //3rd round of testing 
        test_case(4'b1011, 4'b1100, 1'b1, 4'b1000, 1'b1); // 11+12+1=24
        test_case(4'b0101, 4'b1110, 1'b0, 4'b0011, 1'b1); // 5+14+0=19
        test_case(4'b1110, 4'b1001, 1'b1, 4'b1000, 1'b1); // 14+9+1=24
        test_case(4'b0011, 4'b0110, 1'b0, 4'b1001, 1'b0); // 3+6+0=9
        test_case(4'b1001, 4'b1101, 1'b0, 4'b0110, 1'b1); // 9+13+0=22
        test_case(4'b0110, 4'b0100, 1'b1, 4'b0001, 1'b1); // 6+4+1=11
        test_case(4'b1101, 4'b0010, 1'b0, 4'b1111, 1'b0); // 13+2+0=15
        test_case(4'b0001, 4'b1000, 1'b1, 4'b1001, 1'b0); // 1+8+1=10
        test_case(4'b1010, 4'b0111, 1'b1, 4'b0010, 1'b1); // 10+7+1=18
        test_case(4'b0100, 4'b0001, 1'b0, 4'b0101, 1'b0); // 4+1+0=5
        $display("4th round of testbench cases");
        
        //4th round of testing 
        test_case(4'b0101, 4'b1101, 1'b1, 4'b0001, 1'b1); // 5+13+1=19
        test_case(4'b0110, 4'b0011, 1'b1, 4'b1010, 1'b0); // 6+3+1=10
        test_case(4'b1110, 4'b0110, 1'b1, 4'b0011, 1'b1); // 14+6+1=21
        test_case(4'b1001, 4'b0001, 1'b1, 4'b1011, 1'b0); // 9+1+1=11
        test_case(4'b0010, 4'b1011, 1'b1, 4'b1110, 1'b0); // 2+11+1=14
        test_case(4'b1100, 4'b0101, 1'b1, 4'b0010, 1'b1); // 12+5+1=18
        test_case(4'b0111, 4'b1100, 1'b1, 4'b0100, 1'b1); // 7+12+1=20
        test_case(4'b0001, 4'b0110, 1'b1, 4'b1000, 1'b0); // 1+6+1=8
        test_case(4'b1010, 4'b1000, 1'b1, 4'b0011, 1'b1); // 10+8+1=19
        test_case(4'b0011, 4'b1111, 1'b1, 4'b0100, 1'b1); // 3+15+1=19
        $display("5th round of testbench cases");
        
        //5th round of testing 
        // --- New unpredictable Cin=0 test cases ---
        test_case(4'b0110, 4'b1010, 1'b0, 4'b0000, 1'b1); // 6+10+0=16
        test_case(4'b1101, 4'b0111, 1'b0, 4'b0100, 1'b1); // 13+7+0=20
        test_case(4'b1000, 4'b0011, 1'b0, 4'b1011, 1'b0); // 8+3+0=11
        test_case(4'b0101, 4'b1001, 1'b0, 4'b1110, 1'b0); // 5+9+0=14
        test_case(4'b1011, 4'b0101, 1'b0, 4'b0000, 1'b1); // 11+5+0=16
        test_case(4'b0010, 4'b1100, 1'b0, 4'b1110, 1'b0); // 2+12+0=14
        test_case(4'b1110, 4'b0001, 1'b0, 4'b1111, 1'b0); // 14+1+0=15
        test_case(4'b0111, 4'b1000, 1'b0, 4'b1111, 1'b0); // 7+8+0=15
        test_case(4'b1100, 4'b0110, 1'b0, 4'b0000, 1'b1); // 12+6+0=18
        test_case(4'b0011, 4'b1011, 1'b0, 4'b1110, 1'b0); // 3+11+0=14
        $finish;
    end
endmodule

//endmodule
