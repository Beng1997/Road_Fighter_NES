// (c) Technion IIT, Department of Electrical Engineering 2021 
//-- Alex Grinshpun Apr 2017
//-- Dudy Nov 13 2017
// SystemVerilog version Alex Grinshpun May 2018
// coding convention dudy December 2018
// updaed Eyal Lev Feb 2021


module	truck_move	(	
 
					input	logic	clk,
					input	logic	resetN,
					input	logic	startOfFrame,  // short pulse every start of frame 30Hz 
					input	logic	Y_down, //change the direction in Y to down 
					input	logic	Y_up,  //change the direction in Y to up  
					input	logic	slow_pulse,
					input	logic	up_is_pressed,
					input	logic	fast_pulse,
					input	logic	enter_is_pressed,
					input logic move_allow,
					input logic restart_enable,
					input logic player_move,
					input	logic	down_is_pressed,
					input	logic	player_truck_hitPulse,
					input	logic	[3:0] HitEdgeCode,
					input logic penalty_mode,
					
					
					
					output	 logic signed	[10:0]	topLeftX,
					output	 logic signed	[10:0]	topLeftY  
					
);


// parameters and consts 

parameter int INITIAL_X = 50;
parameter int INITIAL_Y = 310;
parameter int INITIAL_Y_SPEED = 0;
parameter int MAX_Y_SPEED = 230;
parameter int MIN_Y_SPEED = 0;
const int  Y_ACCEL = 2;
const int	FIXED_POINT_MULTIPLIER	=	64;
const int	y_FRAME_SIZE	=	479 * FIXED_POINT_MULTIPLIER;
const int	bracketOffset =	30;
const int   OBJECT_WIDTH_X = 64* FIXED_POINT_MULTIPLIER;
const int  offset_Y = 180 * FIXED_POINT_MULTIPLIER;
const int  addition_y = 1200*FIXED_POINT_MULTIPLIER;
const int	left_border	=	150 * FIXED_POINT_MULTIPLIER;
const int	right_border	=	425 * FIXED_POINT_MULTIPLIER;


// local parameters
int Yspeed;
int topLeftX_FixedPoint;
int topLeftY_FixedPoint;


//////////--------------------------------------------------------------------------------------------------------------=
//  calculation 0f Y Axis speed using gravity or colision

always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin 
		Yspeed	<= INITIAL_Y_SPEED;
		topLeftY_FixedPoint	<= INITIAL_Y * FIXED_POINT_MULTIPLIER;
	
	
	end 
	else begin
	
		
		
		if(restart_enable==1'b1) begin 
		Yspeed	<= INITIAL_Y_SPEED;
		topLeftY_FixedPoint	<= INITIAL_Y * FIXED_POINT_MULTIPLIER;
	
	
		end 
		
		// in case of collision
		
		if (player_truck_hitPulse && (HitEdgeCode [2] == 1 ||  HitEdgeCode [3] == 1) && penalty_mode==1'b0)  // hit top border of brick  
				if (Yspeed < 0) // while moving up
						Yspeed <= -Yspeed ; 
			
		if (player_truck_hitPulse && (HitEdgeCode [0] == 1  ||  HitEdgeCode [1] == 1) && penalty_mode==1'b0)// || (collision && HitEdgeCode [1] == 1 ))   hit bottom border of brick  
				if (Yspeed > 0 )//  while moving down
						Yspeed <= -Yspeed ; 
		
		
		// create cyclic motion
		
		if ( topLeftY_FixedPoint >y_FRAME_SIZE+addition_y) begin
				topLeftY_FixedPoint  <= 0 - offset_Y+1  ;
			end
		if ( topLeftY_FixedPoint <0-offset_Y) begin
				topLeftY_FixedPoint  <= y_FRAME_SIZE+addition_y-1  ;
			end	
		
		// limit speeds
		
		if (Yspeed > MAX_Y_SPEED) begin
			Yspeed <= MAX_Y_SPEED;
			end
		if (Yspeed < MIN_Y_SPEED) begin
			Yspeed <= MIN_Y_SPEED;
			end
		// move based on player's presses
		if (startOfFrame == 1'b1 && move_allow==1'b1) begin
			topLeftY_FixedPoint  <= topLeftY_FixedPoint + Yspeed;
		end
		if (slow_pulse == 1'b1 && move_allow==1'b1) begin		
			if(up_is_pressed==1'b1 && player_move==1'b1) begin
				Yspeed <= Yspeed+20;  //player pressed gas
			end	
			else if(down_is_pressed==1'b1 && player_move==1'b1) begin
				Yspeed <= Yspeed-40;  //player pressed break
			end
			else begin
			Yspeed <= Yspeed-23;
			end
		end
		
		if (fast_pulse==1'b1 && move_allow==1'b1) begin
			if (enter_is_pressed ==1'b1 && player_move==1'b1) begin
				topLeftY_FixedPoint  <= topLeftY_FixedPoint + 100*FIXED_POINT_MULTIPLIER;   //player jumps
			end
		end
	

end
end 

always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin 
		topLeftX_FixedPoint	<= INITIAL_X * FIXED_POINT_MULTIPLIER;	
	end 
	else begin
	if(restart_enable==1'b1) begin 
		topLeftX_FixedPoint	<= INITIAL_X * FIXED_POINT_MULTIPLIER;	
	end 
		
		// randomize truck's x position when outside
		
		if (topLeftX_FixedPoint<left_border || topLeftX_FixedPoint>right_border) begin
			topLeftX_FixedPoint	<= 150 * FIXED_POINT_MULTIPLIER;	
		end
		
		if (startOfFrame == 1'b1) begin		
			if(topLeftY_FixedPoint + offset_Y <0 || topLeftY_FixedPoint>y_FRAME_SIZE) begin
					topLeftX_FixedPoint <= topLeftX_FixedPoint+60;
			end
		end
	end
end


assign 	topLeftY = topLeftY_FixedPoint / FIXED_POINT_MULTIPLIER ;    
assign 	topLeftX = topLeftX_FixedPoint / FIXED_POINT_MULTIPLIER ;

endmodule
