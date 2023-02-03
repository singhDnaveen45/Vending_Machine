module vending_mc_tb();

reg i,j;
reg clk,rst ;
wire dout,return;
parameter T = 10;

vending_mc DUT( i,j,clk,rst,dout,return);

initial
  begin
  clk = 1'b0;
  forever #(T/2) clk = ~clk;
  end

task reset;
  begin
    @(negedge clk);
        rst = 1'b0;
    @(negedge clk);
        rst = 1'b1;
  end
endtask

task input_rs(input r1,r2);
  begin
  @(negedge clk)
  i=r1;
  j=r2;
end
endtask


initial
  begin

reset;
repeat(10)
 input_rs({$random}%2,{$random}%2);

end

initial
$monitor ("clk=%b, rst=%b, (i,j)=%b,%b, state =%b, outputs dout = %b,return = %b",clk,rst,i,j,DUT.ps,dout,return);

initial
 #400 $stop;
endmodule
