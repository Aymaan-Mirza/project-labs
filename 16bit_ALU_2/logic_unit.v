module logic_unit #(
    parameter IN_DATA_WIDTH = 16
)(
    input [IN_DATA_WIDTH-1:0] a,
    input [IN_DATA_WIDTH-1:0] b,
    input [1:0] alu_fun,
    input clk,
    input rst,
    input logic_enable,
    output reg [IN_DATA_WIDTH-1:0] logic_out,
    output reg logic_flag
);

    reg [IN_DATA_WIDTH-1:0] logic_out_comb;
    reg logic_flag_comb;

    always @ (*) begin
        if (logic_enable) begin
            logic_flag_comb = 1'b1;
            case (alu_fun)
                2'b00: logic_out_comb = (a&b);
                2'b01: logic_out_comb = (a|b);
                2'b10: logic_out_comb = ~(a&b);
                2'b11: logic_out_comb = ~(a|b);
                default: logic_out_comb = 0;
            endcase
        end else begin
            logic_flag_comb = 0;
            logic_out_comb = 0;
        end
    end

    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            logic_out <= 0;
            logic_flag <= 0;
        end else begin
            logic_out <= logic_out_comb;
            logic_flag <= logic_flag_comb;
        end
    end


endmodule