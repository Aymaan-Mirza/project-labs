`timescale 1ns/1ps

module register_file_tb;

    
    reg         wrEn_tb;
    reg         rdEn_tb;
    reg         clk_tb;
    reg         rst_tb;
    reg  [15:0] wrData_tb;
    reg  [2:0]  address_tb;
    wire [15:0] rdData_tb;

    localparam CLK_PERIOD = 10;


    register_file dut (
        .wrEn    (wrEn_tb),
        .rdEn    (rdEn_tb),
        .clk     (clk_tb),
        .rst     (rst_tb),
        .wrData  (wrData_tb),
        .address (address_tb),
        .rdData  (rdData_tb)
    );


    initial clk_tb = 0;
    always #(CLK_PERIOD/2) clk_tb = ~clk_tb;

    task write_reg(input [2:0] addr, input [15:0] data);
        begin
            @(negedge clk_tb);
            wrEn_tb    = 1;
            rdEn_tb    = 0;
            address_tb = addr;
            wrData_tb  = data;
            @(negedge clk_tb);
            wrEn_tb    = 0;
        end
    endtask

    
    task read_reg(input [2:0] addr, input [15:0] expected);
        begin
            @(negedge clk_tb);
            wrEn_tb    = 0;
            rdEn_tb    = 1;
            address_tb = addr;
            @(negedge clk_tb);   
            rdEn_tb    = 0;
            if (rdData_tb == expected)
                $display("Read  addr %0d = %h IS PASSED", addr, rdData_tb);
            else
                $display("Read  addr %0d = %h IS FAILED (expected %h)", addr, rdData_tb, expected);
        end
    endtask

    initial begin
      
        wrEn_tb    = 0;
        rdEn_tb    = 0;
        wrData_tb  = 0;
        address_tb = 0;
        rst_tb     = 0;
        #(CLK_PERIOD * 2);
        rst_tb     = 1;

        $display("*** WRITE TESTS ***");
        write_reg(3'd3, 16'hABCD);
        write_reg(3'd5, 16'h1234);

  
        $display("*** READ TESTS ***");
        read_reg(3'd3, 16'hABCD);
        read_reg(3'd5, 16'h1234);

        
        $display("*** UNWRITTEN ADDRESS TEST ***");
        read_reg(3'd0, 16'h0000);

        #(CLK_PERIOD * 2);
        $stop;
    end

endmodule