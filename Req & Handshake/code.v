module source (
    input wire clk_a,
    input wire rst,
    input wire event_a,
    input wire ack_a,
    output reg req_a
);

always @(posedge clk_a) begin
    if(rst)
        req_a <= 0;
    else begin
        if(event_a && !req_a && !ack_a)
            req_a <= 1;
        else if(ack_a)
            req_a <= 0;
    end
end

endmodule
module destination (
    input wire clk_b,
    input wire rst,
    input wire req_b,
    output reg ack_b,
    output reg event_b
);

always @(posedge clk_b) begin
    if(rst) begin
        ack_b <= 0;
        event_b <= 0;
    end
    else begin
        event_b <= 0;

        if(req_b && !ack_b) begin
            event_b <= 1;
            ack_b <= 1;
        end
        else if(!req_b)
            ack_b <= 0;
    end
end

endmodule
