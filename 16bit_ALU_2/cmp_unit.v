module cmp_unit #(
    parameter IN_DATA_WIDTH = 16
)(
    input [IN_DATA_WIDTH-1:0] a,
    input [IN_DATA_WIDTH-1:0] b,
    input [1:0] alu_fun,
    input clk,
    input rst,
    input cmp_enable,
    output reg [IN_DATA_WIDTH-1:0] cmp_out,
    output reg cmp_flag
);

    reg [IN_DATA_WIDTH-1:0] cmp_out_comb;
    reg cmp_flag_comb;

    always @ (*) begin
        if (cmp_enable) begin
            cmp_flag_comb = 1;
            case (alu_fun)
                2'b00: cmp_out_comb = 0;
                2'b01: if (a == b) begin
                    cmp_out_comb = 1;
                end else begin
                    cmp_out_comb = 0;
                end
                2'b10: if (a > b) begin
                    cmp_out_comb = 2;
                end else begin
                    cmp_out_comb = 0;
                end
                2'b11: if (a < b) begin
                    cmp_out_comb = 3;
                end else begin
                    cmp_out_comb = 0;
                end
                default: cmp_out_comb = 0;
            endcase
        end else begin
            cmp_flag_comb = 0;
            cmp_out_comb = 0;
        end
    end

    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            cmp_flag <= 0;
            cmp_out <= 0;
        end else begin
            cmp_flag <= cmp_flag_comb;
            cmp_out <= cmp_out_comb;
        end
    end

endmodule