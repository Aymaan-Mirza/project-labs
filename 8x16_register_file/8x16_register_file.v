module register_file (
    input wrEn,
    input rdEn,
    input clk,
    input rst,
    input [15:0] wrData,
    input [2:0] address,
    output reg [15:0] rdData
);

    reg [15:0] reg_file [0:7];
    integer i;

    always @ (posedge clk or negedge rst) begin
        if (!rst) begin
            rdData <= 0;
            for (i=0; i < 8; i = i + 1) begin
                reg_file [i] <= 0;
            end
        end else if (wrEn) begin
            reg_file[address] <= wrData;
        end else if (rdEn) begin
            rdData <= reg_file[address];
        end
    end

endmodule