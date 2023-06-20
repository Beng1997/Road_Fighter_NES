// (c) Technion IIT, Department of Electrical Engineering 2021 
//-- Alex Grinshpun Apr 2017
//-- Dudy Nov 13 2017
// SystemVerilog version Alex Grinshpun May 2018
// coding convention dudy December 2018
// updaed Eyal Lev Feb 2021


module	tree_move	(	
 
					input	logic	clk,
					input	logic	resetN,
					input	logic	startOfFrame,  // short pulse every start of frame 30Hz 
					input	logic	Y_down, //change the direction in Y to down 
					input	logic	Y_up,  //change the direction in Y to up  
					input	logic	slow_pulse,
					input	logic	up_is_pressed,
					input	logic	enter_is_pressed,
					input	logic	fast_pulse,
					input logic move_allow,
					input logic restart_enable,
					input	logic	down_is_pressed,
					
					output	 logic signed	[10:0]	topLeftY  // can be negative , if the object is partliy outside 
					
);


// parameters and consts  

parameter int INITIAL_Y = 310;
parameter int INITIAL_Y_SPEED = 0;
parameter int MAX_Y_SPEED = 230;
parameter int MIN_Y_SPEED = 0;
const int  Y_ACCEL = 2;
const int	FIXED_POINT_MULTIPLIER	=	64;
const int	y_FRAME_SIZE	=	479 * FIXED_POINT_MULTIPLIER;
const int	bracketOffset =	30;
const int   OBJECT_WIDTH_X = 64;
const int  offset_Y = 500 * FIXED_POINT_MULTIPLIER;
const int  addition_y = 300*FIXED_POINT_MULTIPLIER;

// local parameters
int Yspeed;
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
		
		// create cyclic motion
		
		if ( topLeftY_FixedPoint >y_FRAME_SIZE) begin
				topLeftY_FixedPoint  <= 0 - offset_Y  ;
			end
		
		// limit speeds
		
		if (Yspeed > MAX_Y_SPEED) begin
			Yspeed <= MAX_Y_SPEED;
			end
		if (Yspeed < MIN_Y_SPEED) begin
			Yspeed <= MIN_Y_SPEED;
			end
		// control movement based on player's presses
		
		if (startOfFrame == 1'b1 && move_allow==1'b1) begin
			topLeftY_FixedPoint  <= topLeftY_FixedPoint + Yspeed;
		end
		if (slow_pulse == 1'b1 && move_allow==1'b1) begin		
			if(up_is_pressed==1'b1) begin
				Yspeed <= Yspeed+20;	// player pressed gas
			end	
		else if (down_is_pressed==1'b1) begin
			Yspeed <= Yspeed-42;    // player pressed break
			end
			else begin
			Yspeed <= Yspeed-18;
			end
		end
		
		if (fast_pulse==1'b1 && move_allow==1'b1) begin
			if (enter_is_pressed ==1'b1) begin
				topLeftY_FixedPoint  <= topLeftY_FixedPoint + 100*FIXED_POINT_MULTIPLIER;	// player pressed enter
			end
		end
		

end
end 

assign 	topLeftY = topLeftY_FixedPoint / FIXED_POINT_MULTIPLIER ;    


endmodule
