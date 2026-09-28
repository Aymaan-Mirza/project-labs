`timescale 1ns/1ps

module fb_counter_tb();
    reg [4:0] in_tb;
    reg load_tb;
    reg up_tb;
    reg down_tb;
    reg clk_tb;
    wire hi_tb;
    wire lo_tb;
    wire [4:0] counter_tb;

    fb_counter DUT (
        .in(in_tb),
        .load(load_tb),
        .up(up_tb),
        .down(down_tb),
        .clk(clk_tb),
        .hi(hi_tb),
        .lo(lo_tb),
        .counter(counter_tb)
    );

    always #5 clk_tb = ~clk_tb;

    initial begin
        $dumpfile ("count.vcd");
        $dumpvars;
        in_tb = 5'b00000;
        load_tb = 1'b0;
        up_tb = 1'b0;
        down_tb = 1'b0;
        clk_tb = 1'b0;

        $display ("TEST CASE 1");
        #10
        in_tb = 5'b00011;
        load_tb = 1'b1;
        #10
        if (counter_tb == 5'b00011)
            $display ("TEST CASE 1 PASSED WITH COUNTER VALUE = %0h AT SIMULATION TIME %0t", counter_tb, $time);
        else
            $display ("TEST CASE 1 FAILED WITH COUNTER VALUE = %0h AT SIMULATION TIME %0t", counter_tb, $time);

        $display ("TEST CASE 2");
        #10
        load_tb = 1'b1;
        up_tb = 1'b1;
        #10
        if (counter_tb == in_tb)
            $display ("TEST CASE 2 PASSED WITH COUNTER VALUE = %0h AT SIMULATION TIME %0t", counter_tb, $time);
        else
            $display ("TEST CASE 2 FAILED WITH COUNTER VALUE = %0h AT SIMULATION TIME %0t", counter_tb, $time);

        $display ("TEST CASE 3");
        #10
        load_tb = 1'b0;
        up_tb = 1'b1;
        #10
        if (counter_tb == 5'b00100)
            $display ("TEST CASE 3 PASSED WITH COUNTER VALUE = %0h AT SIMULATION TIME %0t", counter_tb, $time);
        else
            $display ("TEST CASE 3 FAILED WITH COUNTER VALUE = %0h AT SIMULATION TIME %0t", counter_tb, $time);
        
        $display ("TEST CASE 4");
        up_tb = 1'b1;
        #270
        #10
        if (counter_tb == 5'b11111 && hi_tb)
            $display ("TEST CASE 4 PASSED WITH COUNTER VALUE = %0h AT SIMULATION TIME %0t", counter_tb, $time);
        else
            $display ("TEST CASE 4 FAILED WITH COUNTER VALUE = %0h AT SIMULATION TIME %0t", counter_tb, $time);

        $display ("TEST CASE 5");
        up_tb = 1'b0;
        down_tb = 1'b1;
        #10
        if (counter_tb == 5'b11110)
            $display ("TEST CASE 5 PASSED WITH COUNTER VALUE = %0h AT SIMULATION TIME %0t", counter_tb, $time);
        else
            $display ("TEST CASE 5 FAILED WITH COUNTER VALUE = %0h AT SIMULATION TIME %0t", counter_tb, $time);
        
        $display ("TEST CASE 6");
        up_tb = 1'b1;
        down_tb = 1'b1;
        #10
        if (counter_tb == 5'b11101)
            $display ("TEST CASE 6 PASSED WITH COUNTER VALUE = %0h AT SIMULATION TIME %0t", counter_tb, $time);
        else
            $display ("TEST CASE 6 FAILED WITH COUNTER VALUE = %0h AT SIMULATION TIME %0t", counter_tb, $time);
        
        $display ("TEST CASE 7");
        up_tb = 1'b0;
        down_tb = 1'b1;
        #290
        #10
        if (counter_tb == 5'b00000 && lo_tb)
            $display ("TEST CASE 7 PASSED WITH COUNTER VALUE = %0h AT SIMULATION TIME %0t", counter_tb, $time);
        else
            $display ("TEST CASE 7 FAILED WITH COUNTER VALUE = %0h AT SIMULATION TIME %0t", counter_tb, $time);
        #100
    $stop
    end
    
endmodule