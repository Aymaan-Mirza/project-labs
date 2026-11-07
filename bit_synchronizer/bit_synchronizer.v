module bit_synchronizer #(
    parameter NUM_STAGES = 2,
    parameter BUS_WIDTH  = 1
)(
    input  wire [BUS_WIDTH-1:0] async,
    input  wire clk,
    input  wire rst,    
    output wire [BUS_WIDTH-1:0] sync
);

  
    reg [BUS_WIDTH-1:0] sync_reg [NUM_STAGES-1:0];

    integer i;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            for (i = 0; i < NUM_STAGES; i = i + 1) begin
                sync_reg[i] <= {BUS_WIDTH{1'b0}};
            end
        end
        else begin
            sync_reg[0] <= async;
            for (i = 1; i < NUM_STAGES; i = i + 1) begin
                sync_reg[i] <= sync_reg[i-1];
            end
        end
    end

    assign sync = sync_reg[NUM_STAGES-1];

endmodule