module ALU_TOP #(
    parameter IN_DATA_WIDTH = 16
)(
    input signed [IN_DATA_WIDTH-1:0] a,
    input signed [IN_DATA_WIDTH-1:0] b,
    input [3:0] alu_fun,
    input clk,
    input rst,
    output signed [2*IN_DATA_WIDTH-1:0] arith_out,
    output arith_flag,
    output [IN_DATA_WIDTH-1:0] logic_out,
    output logic_flag,
    output [IN_DATA_WIDTH-1:0] cmp_out,
    output cmp_flag,
    output [IN_DATA_WIDTH-1:0] shift_out,
    output shift_flag
);


    wire arith_enable;
    wire logic_enable;
    wire cmp_enable;
    wire shift_enable;

    decoder u_decoder (
        .alu_fun      (alu_fun[3:2]),
        .arith_enable (arith_enable),
        .logic_enable (logic_enable),
        .cmp_enable   (cmp_enable),
        .shift_enable (shift_enable)
    );

    arith_unit #(.IN_DATA_WIDTH(IN_DATA_WIDTH)) u_arith (
        .a            (a),
        .b            (b),
        .alu_fun      (alu_fun[1:0]),
        .clk          (clk),
        .rst          (rst),
        .arith_enable (arith_enable),
        .arith_out    (arith_out),
        .arith_flag   (arith_flag)
    );

    logic_unit #(.IN_DATA_WIDTH(IN_DATA_WIDTH)) u_logic (
        .a            (a),
        .b            (b),
        .alu_fun      (alu_fun[1:0]),
        .clk          (clk),
        .rst          (rst),
        .logic_enable (logic_enable),
        .logic_out    (logic_out),
        .logic_flag   (logic_flag)
    );

    cmp_unit #(.IN_DATA_WIDTH(IN_DATA_WIDTH)) u_cmp (
        .a            (a),
        .b            (b),
        .alu_fun      (alu_fun[1:0]),
        .clk          (clk),
        .rst          (rst),
        .cmp_enable   (cmp_enable),
        .cmp_out      (cmp_out),
        .cmp_flag     (cmp_flag)
    );

    shift_unit #(.IN_DATA_WIDTH(IN_DATA_WIDTH)) u_shift (
        .a            (a),
        .b            (b),
        .alu_fun      (alu_fun[1:0]),
        .clk          (clk),
        .rst          (rst),
        .shift_enable (shift_enable),
        .shift_out    (shift_out),
        .shift_flag   (shift_flag)
    );


endmodule