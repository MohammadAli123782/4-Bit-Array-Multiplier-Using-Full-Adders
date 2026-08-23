`timescale 1ns/1ps

module multiplier_4x4_tb;

    reg  [3:0] M;
    reg  [3:0] Q;
    wire [7:0] P;

    integer errors;

    multiplier_4x4 dut (
        .M (M),
        .Q (Q),
        .P (P)
    );

    task check_result;
        input [3:0] test_m;
        input [3:0] test_q;
        input [7:0] expected;
        begin
            M = test_m;
            Q = test_q;

            #10;

            if (P !== expected) begin
                $display(
                    "FAIL: M=%b (%0d), Q=%b (%0d), P=%b (%0d), expected=%b (%0d)",
                    M, M, Q, Q, P, P, expected, expected
                );

                errors = errors + 1;
            end
            else begin
                $display(
                    "PASS: M=%b (%0d), Q=%b (%0d), P=%b (%0d)",
                    M, M, Q, Q, P, P
                );
            end
        end
    endtask

    initial begin
        errors = 0;
        M = 4'b0000;
        Q = 4'b0000;

        $display("Testing structural 4-bit multiplier");
        $display("-----------------------------------");

        check_result(4'b1110, 4'b1011, 8'b10011010);
        check_result(4'b1111, 4'b1111, 8'b11100001);
        check_result(4'b0011, 4'b0101, 8'b00001111);
        check_result(4'b0000, 4'b1111, 8'b00000000);
        check_result(4'b0001, 4'b1010, 8'b00001010);
        check_result(4'b1000, 4'b1000, 8'b01000000);
        check_result(4'b0111, 4'b1001, 8'b00111111);

        if (errors == 0)
            $display("SUCCESS: All tests passed.");
        else
            $display("FAILED: %0d test(s) failed.", errors);

        $finish;
    end

    initial begin
        $dumpfile("multiplier_4x4.vcd");
        $dumpvars(0, multiplier_4x4_tb);
    end

endmodule
