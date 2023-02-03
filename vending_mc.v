module vending_mc( i,j,clk,rst,dout,return);
input i,j;  // 1 and 2 Rs denomination
input clk,rst ;
output reg dout,return;

reg[1:0]ps,ns; //defening the state that is present state and next state//

parameter IDLE = 2'b00;
parameter state1 = 2'b01;        
parameter state2 = 2'b10;

always@(posedge clk) //sequential logic for present state//
  begin  
    if (!rst)  
       ps<=IDLE;
    else
       ps<=ns;
end

always@(ps,i,j)
  begin
  ns = IDLE;
    case(ps)
      IDLE : if ({i,j}==2'b10)
             ns =  state1;
	     else if({i,j}==2'b11)
	     ns = state2;
	     else
	     ns = IDLE;

      state1: if({i,j}==2'b10)
             ns =  state2;
	     else if ({i,j}==2'b11)
	     ns = IDLE;

      state2: if ({i,j}==2'b10)	
             ns =  IDLE;
	     else if ({i,j}==2'b11)	
             ns =  IDLE; 
 
endcase
end

always@(posedge clk)      
  begin
	if(!rst)
	  begin
	    dout <= 1'b0;
	    return <= 1'b0;
	  end
	else
	  begin
	    dout <= 1'b0;
	    return <= 1'b0;
	   case (ps)
	    IDLE :   begin
		     if({i,j}==2'b11)
		     {dout,return} <= {1'b0,1'b0};		
		     else if({i,j}==2'b10)
		     {dout,return} <= {1'b0,1'b0};
		     else
		     {dout,return} <= {1'b0,1'b0};
		      end
	    state1 : begin
		     if({i,j}==2'b11)
		     {dout,return} <= {1'b1,1'b0};
		     else if({i,j}==2'b10)
		     {dout,return} <= {1'b0,1'b0};
		     else
		     {dout,return} <= {1'b0,1'b0};
		     end
	    state2 : begin
		     if({i,j}==2'b10)
		     {dout,return} <= {1'b1,1'b0};
		     else if({i,j}==2'b11)
		     {dout,return} <= {1'b1,1'b1};
		     else
		     {dout,return} <= {1'b0,1'b0};
		     end
	   endcase
	  end
  end
endmodule
