`timescale 1ns/1ps

module alu_tb();
    reg [15:0] a_tb;
    reg [15:0] b_tb;
    reg [3:0] alu_fun_tb;
    reg clk_tb;
    wire [15:0] alu_out_tb;
    wire arith_flag_tb;
    wire carry_flag_tb;
    wire logic_flag_tb;
    wire cmp_flag_tb;
    wire shift_flag_tb;

    alu DUT (
        .a(a_tb),
        .b(b_tb),
        .alu_fun(alu_fun_tb),
        .clk(clk_tb),
        .alu_out(alu_out_tb),
        .arith_flag(arith_flag_tb),
        .carry_flag(carry_flag_tb),
        .logic_flag(logic_flag_tb),
        .cmp_flag(cmp_flag_tb),
        .shift_flag(shift_flag_tb)
    );

    // 100 kHz clock: 10 us period, so toggle every 5000 ns
    always #5000 clk_tb = ~clk_tb;

    initial begin
        $dumpfile ("alu.vcd");
        $dumpvars;
        clk_tb = 1'b0;
        a_tb = 16'h0000;
        b_tb = 16'h0000;
        alu_fun_tb = 4'b0000;

        // Each test sets the inputs, waits one full clock period (10000 ns) so the
        // ALU registers the result on the rising edge, then checks the output and flags.

        $display ("TEST CASE 1: ADD");
        a_tb = 16'h1234;
        b_tb = 16'h0101;
        alu_fun_tb = 4'b0000;
        #10000
        if (alu_out_tb == 16'h1335 &&
            arith_flag_tb == 1'b1 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b0 &&
            cmp_flag_tb == 1'b0 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 1 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 1 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 2: ADD WITH CARRY");
        a_tb = 16'hFFFF;
        b_tb = 16'h0002;
        alu_fun_tb = 4'b0000;
        #10000
        if (alu_out_tb == 16'h0001 &&
            arith_flag_tb == 1'b1 &&
            carry_flag_tb == 1'b1 &&
            logic_flag_tb == 1'b0 &&
            cmp_flag_tb == 1'b0 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 2 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 2 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 3: SUB");
        a_tb = 16'h0050;
        b_tb = 16'h0030;
        alu_fun_tb = 4'b0001;
        #10000
        if (alu_out_tb == 16'h0020 &&
            arith_flag_tb == 1'b1 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b0 &&
            cmp_flag_tb == 1'b0 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 3 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 3 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 4: SUB WITH BORROW");
        a_tb = 16'h0010;
        b_tb = 16'h0020;
        alu_fun_tb = 4'b0001;
        #10000
        if (alu_out_tb == 16'hFFF0 &&
            arith_flag_tb == 1'b1 &&
            carry_flag_tb == 1'b1 &&
            logic_flag_tb == 1'b0 &&
            cmp_flag_tb == 1'b0 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 4 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 4 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 5: MUL");
        a_tb = 16'h0012;
        b_tb = 16'h0004;
        alu_fun_tb = 4'b0010;
        #10000
        if (alu_out_tb == 16'h0048 &&
            arith_flag_tb == 1'b1 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b0 &&
            cmp_flag_tb == 1'b0 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 5 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 5 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 6: DIV");
        a_tb = 16'h0064;
        b_tb = 16'h0005;
        alu_fun_tb = 4'b0011;
        #10000
        if (alu_out_tb == 16'h0014 &&
            arith_flag_tb == 1'b1 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b0 &&
            cmp_flag_tb == 1'b0 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 6 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 6 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 7: AND");
        a_tb = 16'hF0F0;
        b_tb = 16'h0FF0;
        alu_fun_tb = 4'b0100;
        #10000
        if (alu_out_tb == 16'h00F0 &&
            arith_flag_tb == 1'b0 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b1 &&
            cmp_flag_tb == 1'b0 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 7 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 7 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 8: OR");
        a_tb = 16'hF0F0;
        b_tb = 16'h0FF0;
        alu_fun_tb = 4'b0101;
        #10000
        if (alu_out_tb == 16'hFFF0 &&
            arith_flag_tb == 1'b0 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b1 &&
            cmp_flag_tb == 1'b0 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 8 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 8 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 9: NAND");
        a_tb = 16'hF0F0;
        b_tb = 16'h0FF0;
        alu_fun_tb = 4'b0110;
        #10000
        if (alu_out_tb == 16'hFF0F &&
            arith_flag_tb == 1'b0 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b1 &&
            cmp_flag_tb == 1'b0 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 9 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 9 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 10: NOR");
        a_tb = 16'hF0F0;
        b_tb = 16'h0FF0;
        alu_fun_tb = 4'b0111;
        #10000
        if (alu_out_tb == 16'h000F &&
            arith_flag_tb == 1'b0 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b1 &&
            cmp_flag_tb == 1'b0 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 10 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 10 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 11: XOR");
        a_tb = 16'hF0F0;
        b_tb = 16'h0FF0;
        alu_fun_tb = 4'b1000;
        #10000
        if (alu_out_tb == 16'hFF00 &&
            arith_flag_tb == 1'b0 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b1 &&
            cmp_flag_tb == 1'b0 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 11 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 11 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 12: XNOR");
        a_tb = 16'hF0F0;
        b_tb = 16'h0FF0;
        alu_fun_tb = 4'b1001;
        #10000
        if (alu_out_tb == 16'h00FF &&
            arith_flag_tb == 1'b0 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b1 &&
            cmp_flag_tb == 1'b0 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 12 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 12 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 13: EQUAL (TRUE)");
        a_tb = 16'h1234;
        b_tb = 16'h1234;
        alu_fun_tb = 4'b1010;
        #10000
        if (alu_out_tb == 16'h0001 &&
            arith_flag_tb == 1'b0 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b0 &&
            cmp_flag_tb == 1'b1 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 13 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 13 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 14: EQUAL (FALSE)");
        a_tb = 16'h1234;
        b_tb = 16'h4321;
        alu_fun_tb = 4'b1010;
        #10000
        if (alu_out_tb == 16'h0000 &&
            arith_flag_tb == 1'b0 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b0 &&
            cmp_flag_tb == 1'b1 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 14 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 14 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 15: GREATER (TRUE)");
        a_tb = 16'h0050;
        b_tb = 16'h0030;
        alu_fun_tb = 4'b1011;
        #10000
        if (alu_out_tb == 16'h0002 &&
            arith_flag_tb == 1'b0 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b0 &&
            cmp_flag_tb == 1'b1 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 15 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 15 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 16: GREATER (FALSE)");
        a_tb = 16'h0030;
        b_tb = 16'h0050;
        alu_fun_tb = 4'b1011;
        #10000
        if (alu_out_tb == 16'h0000 &&
            arith_flag_tb == 1'b0 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b0 &&
            cmp_flag_tb == 1'b1 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 16 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 16 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 17: LESS (TRUE)");
        a_tb = 16'h0030;
        b_tb = 16'h0050;
        alu_fun_tb = 4'b1100;
        #10000
        if (alu_out_tb == 16'h0003 &&
            arith_flag_tb == 1'b0 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b0 &&
            cmp_flag_tb == 1'b1 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 17 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 17 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 18: LESS (FALSE)");
        a_tb = 16'h0050;
        b_tb = 16'h0030;
        alu_fun_tb = 4'b1100;
        #10000
        if (alu_out_tb == 16'h0000 &&
            arith_flag_tb == 1'b0 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b0 &&
            cmp_flag_tb == 1'b1 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 18 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 18 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 19: A SHIFT RIGHT");
        a_tb = 16'h00F0;
        b_tb = 16'h0ABC;
        alu_fun_tb = 4'b1101;
        #10000
        if (alu_out_tb == 16'h0078 &&
            arith_flag_tb == 1'b0 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b0 &&
            cmp_flag_tb == 1'b0 &&
            shift_flag_tb == 1'b1)
            $display ("TEST CASE 19 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 19 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 20: A SHIFT LEFT");
        a_tb = 16'h00F0;
        b_tb = 16'h0ABC;
        alu_fun_tb = 4'b1110;
        #10000
        if (alu_out_tb == 16'h01E0 &&
            arith_flag_tb == 1'b0 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b0 &&
            cmp_flag_tb == 1'b0 &&
            shift_flag_tb == 1'b1)
            $display ("TEST CASE 20 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 20 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        // ALU only shifts A, so put B's value on the A port to test a B shift
        $display ("TEST CASE 21: B SHIFT RIGHT");
        a_tb = 16'h0ABC;
        b_tb = 16'h0000;
        alu_fun_tb = 4'b1101;
        #10000
        if (alu_out_tb == 16'h055E &&
            arith_flag_tb == 1'b0 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b0 &&
            cmp_flag_tb == 1'b0 &&
            shift_flag_tb == 1'b1)
            $display ("TEST CASE 21 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 21 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        // ALU only shifts A, so put B's value on the A port to test a B shift
        $display ("TEST CASE 22: B SHIFT LEFT");
        a_tb = 16'h0ABC;
        b_tb = 16'h0000;
        alu_fun_tb = 4'b1110;
        #10000
        if (alu_out_tb == 16'h1578 &&
            arith_flag_tb == 1'b0 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b0 &&
            cmp_flag_tb == 1'b0 &&
            shift_flag_tb == 1'b1)
            $display ("TEST CASE 22 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 22 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);

        $display ("TEST CASE 23: NOP");
        a_tb = 16'h1234;
        b_tb = 16'h5678;
        alu_fun_tb = 4'b1111;
        #10000
        if (alu_out_tb == 16'h0000 &&
            arith_flag_tb == 1'b0 &&
            carry_flag_tb == 1'b0 &&
            logic_flag_tb == 1'b0 &&
            cmp_flag_tb == 1'b0 &&
            shift_flag_tb == 1'b0)
            $display ("TEST CASE 23 PASSED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        else
            $display ("TEST CASE 23 FAILED WITH ALU_OUT = %0h AT SIMULATION TIME %0t", alu_out_tb, $time);
        #10000
        $stop;
    end

endmodule