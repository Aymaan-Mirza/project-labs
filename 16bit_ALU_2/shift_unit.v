module shift_unit #(
    parameter IN_DATA_WIDTH = 16
)(
    input [IN_DATA_WIDTH-1:0] a,
    input [IN_DATA_WIDTH-1:0] b,
    input [1:0] alu_fun,
    input clk,
    input rst,
    input shift_enable,
    output reg [IN_DATA_WIDTH-1:0] shift_out,
    output reg shift_flag
);

    reg [IN_DATA_WIDTH-1:0] shift_out_comb;
    reg shift_flag_comb;

    always @ (*) begin
        if (shift_enable) begin
            shift_flag_comb = 1'b1;
            case (alu_fun)
                2'b00: shift_out_comb = a >> 1;
                2'b01: shift_out_comb = a << 1;
                2'b10: shift_out_comb = b >> 1;
                2'b11: shift_out_comb = b << 1;
                default: shift_out_comb = 0;
            endcase
        end else begin
            shift_out_comb = 0;
            shift_flag_comb = 0;
        end
    end

    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            shift_flag <= 0;
            shift_out <= 0;
        end else begin
            shift_flag <= shift_flag_comb;
            shift_out <= shift_out_comb;
        end
    end
endmodule