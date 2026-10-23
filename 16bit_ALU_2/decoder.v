module decoder (
    input [3:2] alu_fun,
    output reg arith_enable,
    output reg logic_enable,
    output reg cmp_enable,
    output reg shift_enable
);

    always @ (*) begin
        case (alu_fun)
            2'b00: {arith_enable, logic_enable, cmp_enable, shift_enable} = 4'b1000;
            2'b01: {arith_enable, logic_enable, cmp_enable, shift_enable} = 4'b0100;
            2'b10: {arith_enable, logic_enable, cmp_enable, shift_enable} = 4'b0010;
            2'b11: {arith_enable, logic_enable, cmp_enable, shift_enable} = 4'b0001;
            default: {arith_enable, logic_enable, cmp_enable, shift_enable} = 4'b0000;
        endcase
    end

endmodule