`timescale 1ns / 1ps


/*module sim2_clafourbit(

    );
endmodule*/
module sim2_clafourbit();

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

    // Task to check results
    task check_result;
        begin
            expected_result = a + b + cin;
            if ({cout, sum} !== expected_result) begin
                $display("ERROR at time %0t: a=%b, b=%b, cin=%b", $time, a, b, cin);
                $display("  Expected: cout=%b, sum=%b (decimal: %d)", 
                         expected_result[4], expected_result[3:0], expected_result);
                $display("  Got:      cout=%b, sum=%b (decimal: %d)", 
                         cout, sum, {cout, sum});
                error_count = error_count + 1;
            end else begin
                $display("PASS: a=%b, b=%b, cin=%b -> cout=%b, sum=%b (decimal: %d)", 
                         a, b, cin, cout, sum, {cout, sum});
            end
            test_count = test_count + 1;
        end
    endtask

    initial begin
        // Initialize
        test_count = 0;
        error_count = 0;
        
        $display("=== Starting Random Testbench for 4-bit Carry Lookahead Adder ===");
        $display("Time: %0t", $time);
        
        // Test Case 1: Completely random patterns
        #10; a = 4'b1011; b = 4'b0110; cin = 1'b1; #5; check_result;
        #10; a = 4'b0010; b = 4'b1101; cin = 1'b0; #5; check_result;
        #10; a = 4'b1111; b = 4'b0001; cin = 1'b1; #5; check_result;
        #10; a = 4'b0101; b = 4'b1010; cin = 1'b0; #5; check_result;
        #10; a = 4'b1000; b = 4'b0111; cin = 1'b1; #5; check_result;
        #10; a = 4'b0011; b = 4'b1100; cin = 1'b0; #5; check_result;
        #10; a = 4'b1110; b = 4'b0010; cin = 1'b1; #5; check_result;
        #10; a = 4'b0001; b = 4'b1001; cin = 1'b0; #5; check_result;
        #10; a = 4'b1101; b = 4'b0100; cin = 1'b1; #5; check_result;
        #10; a = 4'b0110; b = 4'b1011; cin = 1'b0; #5; check_result;
        
        // Test Case 2: More random patterns with mixed carries
        #10; a = 4'b1010; b = 4'b0101; cin = 1'b1; #5; check_result;
        #10; a = 4'b0111; b = 4'b1000; cin = 1'b0; #5; check_result;
        #10; a = 4'b1001; b = 4'b0110; cin = 1'b1; #5; check_result;
        #10; a = 4'b0100; b = 4'b1011; cin = 1'b0; #5; check_result;
        #10; a = 4'b1100; b = 4'b0011; cin = 1'b1; #5; check_result;
        #10; a = 4'b0000; b = 4'b1111; cin = 1'b0; #5; check_result;
        #10; a = 4'b1111; b = 4'b0000; cin = 1'b1; #5; check_result;
        #10; a = 4'b0101; b = 4'b1001; cin = 1'b0; #5; check_result;
        #10; a = 4'b1011; b = 4'b0100; cin = 1'b1; #5; check_result;
        #10; a = 4'b0010; b = 4'b1110; cin = 1'b0; #5; check_result;
        
        // Test Case 3: Pseudo-random patterns (avoiding simple sequences)
        #10; a = 4'b1101; b = 4'b0010; cin = 1'b1; #5; check_result;
        #10; a = 4'b0110; b = 4'b1001; cin = 1'b0; #5; check_result;
        #10; a = 4'b1000; b = 4'b0101; cin = 1'b1; #5; check_result;
        #10; a = 4'b0011; b = 4'b1110; cin = 1'b0; #5; check_result;
        #10; a = 4'b1111; b = 4'b0111; cin = 1'b1; #5; check_result;
        #10; a = 4'b0001; b = 4'b1100; cin = 1'b0; #5; check_result;
        #10; a = 4'b1010; b = 4'b0110; cin = 1'b1; #5; check_result;
        #10; a = 4'b0100; b = 4'b1001; cin = 1'b0; #5; check_result;
        #10; a = 4'b1110; b = 4'b0001; cin = 1'b1; #5; check_result;
        #10; a = 4'b0111; b = 4'b1011; cin = 1'b0; #5; check_result;
        
        // Test Case 4: Edge cases with random elements
        #10; a = 4'b1111; b = 4'b1111; cin = 1'b1; #5; check_result; // Maximum values
        #10; a = 4'b0000; b = 4'b0000; cin = 1'b0; #5; check_result; // Minimum values
        #10; a = 4'b1111; b = 4'b0000; cin = 1'b1; #5; check_result; // Max + Min + carry
        #10; a = 4'b0000; b = 4'b1111; cin = 1'b0; #5; check_result; // Min + Max
        #10; a = 4'b1010; b = 4'b0101; cin = 1'b0; #5; check_result; // Alternating bits
        #10; a = 4'b0101; b = 4'b1010; cin = 1'b1; #5; check_result; // Inverted alternating
        
        // Test Case 5: More scattered random patterns
        #10; a = 4'b1001; b = 4'b0110; cin = 1'b0; #5; check_result;
        #10; a = 4'b0011; b = 4'b1101; cin = 1'b1; #5; check_result;
        #10; a = 4'b1100; b = 4'b0010; cin = 1'b0; #5; check_result;
        #10; a = 4'b0110; b = 4'b1000; cin = 1'b1; #5; check_result;
        #10; a = 4'b1011; b = 4'b0111; cin = 1'b0; #5; check_result;
        #10; a = 4'b0001; b = 4'b1110; cin = 1'b1; #5; check_result;
        #10; a = 4'b1110; b = 4'b0100; cin = 1'b0; #5; check_result;
        #10; a = 4'b0101; b = 4'b1011; cin = 1'b1; #5; check_result;
        #10; a = 4'b1000; b = 4'b0010; cin = 1'b0; #5; check_result;
        #10; a = 4'b0111; b = 4'b1001; cin = 1'b1; #5; check_result;
        
        // Test Case 6: Additional random vectors
        #10; a = 4'b1100; b = 4'b1001; cin = 1'b0; #5; check_result;
        #10; a = 4'b0010; b = 4'b0110; cin = 1'b1; #5; check_result;
        #10; a = 4'b1111; b = 4'b1010; cin = 1'b0; #5; check_result;
        #10; a = 4'b0100; b = 4'b0001; cin = 1'b1; #5; check_result;
        #10; a = 4'b1001; b = 4'b1100; cin = 1'b0; #5; check_result;
        #10; a = 4'b0110; b = 4'b0011; cin = 1'b1; #5; check_result;
        #10; a = 4'b1010; b = 4'b1110; cin = 1'b0; #5; check_result;
        #10; a = 4'b0001; b = 4'b0101; cin = 1'b1; #5; check_result;
        #10; a = 4'b1101; b = 4'b1000; cin = 1'b0; #5; check_result;
        #10; a = 4'b0111; b = 4'b0010; cin = 1'b1; #5; check_result;
        
        // Test Case 7: Final random burst
        #10; a = 4'b1011; b = 4'b1101; cin = 1'b1; #5; check_result;
        #10; a = 4'b0100; b = 4'b0110; cin = 1'b0; #5; check_result;
        #10; a = 4'b1110; b = 4'b1011; cin = 1'b1; #5; check_result;
        #10; a = 4'b0000; b = 4'b1001; cin = 1'b0; #5; check_result;
        #10; a = 4'b1111; b = 4'b0100; cin = 1'b1; #5; check_result;
        #10; a = 4'b0010; b = 4'b1010; cin = 1'b0; #5; check_result;
        #10; a = 4'b1001; b = 4'b0111; cin = 1'b1; #5; check_result;
        #10; a = 4'b0101; b = 4'b1100; cin = 1'b0; #5; check_result;
        #10; a = 4'b1000; b = 4'b0011; cin = 1'b1; #5; check_result;
        #10; a = 4'b0110; b = 4'b1111; cin = 1'b0; #5; check_result;
        
        // Final summary
        #20;
        $display("\n=== Test Summary ===");
        $display("Total tests run: %0d", test_count);
        $display("Errors found: %0d", error_count);
        if (error_count == 0) begin
            $display("SUCCESS: All tests passed!");
        end else begin
            $display("FAILURE: %0d tests failed!", error_count);
        end
        $display("Test completed at time: %0t", $time);
        
        $finish;
    end

    // Optional: Generate waveform dump
    /*initial begin
        $dumpfile("carry_lookahead_adder_4bit.vcd");
        $dumpvars(0, sim2_clafourbit);
    end*/

endmodule
