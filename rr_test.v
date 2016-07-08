module test_k();
  reg req0,req1,req2,req3,rst,clk;
  wire gnt0,gnt1,gnt2,gnt3;
   arbiter_k n1(.req0(req0),.req1(req1),.req2(req2),.req3(req3),
               .gnt0(gnt0),.gnt1(gnt1),.gnt2(gnt2),.gnt3(gnt3),.rst(rst),.clk(clk));
  
  always  //generating clock pulses
  #2 clk=~clk;
  
  initial
  begin
    clk=0;
    rst=0;
    #2 rst=1;
    #2 rst=0;
    #500 $finish;
  end
  
   always@(posedge clk) //stimulus generation
   if(rst)
     begin
     req0 <= 1'b0;
     req1 <= 1'b0;
     req2 <= 1'b0;
     req3 <= 1'b0;
   end
   else
   begin
     req0 <= $random;
     req1 <= $random;
     req2 <= $random;
     req3 <= $random;
   end
 
  endmodule