module source(output reg pulse_a,input clk_a,rst);
  reg [1:0]count;
  always@(posedge clk_a)
    begin
      if(rst)begin
        count<=0;
        pulse_a<=0;
      end
      else begin
        if(count==2'b11)begin
          pulse_a<=1;
          count<=0;
        end
        else begin
          count<=count+1;
          pulse_a<=0;
      end
      end
    end
endmodule
module pulse(output pulse_b,input pulse_a,input clk_a,clk_b,rst);
  reg [1:0]sync;
  reg toggle;
  always@(posedge clk_a)begin
    if(rst)
      toggle<=0;
    else if(pulse_a)
      toggle <=~toggle;
  end
  always@(posedge clk_b)begin
    if(rst)
      sync<=0;
    else begin
    sync[0]<=toggle;
    sync[1]<=sync[0];
    end
  end
  assign pulse_b=sync[1]^sync[0];
endmodule
module tb;

reg clk_a;
reg clk_b;
reg rst;

wire pulse_a;
wire pulse_b;

source s1(
    .pulse_a(pulse_a),
    .clk_a(clk_a),
    .rst(rst)
);

pulse p1(
    .pulse_b(pulse_b),
    .pulse_a(pulse_a),
    .clk_a(clk_a),
    .clk_b(clk_b),
    .rst(rst)
);

initial clk_a = 0;
always #5 clk_a = ~clk_a;

initial clk_b = 0;
always #7 clk_b = ~clk_b;

initial begin
    $dumpfile("pulse.vcd");
    $dumpvars(0,tb);

    rst = 1;

    #12 rst = 0;

    #150 $finish;
end

endmodule
