module linear_feedback_shift_register (
    input clk,
    input rst_n,
    input active,
    input data,
    output reg crc,
    output reg valid
);

    localparam IDLE = 2'b00;
    localparam DATA = 2'b01;
    localparam CRC = 2'b10;

    reg [7:0] registers;
    reg [1:0] state;
    reg [2:0] count;
    wire feedback = data ^ registers[0];

    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            registers <= 8'hD8;
            crc <= 0;
            valid <= 0;
            count <= 0;
            state <= IDLE;
        end else begin
            if (active) begin
                registers[7] <= feedback;
                registers[6] <= feedback ^ registers[7];
                registers[5] <= registers[6];
                registers[4] <= registers[5];
                registers[3] <= registers[4];
                registers[2] <= feedback ^ registers[3];
                registers[1] <= registers[2];
                registers[0] <= registers[1];
            end

            case (state)
                IDLE: begin
                    valid <= 0;
                    if (active)
                        state <= DATA;
                end

                DATA: begin
                    if (!active) begin
                        state <= CRC;
                        count <= 0;
                    end
                end

                CRC: begin
                    crc <= registers[7 - count];
                    valid <= 1;
                    count <= count + 1;
                    if (count == 7) begin
                        state <= IDLE;
                        registers <= 8'hD8;
                    end
                end
                default: state <= IDLE;
            endcase
        end
    end

endmodule