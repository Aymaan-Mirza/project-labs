module fb_counter (
    input [4:0] in,
    input load,
    input up,
    input down,
    input clk,
    output hi,
    output lo,
    output reg [4:0] counter 
);

always @ (posedge clk)
begin    
    if (load)
        counter <= in;
    else if (down)
    begin
        if (counter == 0)
            counter <= counter;
        else
            counter <= counter - 5'b00001;
        end
    else if (up)
    begin
        if (counter == 5'b11111)
            counter <= counter;
        else
            counter <= counter + 5'b00001;
        end
    else
        counter <= counter;
    end

assign lo = (counter == 5'b00000);
assign hi = (counter == 5'b11111);

endmodule