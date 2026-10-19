module alu (
    input [15:0] a,
    input [15:0] b,
    input [3:0] alu_fun,
    input clk,
    output reg [15:0] alu_out,
    output reg arith_flag,
    output reg carry_flag,
    output reg logic_flag,
    output reg cmp_flag,
    output reg shift_flag
);

    always @ (posedge clk) begin
        
        arith_flag <= 0;
        carry_flag <= 0;
        logic_flag <= 0;
        cmp_flag <= 0;
        shift_flag <= 0;
        
        case (alu_fun) 
            4'b0000: begin
                arith_flag <= 1;
                {carry_flag,alu_out} <= a + b;
            end
            4'b0001: begin
                arith_flag <= 1;
                {carry_flag,alu_out} <= a-b;
            end
            4'b0010: begin
                arith_flag <= 1;
                alu_out <= a*b;
            end
            4'b0011: begin
                arith_flag <= 1;
                alu_out <= a/b;
            end
            4'b0100: begin
                logic_flag <= 1;
                alu_out <= a&b;
            end
            4'b0101: begin
                logic_flag <= 1;
                alu_out <= a|b;
            end
            4'b0110: begin
                logic_flag <= 1;
                alu_out <= ~(a&b);
            end
            4'b0111: begin
                logic_flag <= 1;
                alu_out <= ~(a|b);
            end
            4'b1000: begin
                logic_flag <= 1;
                alu_out <= a^b;
            end
            4'b1001: begin
                logic_flag <= 1;
                alu_out <= ~(a^b);
            end
            4'b1010: begin
                cmp_flag <= 1;
                if (a==b) begin
                    alu_out <= 1;
                end else begin
                    alu_out <= 0;
                end        
            end
            4'b1011: begin
                cmp_flag <= 1;
                if (a > b) begin
                    alu_out <= 2;
                end else begin
                    alu_out <= 0;
                end
            end
            4'b1100: begin
                cmp_flag <= 1;
                if (a < b) begin
                    alu_out <= 3;
                end else begin
                    alu_out <= 0;
                end
            end
            4'b1101: begin
                shift_flag <= 1;
                alu_out <= (a >> 1);
            end
            4'b1110: begin
                shift_flag <= 1;
                alu_out <= (a << 1);
            end
            default: begin
                alu_out <= 0;
            end
        endcase
    end

endmodule