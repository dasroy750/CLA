`timescale 1ns / 1ps

/*module sim3_clafourbit(

    );
endmodule*/

/*module sim3_clafourbit();

    // Testbench signals
    reg [3:0] a;
    reg [3:0] b;
    reg cin;
    wire [3:0] sum;
    wire cout;
    
    // Expected results for verification
    reg [4:0] expected_result;
    integer test_count;
    integer error_count;
    integer i;

    // Instantiate the DUT (Design Under Test)
    cla_fourbit_trial1 dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    // Enhanced task to check results with detailed reporting
    task check_result;
        input [31:0] test_id;
        begin
            expected_result = a + b + cin;
            if ({cout, sum} !== expected_result) begin
                $display("ERROR in Test %0d at time %0t: a=%4b (%2d), b=%4b (%2d), cin=%b", 
                         test_id, $time, a, a, b, b, cin);
                $display("  Expected: cout=%b, sum=%4b (total=%2d)", 
                         expected_result[4], expected_result[3:0], expected_result);
                $display("  Actual:   cout=%b, sum=%4b (total=%2d)", 
                         cout, sum, {cout, sum});
                $display("  Difference: %0d", $signed(expected_result) - $signed({cout, sum}));
                error_count = error_count + 1;
            end else begin
                $display("PASS Test %2d: a=%4b(%2d) + b=%4b(%2d) + cin=%b = cout=%b sum=%4b (%2d)", 
                         test_id, a, a, b, b, cin, cout, sum, {cout, sum});
            end
            test_count = test_count + 1;
        end
    endtask

    initial begin
        // Initialize
        test_count = 0;
        error_count = 0;
        
        $display("================================================================");
        $display("=== Enhanced Random Testbench for 4-bit Carry Lookahead Adder ===");
        $display("================================================================");
        $display("Starting simulation at time: %0t", $time);
        $display("");
        
        // Group 1: Completely random non-sequential test vectors
        #7; a = 4'b1101; b = 4'b0011; cin = 1'b0; #3; check_result(1);
        #11; a = 4'b0110; b = 4'b1001; cin = 1'b1; #4; check_result(2);
        #8; a = 4'b1010; b = 4'b0100; cin = 1'b0; #6; check_result(3);
        #13; a = 4'b0001; b = 4'b1110; cin = 1'b1; #2; check_result(4);
        #9; a = 4'b1111; b = 4'b0010; cin = 1'b0; #5; check_result(5);
        #12; a = 4'b0100; b = 4'b1011; cin = 1'b1; #7; check_result(6);
        #6; a = 4'b1000; b = 4'b0111; cin = 1'b0; #4; check_result(7);
        #14; a = 4'b0011; b = 4'b1100; cin = 1'b1; #3; check_result(8);
        #10; a = 4'b1110; b = 4'b0001; cin = 1'b0; #8; check_result(9);
        #5; a = 4'b0111; b = 4'b1010; cin = 1'b1; #6; check_result(10);
        
        $display("\n--- Group 1 completed: Random vectors with irregular timing ---");
        
        // Group 2: High entropy bit patterns with pseudo-random carries
        #15; a = 4'b1011; b = 4'b0101; cin = 1'b1; #2; check_result(11);
        #7; a = 4'b0010; b = 4'b1101; cin = 1'b0; #9; check_result(12);
        #11; a = 4'b1001; b = 4'b0110; cin = 1'b1; #4; check_result(13);
        #6; a = 4'b0101; b = 4'b1000; cin = 1'b0; #7; check_result(14);
        #13; a = 4'b1100; b = 4'b0011; cin = 1'b1; #3; check_result(15);
        #8; a = 4'b0000; b = 4'b1111; cin = 1'b0; #5; check_result(16);
        #12; a = 4'b1111; b = 4'b0000; cin = 1'b1; #6; check_result(17);
        #9; a = 4'b0110; b = 4'b1001; cin = 1'b0; #4; check_result(18);
        #14; a = 4'b1010; b = 4'b0100; cin = 1'b1; #8; check_result(19);
        #5; a = 4'b0001; b = 4'b1110; cin = 1'b0; #7; check_result(20);
        
        $display("\n--- Group 2 completed: High entropy patterns ---");
        
        // Group 3: Avoiding any sequential or predictable patterns
        #16; a = 4'b1000; b = 4'b0010; cin = 1'b1; #3; check_result(21);
        #6; a = 4'b0111; b = 4'b1101; cin = 1'b0; #8; check_result(22);
        #11; a = 4'b1110; b = 4'b0110; cin = 1'b1; #5; check_result(23);
        #9; a = 4'b0011; b = 4'b1001; cin = 1'b0; #7; check_result(24);
        #13; a = 4'b1101; b = 4'b0001; cin = 1'b1; #4; check_result(25);
        #7; a = 4'b0100; b = 4'b1010; cin = 1'b0; #6; check_result(26);
        #12; a = 4'b1011; b = 4'b0111; cin = 1'b1; #2; check_result(27);
        #8; a = 4'b0110; b = 4'b1100; cin = 1'b0; #9; check_result(28);
        #15; a = 4'b1001; b = 4'b0011; cin = 1'b1; #3; check_result(29);
        #5; a = 4'b0010; b = 4'b1111; cin = 1'b0; #8; check_result(30);
        
        $display("\n--- Group 3 completed: Anti-pattern vectors ---");
        
        // Group 4: Edge cases mixed with random patterns
        #10; a = 4'b1111; b = 4'b1111; cin = 1'b1; #4; check_result(31); // Max overflow
        #7; a = 4'b0000; b = 4'b0000; cin = 1'b0; #6; check_result(32); // Zero case
        #14; a = 4'b1010; b = 4'b0101; cin = 1'b1; #3; check_result(33); // Complement
        #8; a = 4'b0101; b = 4'b1010; cin = 1'b0; #5; check_result(34); // Inverse complement
        #11; a = 4'b1100; b = 4'b0011; cin = 1'b1; #7; check_result(35); // Split pattern
        #6; a = 4'b0011; b = 4'b1100; cin = 1'b0; #4; check_result(36); // Inverse split
        #13; a = 4'b1111; b = 4'b0000; cin = 1'b1; #8; check_result(37); // Max + min
        #9; a = 4'b0000; b = 4'b1111; cin = 1'b0; #2; check_result(38); // Min + max
        
        $display("\n--- Group 4 completed: Edge cases with randomization ---");
        
        // Group 5: Prime-number inspired pseudo-random sequences
        #17; a = 4'b0111; b = 4'b1011; cin = 1'b1; #3; check_result(39);
        #11; a = 4'b1101; b = 4'b0010; cin = 1'b0; #7; check_result(40);
        #5; a = 4'b0100; b = 4'b1001; cin = 1'b1; #9; check_result(41);
        #13; a = 4'b1110; b = 4'b0101; cin = 1'b0; #4; check_result(42);
        #7; a = 4'b0001; b = 4'b1100; cin = 1'b1; #6; check_result(43);
        #19; a = 4'b1010; b = 4'b0110; cin = 1'b0; #2; check_result(44);
        #8; a = 4'b0011; b = 4'b1000; cin = 1'b1; #8; check_result(45);
        #14; a = 4'b1001; b = 4'b0111; cin = 1'b0; #5; check_result(46);
        #6; a = 4'b0110; b = 4'b1101; cin = 1'b1; #7; check_result(47);
        #12; a = 4'b1011; b = 4'b0000; cin = 1'b0; #3; check_result(48);
        
        $display("\n--- Group 5 completed: Prime-inspired sequences ---");
        
        // Group 6: Fibonacci-mod-16 inspired patterns (but randomized)
        #9; a = 4'b1000; b = 4'b1101; cin = 1'b1; #6; check_result(49);
        #15; a = 4'b0010; b = 4'b0111; cin = 1'b0; #4; check_result(50);
        #7; a = 4'b1111; b = 4'b1010; cin = 1'b1; #8; check_result(51);
        #11; a = 4'b0100; b = 4'b0001; cin = 1'b0; #3; check_result(52);
        #6; a = 4'b1001; b = 4'b1100; cin = 1'b1; #7; check_result(53);
        #13; a = 4'b0011; b = 4'b0110; cin = 1'b0; #5; check_result(54);
        #8; a = 4'b1110; b = 4'b1011; cin = 1'b1; #9; check_result(55);
        #16; a = 4'b0101; b = 4'b0000; cin = 1'b0; #2; check_result(56);
        #5; a = 4'b1100; b = 4'b1001; cin = 1'b1; #6; check_result(57);
        #12; a = 4'b0111; b = 4'b0010; cin = 1'b0; #4; check_result(58);
        
        $display("\n--- Group 6 completed: Modified Fibonacci patterns ---");
        
        // Group 7: Chaos-theory inspired test vectors
        #18; a = 4'b1010; b = 4'b1111; cin = 1'b0; #3; check_result(59);
        #7; a = 4'b0001; b = 4'b0100; cin = 1'b1; #8; check_result(60);
        #14; a = 4'b1101; b = 4'b1000; cin = 1'b0; #5; check_result(61);
        #9; a = 4'b0110; b = 4'b0011; cin = 1'b1; #7; check_result(62);
        #11; a = 4'b1011; b = 4'b1110; cin = 1'b0; #4; check_result(63);
        #6; a = 4'b0000; b = 4'b0101; cin = 1'b1; #9; check_result(64);
        #15; a = 4'b1100; b = 4'b0111; cin = 1'b0; #2; check_result(65);
        #8; a = 4'b0010; b = 4'b1001; cin = 1'b1; #6; check_result(66);
        #13; a = 4'b1111; b = 4'b0110; cin = 1'b0; #7; check_result(67);
        #5; a = 4'b0100; b = 4'b1010; cin = 1'b1; #4; check_result(68);
        
        $display("\n--- Group 7 completed: Chaos-inspired vectors ---");
        
        // Group 8: Final burst of truly random vectors
        #17; a = 4'b0111; b = 4'b1100; cin = 1'b0; #3; check_result(69);
        #6; a = 4'b1001; b = 4'b0010; cin = 1'b1; #8; check_result(70);
        #12; a = 4'b0101; b = 4'b1111; cin = 1'b0; #5; check_result(71);
        #9; a = 4'b1110; b = 4'b0001; cin = 1'b1; #7; check_result(72);
        #14; a = 4'b0011; b = 4'b1010; cin = 1'b0; #4; check_result(73);
        #7; a = 4'b1000; b = 4'b0110; cin = 1'b1; #6; check_result(74);
        #11; a = 4'b0100; b = 4'b1101; cin = 1'b0; #3; check_result(75);
        #16; a = 4'b1011; b = 4'b0000; cin = 1'b1; #8; check_result(76);
        #5; a = 4'b0110; b = 4'b1000; cin = 1'b0; #7; check_result(77);
        #13; a = 4'b1101; b = 4'b0111; cin = 1'b1; #2; check_result(78);
        
        $display("\n--- Group 8 completed: Final random burst ---");
        
        // Stress test with rapid-fire random vectors
        $display("\n--- Stress Test: Rapid random vectors ---");
        #3; a = 4'b1111; b = 4'b1011; cin = 1'b0; #1; check_result(79);
        #2; a = 4'b0010; b = 4'b0101; cin = 1'b1; #1; check_result(80);
        #3; a = 4'b1000; b = 4'b1100; cin = 1'b0; #1; check_result(81);
        #2; a = 4'b0111; b = 4'b0001; cin = 1'b1; #1; check_result(82);
        #3; a = 4'b1010; b = 4'b1110; cin = 1'b0; #1; check_result(83);
        #2; a = 4'b0100; b = 4'b0011; cin = 1'b1; #1; check_result(84);
        #3; a = 4'b1101; b = 4'b1001; cin = 1'b0; #1; check_result(85);
        #2; a = 4'b0001; b = 4'b0110; cin = 1'b1; #1; check_result(86);
        #3; a = 4'b1110; b = 4'b1000; cin = 1'b0; #1; check_result(87);
        #2; a = 4'b0011; b = 4'b0111; cin = 1'b1; #1; check_result(88);
        
        // Final comprehensive summary
        #25;
        $display("\n================================================================");
        $display("=== FINAL TEST SUMMARY ===");
        $display("================================================================");
        $display("Total test vectors executed: %0d", test_count);
        $display("Total errors detected: %0d", error_count);
        $display("Success rate: %0.2f%%", (real'(test_count - error_count) / real'(test_count)) * 100.0);
        
        if (error_count == 0) begin
            $display("🎉 SUCCESS: All tests passed! CLA implementation is verified correct.");
        end else begin
            $display("❌ FAILURE: %0d out of %0d tests failed!", error_count, test_count);
            $display("Error rate: %0.2f%%", (real'(error_count) / real'(test_count)) * 100.0);
        end
        
        $display("Simulation completed at time: %0t ns", $time);
        $display("================================================================");
        
        $finish;
    end

endmodule*/ 
module sim3_clafourbit(); 
 // Testbench signals
    reg [3:0] a;
    reg [3:0] b;
    reg cin;
    wire [3:0] sum;
    wire cout;
    
    // Expected results for verification
    reg [4:0] expected_result;
    integer test_count;
    integer error_count;

    // Instantiate the DUT (Design Under Test)
    cla_fourbit_trial1 dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    // Enhanced task to check results with detailed reporting
    task check_result;
        input [31:0] test_id;
        begin
            expected_result = a + b + cin;
            if ({cout, sum} !== expected_result) begin
                $display("ERROR in Test %0d at time %0t: a=%4b (%2d), b=%4b (%2d), cin=%b", 
                         test_id, $time, a, a, b, b, cin);
                $display("  Expected: cout=%b, sum=%4b (total=%2d)", 
                         expected_result[4], expected_result[3:0], expected_result);
                $display("  Actual:   cout=%b, sum=%4b (total=%2d)", 
                         cout, sum, {cout, sum});
                $display("  Difference: %0d", expected_result - {cout, sum});
                error_count = error_count + 1;
            end else begin
                $display("PASS Test %2d: a=%4b(%2d) + b=%4b(%2d) + cin=%b = cout=%b sum=%4b (%2d)", 
                         test_id, a, a, b, b, cin, cout, sum, {cout, sum});
            end
            test_count = test_count + 1;
        end
    endtask

    initial begin
        // Initialize
        test_count = 0;
        error_count = 0;
        
        $display("================================================================");
        $display("=== Enhanced Random Testbench for 4-bit Carry Lookahead Adder ===");
        $display("================================================================");
        $display("Starting simulation at time: %0t", $time);
        $display("");
        
        // Group 1: Completely random non-sequential test vectors
        #7; a = 4'b1101; b = 4'b0011; cin = 1'b0; #3; check_result(1);
        #11; a = 4'b0110; b = 4'b1001; cin = 1'b1; #4; check_result(2);
        #8; a = 4'b1010; b = 4'b0100; cin = 1'b0; #6; check_result(3);
        #13; a = 4'b0001; b = 4'b1110; cin = 1'b1; #2; check_result(4);
        #9; a = 4'b1111; b = 4'b0010; cin = 1'b0; #5; check_result(5);
        #12; a = 4'b0100; b = 4'b1011; cin = 1'b1; #7; check_result(6);
        #6; a = 4'b1000; b = 4'b0111; cin = 1'b0; #4; check_result(7);
        #14; a = 4'b0011; b = 4'b1100; cin = 1'b1; #3; check_result(8);
        #10; a = 4'b1110; b = 4'b0001; cin = 1'b0; #8; check_result(9);
        #5; a = 4'b0111; b = 4'b1010; cin = 1'b1; #6; check_result(10);
        
        $display("");
        $display("--- Group 1 completed: Random vectors with irregular timing ---");
        
        // Group 2: High entropy bit patterns with pseudo-random carries
        #15; a = 4'b1011; b = 4'b0101; cin = 1'b1; #2; check_result(11);
        #7; a = 4'b0010; b = 4'b1101; cin = 1'b0; #9; check_result(12);
        #11; a = 4'b1001; b = 4'b0110; cin = 1'b1; #4; check_result(13);
        #6; a = 4'b0101; b = 4'b1000; cin = 1'b0; #7; check_result(14);
        #13; a = 4'b1100; b = 4'b0011; cin = 1'b1; #3; check_result(15);
        #8; a = 4'b0000; b = 4'b1111; cin = 1'b0; #5; check_result(16);
        #12; a = 4'b1111; b = 4'b0000; cin = 1'b1; #6; check_result(17);
        #9; a = 4'b0110; b = 4'b1001; cin = 1'b0; #4; check_result(18);
        #14; a = 4'b1010; b = 4'b0100; cin = 1'b1; #8; check_result(19);
        #5; a = 4'b0001; b = 4'b1110; cin = 1'b0; #7; check_result(20);
        
        $display("");
        $display("--- Group 2 completed: High entropy patterns ---");
        
        // Group 3: Avoiding any sequential or predictable patterns
        #16; a = 4'b1000; b = 4'b0010; cin = 1'b1; #3; check_result(21);
        #6; a = 4'b0111; b = 4'b1101; cin = 1'b0; #8; check_result(22);
        #11; a = 4'b1110; b = 4'b0110; cin = 1'b1; #5; check_result(23);
        #9; a = 4'b0011; b = 4'b1001; cin = 1'b0; #7; check_result(24);
        #13; a = 4'b1101; b = 4'b0001; cin = 1'b1; #4; check_result(25);
        #7; a = 4'b0100; b = 4'b1010; cin = 1'b0; #6; check_result(26);
        #12; a = 4'b1011; b = 4'b0111; cin = 1'b1; #2; check_result(27);
        #8; a = 4'b0110; b = 4'b1100; cin = 1'b0; #9; check_result(28);
        #15; a = 4'b1001; b = 4'b0011; cin = 1'b1; #3; check_result(29);
        #5; a = 4'b0010; b = 4'b1111; cin = 1'b0; #8; check_result(30);
        
        $display("");
        $display("--- Group 3 completed: Anti-pattern vectors ---");
        
        // Group 4: Edge cases mixed with random patterns
        #10; a = 4'b1111; b = 4'b1111; cin = 1'b1; #4; check_result(31); // Max overflow
        #7; a = 4'b0000; b = 4'b0000; cin = 1'b0; #6; check_result(32); // Zero case
        #14; a = 4'b1010; b = 4'b0101; cin = 1'b1; #3; check_result(33); // Complement
        #8; a = 4'b0101; b = 4'b1010; cin = 1'b0; #5; check_result(34); // Inverse complement
        #11; a = 4'b1100; b = 4'b0011; cin = 1'b1; #7; check_result(35); // Split pattern
        #6; a = 4'b0011; b = 4'b1100; cin = 1'b0; #4; check_result(36); // Inverse split
        #13; a = 4'b1111; b = 4'b0000; cin = 1'b1; #8; check_result(37); // Max + min
        #9; a = 4'b0000; b = 4'b1111; cin = 1'b0; #2; check_result(38); // Min + max
        
        $display("");
        $display("--- Group 4 completed: Edge cases with randomization ---");
        
        // Group 5: Prime-number inspired pseudo-random sequences
        #17; a = 4'b0111; b = 4'b1011; cin = 1'b1; #3; check_result(39);
        #11; a = 4'b1101; b = 4'b0010; cin = 1'b0; #7; check_result(40);
        #5; a = 4'b0100; b = 4'b1001; cin = 1'b1; #9; check_result(41);
        #13; a = 4'b1110; b = 4'b0101; cin = 1'b0; #4; check_result(42);
        #7; a = 4'b0001; b = 4'b1100; cin = 1'b1; #6; check_result(43);
        #19; a = 4'b1010; b = 4'b0110; cin = 1'b0; #2; check_result(44);
        #8; a = 4'b0011; b = 4'b1000; cin = 1'b1; #8; check_result(45);
        #14; a = 4'b1001; b = 4'b0111; cin = 1'b0; #5; check_result(46);
        #6; a = 4'b0110; b = 4'b1101; cin = 1'b1; #7; check_result(47);
        #12; a = 4'b1011; b = 4'b0000; cin = 1'b0; #3; check_result(48);
        
        $display("");
        $display("--- Group 5 completed: Prime-inspired sequences ---");
        
        // Group 6: Fibonacci-mod-16 inspired patterns (but randomized)
        #9; a = 4'b1000; b = 4'b1101; cin = 1'b1; #6; check_result(49);
        #15; a = 4'b0010; b = 4'b0111; cin = 1'b0; #4; check_result(50);
        #7; a = 4'b1111; b = 4'b1010; cin = 1'b1; #8; check_result(51);
        #11; a = 4'b0100; b = 4'b0001; cin = 1'b0; #3; check_result(52);
        #6; a = 4'b1001; b = 4'b1100; cin = 1'b1; #7; check_result(53);
        #13; a = 4'b0011; b = 4'b0110; cin = 1'b0; #5; check_result(54);
        #8; a = 4'b1110; b = 4'b1011; cin = 1'b1; #9; check_result(55);
        #16; a = 4'b0101; b = 4'b0000; cin = 1'b0; #2; check_result(56);
        #5; a = 4'b1100; b = 4'b1001; cin = 1'b1; #6; check_result(57);
        #12; a = 4'b0111; b = 4'b0010; cin = 1'b0; #4; check_result(58);
        
        $display("");
        $display("--- Group 6 completed: Modified Fibonacci patterns ---");
        
        // Group 7: Chaos-theory inspired test vectors
        #18; a = 4'b1010; b = 4'b1111; cin = 1'b0; #3; check_result(59);
        #7; a = 4'b0001; b = 4'b0100; cin = 1'b1; #8; check_result(60);
        #14; a = 4'b1101; b = 4'b1000; cin = 1'b0; #5; check_result(61);
        #9; a = 4'b0110; b = 4'b0011; cin = 1'b1; #7; check_result(62);
        #11; a = 4'b1011; b = 4'b1110; cin = 1'b0; #4; check_result(63);
        #6; a = 4'b0000; b = 4'b0101; cin = 1'b1; #9; check_result(64);
        #15; a = 4'b1100; b = 4'b0111; cin = 1'b0; #2; check_result(65);
        #8; a = 4'b0010; b = 4'b1001; cin = 1'b1; #6; check_result(66);
        #13; a = 4'b1111; b = 4'b0110; cin = 1'b0; #7; check_result(67);
        #5; a = 4'b0100; b = 4'b1010; cin = 1'b1; #4; check_result(68);
        
        $display("");
        $display("--- Group 7 completed: Chaos-inspired vectors ---");
        
        // Group 8: Final burst of truly random vectors
        #17; a = 4'b0111; b = 4'b1100; cin = 1'b0; #3; check_result(69);
        #6; a = 4'b1001; b = 4'b0010; cin = 1'b1; #8; check_result(70);
        #12; a = 4'b0101; b = 4'b1111; cin = 1'b0; #5; check_result(71);
        #9; a = 4'b1110; b = 4'b0001; cin = 1'b1; #7; check_result(72);
        #14; a = 4'b0011; b = 4'b1010; cin = 1'b0; #4; check_result(73);
        #7; a = 4'b1000; b = 4'b0110; cin = 1'b1; #6; check_result(74);
        #11; a = 4'b0100; b = 4'b1101; cin = 1'b0; #3; check_result(75);
        #16; a = 4'b1011; b = 4'b0000; cin = 1'b1; #8; check_result(76);
        #5; a = 4'b0110; b = 4'b1000; cin = 1'b0; #7; check_result(77);
        #13; a = 4'b1101; b = 4'b0111; cin = 1'b1; #2; check_result(78);
        
        $display("");
        $display("--- Group 8 completed: Final random burst ---");
        
        // Stress test with rapid-fire random vectors
        $display("");
        $display("--- Stress Test: Rapid random vectors ---");
        #3; a = 4'b1111; b = 4'b1011; cin = 1'b0; #1; check_result(79);
        #2; a = 4'b0010; b = 4'b0101; cin = 1'b1; #1; check_result(80);
        #3; a = 4'b1000; b = 4'b1100; cin = 1'b0; #1; check_result(81);
        #2; a = 4'b0111; b = 4'b0001; cin = 1'b1; #1; check_result(82);
        #3; a = 4'b1010; b = 4'b1110; cin = 1'b0; #1; check_result(83);
        #2; a = 4'b0100; b = 4'b0011; cin = 1'b1; #1; check_result(84);
        #3; a = 4'b1101; b = 4'b1001; cin = 1'b0; #1; check_result(85);
        #2; a = 4'b0001; b = 4'b0110; cin = 1'b1; #1; check_result(86);
        #3; a = 4'b1110; b = 4'b1000; cin = 1'b0; #1; check_result(87);
        #2; a = 4'b0011; b = 4'b0111; cin = 1'b1; #1; check_result(88);
        
        // Final comprehensive summary
        #25;
        $display("");
        $display("================================================================");
        $display("=== FINAL TEST SUMMARY ===");
        $display("================================================================");
        $display("Total test vectors executed: %0d", test_count);
        $display("Total errors detected: %0d", error_count);
        $display("Success rate: %0d%%", ((test_count - error_count) * 100) / test_count);
        
        if (error_count == 0) begin
            $display("SUCCESS: All tests passed! CLA implementation is verified correct.");
        end else begin
            $display("FAILURE: %0d out of %0d tests failed!", error_count, test_count);
            $display("Error rate: %0d%%", (error_count * 100) / test_count);
        end
        
        $display("Simulation completed at time: %0t ns", $time);
        $display("================================================================");
        
        $finish;
    end

endmodule

