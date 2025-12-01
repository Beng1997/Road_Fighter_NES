module distance_counter (
  input  logic clk,
  input  logic resetN,
  input  logic one_sec,
  input  logic load_en,
  input  logic count_en,
  input  logic slow_pulse,
  input  logic up_is_pressed,
  input  logic player_move, 
  input  logic restart_enable,
  input  logic enter_is_pressed,
  output logic [3:0] thousands,
  output logic [3:0] hundreds,
  output logic [3:0] tens,
  output logic [3:0] units,
  output logic dist_end
);
  int count;


  always_ff @( posedge clk or negedge resetN ) begin
    if ( !resetN ) begin
      dist_end =1'b0;
		count <= 10'd1000; 
	 end 
	  
	 else begin
	 if (count < 8'd0 || count == 8'd0) begin
         dist_end <= 1'b1;
			count <= 10'd1000;
			 
     end 	  
	 if (restart_enable == 1'b1) begin
			dist_end <= 1'b0;
	 end
	 if (load_en == 1'b1) begin
		 count <= 10'd1000;
	 end
	 
	 if( slow_pulse==1'b1 && up_is_pressed== 1'b1) begin
	
        if (count < 8'd0 || count == 8'd0) begin
         dist_end <= 1'b1;
			count <= 10'd1000;
			 
        end 
		  else  if (count_en == 1'b1 && player_move == 1'b1)begin
          count <= count - 1;
        end
      


	end
	
	if( slow_pulse==1'b1 && enter_is_pressed== 1'b1) begin
	
        if (count == 8'd0) begin
         dist_end <= 1'b1;
			count <= 10'd1000;
			 
        end 
		  else  if (count_en == 1'b1 && player_move == 1'b1)begin
          count <= count - 10;
        end
      


	end
	
	
	end
	  

    end
  assign thousands = count /1000 ;
  assign hundreds = (count /100)%10 ;
  assign tens = (count / 10) %10;
  assign units = count % 10;

endmodule
