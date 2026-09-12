module source(output reg a=0,input clk_a,rst);
  always@(posedge clk_a)begin
    if(rst)
      a<=1'b0;
    else
      a<=~a;
  end
endmodule
module synchronizer(output reg b=0,input a,input clk_b,rst);
  reg [1:0]sync;
  always@(posedge clk_b)begin
    if(rst)begin
      b<=0;
      sync<={2{0}};
    end
    else begin
      sync[0]<=a;
      sync[1]<=sync[0];
      b<=sync[1];
    end
  end
endmodule
    
module tb;
  wire a;
  reg clk_a;
  reg rst;
  wire b;
  reg clk_b;
  source s1(a,clk_a,rst);
  synchronizer s2(b,a,clk_b,rst);
  initial clk_a=0;
  initial clk_b=0;
  always #5 clk_a=~clk_a;
  always #5 clk_b =~clk_b;
  initial begin
    $dumpfile("1.vcd");
    $dumpvars(0,tb);
    rst=0;
    #8 rst=1;
    #100 $finish;
  end
endmodule
