module tb;

reg clk_a;
reg clk_b;
reg rst;

wire enable_a;
wire enable_b;

source s1(
    .enable_a(enable_a),
    .clk_a(clk_a),
    .rst(rst)
);

level_sync s2(
    .enable_b(enable_b),
    .enable_a(enable_a),
    .clk_b(clk_b),
    .rst(rst)
);

initial clk_a = 0;
always #5 clk_a = ~clk_a;

initial clk_b = 0;
always #7 clk_b = ~clk_b;

initial begin
    $dumpfile("level.vcd");
    $dumpvars(0,tb);

    rst = 1;

    #12 rst = 0;

    #100 $finish;
end

endmodule
