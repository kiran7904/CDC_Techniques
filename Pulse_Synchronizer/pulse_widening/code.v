module pulse_stretcher (
    input wire clk,
    input wire rst,
    input wire pulse_in,
    output reg pulse_out
);

reg [2:0] count;

always @(posedge clk) begin
    if(rst) begin
        count <= 0;
        pulse_out <= 0;
    end
    else begin
        if(pulse_in) begin
            count <= 3'd4;
            pulse_out <= 1;
        end
        else if(count != 0) begin
            count <= count - 1'b1;
            pulse_out <= 1;
        end
        else begin
            pulse_out <= 0;
        end
    end
end

endmodule
