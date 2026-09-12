module handshake (
    input wire clk_a,
    input wire clk_b,
    input wire rst,
    input wire event_a,
    output reg event_b
);

reg req_a;
reg ack_b;

reg req_sync1;
reg req_sync2;

reg ack_sync1;
reg ack_sync2;

always @(posedge clk_a) begin
    if(rst) begin
        req_a <= 0;
        ack_sync1 <= 0;
        ack_sync2 <= 0;
    end
    else begin
        ack_sync1 <= ack_b;
        ack_sync2 <= ack_sync1;

        if(event_a && !req_a && !ack_sync2)
            req_a <= 1;
        else if(ack_sync2)
            req_a <= 0;
    end
end

always @(posedge clk_b) begin
    if(rst) begin
        req_sync1 <= 0;
        req_sync2 <= 0;
        ack_b <= 0;
        event_b <= 0;
    end
    else begin
        req_sync1 <= req_a;
        req_sync2 <= req_sync1;

        event_b <= 0;

        if(req_sync2 && !ack_b) begin
            event_b <= 1;
            ack_b <= 1;
        end
        else if(!req_sync2)
            ack_b <= 0;
    end
end

endmodule
