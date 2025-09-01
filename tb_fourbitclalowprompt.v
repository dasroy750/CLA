`timescale 1ns / 1ps

/*module tb_fourbitclalowprompt(

    );*/ 
    `timescale 1ns/1ps

module tb_fourbitclalowprompt;
    reg  [3:0] a, b;
    reg        cin;
    wire [3:0] sum;
    wire       cout;

    // Instantiate the DUT
    fourbitcla_lowprompt dut (
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
        test_case(4'b0000, 4'b0000, 1'b0, 4'b0000, 1'b0);
        test_case(4'b0001, 4'b0001, 1'b0, 4'b0010, 1'b0);
        test_case(4'b0011, 4'b0101, 1'b0, 4'b1000, 1'b0);
        test_case(4'b1111, 4'b0001, 1'b0, 4'b0000, 1'b1);
        test_case(4'b1010, 4'b0101, 1'b1, 4'b0000, 1'b1);
        test_case(4'b1111, 4'b1111, 1'b1, 4'b1111, 1'b1);
        test_case(4'b1001, 4'b0110, 1'b0, 4'b1111, 1'b0);
        test_case(4'b0111, 4'b0001, 1'b1, 4'b1001, 1'b0);
        test_case(4'b1100, 4'b0011, 1'b0, 4'b1111, 1'b0);
        test_case(4'b0101, 4'b1010, 1'b1, 4'b0000, 1'b1);
        
        $display("2nd round of test cases"); 
        
         // Additional unpredictable test cases
        test_case(4'b0010, 4'b1101, 1'b1, 4'b0000, 1'b1); // 2+13+1=16
        test_case(4'b0110, 4'b1000, 1'b0, 4'b1110, 1'b0); // 6+8=14
        test_case(4'b0100, 4'b0010, 1'b1, 4'b0111, 1'b0); // 4+2+1=7
        test_case(4'b1101, 4'b0111, 1'b0, 4'b0100, 1'b1); // 13+7=20
        test_case(4'b1011, 4'b1001, 1'b1, 4'b0001, 1'b1); // 11+9+1=21
        test_case(4'b0001, 4'b1100, 1'b1, 4'b1101, 1'b0); // 1+12+1=14
        test_case(4'b0111, 4'b1011, 1'b0, 4'b0010, 1'b1); // 7+11=18
        test_case(4'b1000, 4'b0011, 1'b1, 4'b1100, 1'b0); // 8+3+1=12
        test_case(4'b0101, 4'b0110, 1'b0, 4'b1011, 1'b0); // 5+6=11
        test_case(4'b1110, 4'b0100, 1'b1, 4'b0011, 1'b1); // 14+4+1=19
        $display("3rd round of test cases"); 
        
        //3rd round of testbench cases 
        test_case(4'b1100, 4'b1000, 1'b1, 4'b0001, 1'b1); // 12+8+1=21
        test_case(4'b0011, 4'b1010, 1'b1, 4'b1110, 1'b0); // 3+10+1=14
        test_case(4'b1000, 4'b0111, 1'b0, 4'b1111, 1'b0); // 8+7=15
        test_case(4'b0100, 4'b1110, 1'b1, 4'b0011, 1'b1); // 4+14+1=19
        test_case(4'b1010, 4'b0011, 1'b0, 4'b1101, 1'b0); // 10+3=13
        test_case(4'b0111, 4'b0100, 1'b1, 4'b1100, 1'b0); // 7+4+1=12
        test_case(4'b0001, 4'b1011, 1'b0, 4'b1100, 1'b0); // 1+11=12
        test_case(4'b1110, 4'b0010, 1'b1, 4'b0001, 1'b1); // 14+2+1=17
        test_case(4'b1001, 4'b0100, 1'b1, 4'b1110, 1'b0); // 9+4+1=14
        test_case(4'b0010, 4'b0111, 1'b0, 4'b1001, 1'b0); // 2+7=9
        $display("4th round of test cases"); 
        
        //4th round of testing
        test_case(4'b1101, 4'b1000, 1'b0, 4'b0101, 1'b1); // 13+8=21
        test_case(4'b0110, 4'b1101, 1'b1, 4'b0100, 1'b1); // 6+13+1=20
        test_case(4'b1011, 4'b0111, 1'b1, 4'b0011, 1'b1); // 11+7+1=19
        test_case(4'b0011, 4'b1100, 1'b0, 4'b1111, 1'b0); // 3+12=15
        test_case(4'b1111, 4'b0101, 1'b1, 4'b0101, 1'b1); // 15+5+1=21
        test_case(4'b0101, 4'b1001, 1'b0, 4'b1110, 1'b0); // 5+9=14
        test_case(4'b1000, 4'b1010, 1'b1, 4'b0011, 1'b1); // 8+10+1=19
        test_case(4'b0111, 4'b0010, 1'b1, 4'b1010, 1'b0); // 7+2+1=10
        test_case(4'b0000, 4'b1111, 1'b1, 4'b0000, 1'b1); // 0+15+1=16
        test_case(4'b1010, 4'b1100, 1'b0, 4'b0110, 1'b1); // 10+12=22
        $finish;
    end
endmodule

//endmodule
