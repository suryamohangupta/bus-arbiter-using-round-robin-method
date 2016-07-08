

module arbiter_k (req0,req1,req2,req3,gnt0,gnt1,gnt2,gnt3,rst,clk);
  input wire req0,req1,req2,req3,rst,clk;
  output reg gnt0,gnt1,gnt2,gnt3;
  
  reg [2:0] state;
  reg [2:0] nxt_state;
  
  //defining types of states required
  
  parameter [2:0] IDLE=000,    
                  REQ0=001,
                  REQ1=010,
                  REQ2=011,
                  REQ3=100;
                  
                  
    always@(posedge clk)  //for transition of states
  begin
  if(rst)
    state <=IDLE;
  else
   state <= nxt_state;
  end 

always@(state,req0,req1,req2,req3) // conditions for states
begin
  case(state)
   
 IDLE:begin
             
        case({req0,req1,req2,req3})
           4'b0000:nxt_state=IDLE;
           4'b0001:nxt_state=REQ3;
           4'b0010:nxt_state=REQ2;
           4'b0011:nxt_state=REQ2;
           4'b0100:nxt_state=REQ1;
           4'b0101:nxt_state=REQ1;
           4'b0110:nxt_state=REQ1;
           4'b0111:nxt_state=REQ1;
           4'b1000:nxt_state=REQ0;
           4'b1001:nxt_state=REQ0;
           4'b1010:nxt_state=REQ0;
           4'b1011:nxt_state=REQ0;
           4'b1100:nxt_state=REQ0;
           4'b1101:nxt_state=REQ0;
           4'b1110:nxt_state=REQ0;
           4'b1111:nxt_state=REQ0;
         endcase
              end
         REQ0: begin
         if(req0&&((req1||~req1)||(req2||~req2)||(req3||~req3)))
         begin 
             gnt0=1;
             gnt1=0;
             gnt2=0;
             gnt3=0;
             $display($time,"req0 is granted");
         nxt_state=REQ1;
           end
        else
        nxt_state= REQ0;
          end
          REQ1:begin
        if(req1&&((req0||~req0)||(req2||~req2)||(req3||~req3)))
        begin 
             gnt0=0;
             gnt1=1;
             gnt2=0;
             gnt3=0;
             $display($time,"req1 is granted");
             nxt_state=REQ2;
         end
       else
          nxt_state= REQ1;
       end
          REQ2: begin
       if(req2&&((req1||~req1)||(req0||~req0)||(req3||~req3)))
       begin 
             gnt0=0;
             gnt1=0;
             gnt2=1;
             gnt3=0;
             $display($time,"req2 is granted");
             nxt_state=REQ3;
           end
       else
          nxt_state= REQ2;
       end
          REQ3:begin
           if(req3&&((req1||~req1)||(req2||~req2)||(req0||~req0)))
            begin 
             gnt0=0;
             gnt1=0;
             gnt2=0;
             gnt3=1;
             $display($time,"req3 is granted");
             nxt_state=REQ0;
           end
       else
        nxt_state= REQ3;
       end
          default:
          $display($time,"invalid request");
        endcase
      end
endmodule

