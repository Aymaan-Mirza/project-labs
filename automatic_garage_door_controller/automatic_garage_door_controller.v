module automatic_garage_door_controller (
    input clk,
    input rst_n,
    input up_max,
    input activate,
    input dn_max,
    output reg up_m,
    output reg down_m
);

    localparam IDLE = 2'b00;
    localparam MV_UP = 2'b01;
    localparam MV_DOWN = 2'b10;

    reg [1:0] current_state, next_state;

    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    always @ (*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (activate && dn_max) begin
                    next_state = MV_UP;
                end else if (activate && up_max) begin
                    next_state = MV_DOWN;
                end
            end
            MV_UP: begin
                if (up_max) begin
                    next_state = IDLE;
                end
            end
            MV_DOWN: begin
                if (dn_max) begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

    always @ (*) begin
        up_m = 0;
        down_m = 0;
        case (current_state)
            MV_UP: up_m = 1;
            MV_DOWN: down_m = 1;
        endcase
    end

endmodule