module arith_unit #(
    parameter IN_DATA_WIDTH = 16
) (
    input signed [IN_DATA_WIDTH-1:0] a,
    input signed [IN_DATA_WIDTH-1:0] b,
    input [1:0] alu_fun,
    input clk,
    input rst,
    input arith_enable,
    output reg [2*IN_DATA_WIDTH-1:0] arith_out,
    output reg arith_flag
);

    reg signed [2*IN_DATA_WIDTH-1:0] arith_out_comb;
    reg arith_flag_comb;

    always @ (*) begin
        if (arith_enable) begin
            arith_flag_comb = 1'b1;
            case (alu_fun)
                2'b00:   arith_out_comb = a + b;
                2'b01:   arith_out_comb = a - b;
                2'b10:   arith_out_comb = a * b;
                2'b11:   arith_out_comb = (b == 0) ? 0 : a / b;
                default: arith_out_comb = 0;
            endcase
        end else begin
            arith_flag_comb = 1'b0;
            arith_out_comb  = 0;
        end
    end

    
    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            arith_out  <= 0;
            arith_flag <= 1'b0;
        end else begin
            arith_out  <= arith_out_comb;
            arith_flag <= arith_flag_comb;
        end
    end

endmodule