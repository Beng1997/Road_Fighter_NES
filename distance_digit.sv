//
// coding convention dudy December 2018
// (c) Technion IIT, Department of Electrical Engineering 2021
// generating a number bitmap 



module distance_digit	(	
					input		logic	clk,
					input		logic	resetN,
					input 	logic	[10:0] offsetX,// offset from top left  position 
					input 	logic	[10:0] offsetY,
					input		logic	InsideRectangle, //input that the pixel is within a bracket 
					input 	logic	[3:0] thousands,
					input 	logic	[3:0] hundreds,
					input 	logic	[3:0] tens,
					input 	logic	[3:0] units,
					output	logic	drawingRequest, //output that the pixel should be dispalyed 
					output	logic	[7:0]		RGBout
);
// generating a smily bitmap 

parameter  logic	[7:0] digit_color = 8'hff ; //set the color of the digit 


bit [0:15] [0:31] [0:15] number_bitmap  = {


{16'b	0000001111100000,
16'b	0000111111111000,
16'b	0000111111111000,
16'b	0001111111111100,
16'b	0011111001111100,
16'b	0011100000111110,
16'b	0111100000011110,
16'b	0111100000011110,
16'b	1111100000011111,
16'b	1111000000001111,
16'b	1111000000001111,
16'b	1111000000001111,
16'b	1111000000001111,
16'b	1111000000001111,
16'b	1111000000001111,
16'b	1111000000001111,
16'b	1111000000001111,
16'b	1111000000001111,
16'b	1111000000001111,
16'b	1111000000001111,
16'b	1111000000001111,
16'b	1111000000001111,
16'b	1111000000001111,
16'b	1111000000011110,
16'b	1111100000011110,
16'b	0111110000111110,
16'b	0111110000111100,
16'b	0011111001111100,
16'b	0011111111111000,
16'b	0001111111111000,
16'b	0000111111110000,
16'b	0000011111000000},


																	
{16'b	0000000011100000,
16'b	0000000111100000,
16'b	0000011111100000,
16'b	0000111111100000,
16'b	0001111111100000,
16'b	0011111111100000,
16'b	0111111011100000,
16'b	0111100011100000,
16'b	0111000011100000,
16'b	0010000011100000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0111111111111111,
16'b	0111111111111111,
16'b	0111111111111111,
16'b	0111111111111111},
																	
{16'b	0000111111100000,
16'b	0001111111110000,
16'b	0111111111111000,
16'b	1111111111111000,
16'b	1111110011111100,
16'b	1111000011111100,
16'b	1110000001111110,
16'b	0000000000111110,
16'b	0000000000111110,
16'b	0000000000111110,
16'b	0000000000111100,
16'b	0000000001111100,
16'b	0000000001111100,
16'b	0000000001111000,
16'b	0000000011111000,
16'b	0000000011111000,
16'b	0000000011111000,
16'b	0000000011110000,
16'b	0000000011100000,
16'b	0000000111000000,
16'b	0000001111000000,
16'b	0000011110000000,
16'b	0000111100000000,
16'b	0001111100000000,
16'b	0001111100000000,
16'b	0011111000000000,
16'b	0111110000000001,
16'b	1111100000000011,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111111111111111},
																	
{16'b	0000111111100000,
16'b	0001111111111000,
16'b	0111111111111000,
16'b	1111111111111000,
16'b	1111110011111100,
16'b	1111000001111100,
16'b	1110000001111100,
16'b	0000000000111110,
16'b	0000000000111100,
16'b	0000000000111100,
16'b	0000000000111100,
16'b	0000000001111100,
16'b	0000000011111000,
16'b	0000000011111000,
16'b	0001111111110000,
16'b	0001111111000000,
16'b	0001111111111000,
16'b	0001111111111000,
16'b	0000000011111100,
16'b	0000000001111110,
16'b	0000000000111111,
16'b	0000000000011111,
16'b	0000000000011111,
16'b	0000000000011111,
16'b	0000000000011111,
16'b	0000000000111111,
16'b	1110000001111110,
16'b	1111100011111110,
16'b	1111111111111100,
16'b	1111111111111000,
16'b	0111111111111000,
16'b	0001111111000000},
																	
{16'b	0000000011111000,
16'b	0000000011111000,
16'b	0000000011111000,
16'b	0000000011111000,
16'b	0000000111111000,
16'b	0000001111111000,
16'b	0000001101111000,
16'b	0000011101111000,
16'b	0000011101111000,
16'b	0000111101111000,
16'b	0001111101111000,
16'b	0001111101111000,
16'b	0001111001111000,
16'b	0011111001111000,
16'b	0011110001111000,
16'b	0111100001111000,
16'b	0111100001111000,
16'b	1111000001111000,
16'b	1110000001111000,
16'b	1110000001111000,
16'b	1110000001111000,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	0000000001111000,
16'b	0000000001111000,
16'b	0000000001111000,
16'b	0000000001111000,
16'b	0000000001111000,
16'b	0000000001111000,
16'b	0000000001111000,
16'b	0000000011111100},
																	
{16'b	0111111111111111,
16'b	0111111111111111,
16'b	0111111111111110,
16'b	0111111111111100,
16'b	0111100000000000,
16'b	0111100000000000,
16'b	0111100000000000,
16'b	0111100000000000,
16'b	0111100000000000,
16'b	0111100000000000,
16'b	0111100000000000,
16'b	0111111111100000,
16'b	0111111111111000,
16'b	0111111111111000,
16'b	0111111111111100,
16'b	0010000011111110,
16'b	0000000001111110,
16'b	0000000000111111,
16'b	0000000000011111,
16'b	0000000000011111,
16'b	0000000000001111,
16'b	0000000000001111,
16'b	0000000000001111,
16'b	0000000000011111,
16'b	0000000000011111,
16'b	1000000000111110,
16'b	1100000001111110,
16'b	1111100011111100,
16'b	1111111111111000,
16'b	1111111111111000,
16'b	1111111111110000,
16'b	0001111111000000},
																	
{16'b	0000000111111100,
16'b	0000011111111110,
16'b	0000111111111110,
16'b	0001111111111111,
16'b	0001111100001111,
16'b	0011111100000001,
16'b	0011111000000000,
16'b	0111110000000000,
16'b	0111100000000000,
16'b	1111100000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111001111111000,
16'b	1111111111111100,
16'b	1111111111111110,
16'b	1111111111111111,
16'b	1111111101111111,
16'b	1111100000011111,
16'b	1111000000001111,
16'b	1111000000000111,
16'b	1111000000000111,
16'b	1111000000000111,
16'b	1111000000000111,
16'b	1111100000001111,
16'b	1111100000001111,
16'b	0111110000011111,
16'b	0111111101111110,
16'b	0011111111111110,
16'b	0001111111111100,
16'b	0001111111111000,
16'b	0000011111100000},
																	
{16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1100000000001111,
16'b	1000000000011111,
16'b	0000000000011111,
16'b	0000000000011110,
16'b	0000000000111110,
16'b	0000000000111100,
16'b	0000000001111100,
16'b	0000000001111000,
16'b	0000000011111000,
16'b	0000000011111000,
16'b	0000000011111000,
16'b	0000000011111000,
16'b	0000000011110000,
16'b	0000000011110000,
16'b	0000000011100000,
16'b	0000000011100000,
16'b	0000000111100000,
16'b	0000000111100000,
16'b	0000001111000000,
16'b	0000001111000000,
16'b	0000011110000000,
16'b	0000011110000000,
16'b	0000111110000000,
16'b	0000111100000000,
16'b	0000111100000000,
16'b	0001111100000000,
16'b	0001111100000000,
16'b	0001111100000000},
																	
{16'b	0000111111110000,
16'b	0001111111111000,
16'b	0011111111111100,
16'b	0111111111111110,
16'b	0111111011111110,
16'b	1111100000111111,
16'b	1111100000011111,
16'b	1111000000001111,
16'b	1111000000001111,
16'b	1111000000001111,
16'b	1111100000011110,
16'b	0111110000111110,
16'b	0111111001111100,
16'b	0011111111111000,
16'b	0001111111111000,
16'b	0000111111100000,
16'b	0000111111110000,
16'b	0001111111111000,
16'b	0011111111111100,
16'b	0111111001111110,
16'b	1111100000111111,
16'b	1111000000001111,
16'b	1110000000001111,
16'b	1110000000000111,
16'b	1110000000000111,
16'b	1111000000001111,
16'b	1111100000011111,
16'b	1111111001111111,
16'b	1111111111111110,
16'b	0111111111111110,
16'b	0011111111111000,
16'b	0001111111110000},
																	
{16'b	0000111111100000,
16'b	0001111111111000,
16'b	0011111111111000,
16'b	0111111111111100,
16'b	1111111011111100,
16'b	1111100000111110,
16'b	1111000000011110,
16'b	1111000000011111,
16'b	1110000000001111,
16'b	1110000000001111,
16'b	1110000000001111,
16'b	1110000000001111,
16'b	1111000000001111,
16'b	1111100000011111,
16'b	1111111011111111,
16'b	1111111111111111,
16'b	0111111111111111,
16'b	0011111111111111,
16'b	0001111111001111,
16'b	0000000000001111,
16'b	0000000000001111,
16'b	0000000000001111,
16'b	0000000000011110,
16'b	0000000000011110,
16'b	0000000000111110,
16'b	0000000001111100,
16'b	1000000011111100,
16'b	1111000011111000,
16'b	1111111111111000,
16'b	1111111111110000,
16'b	1111111111100000,
16'b	0011111100000000},

{16'b	0000011111100000,
16'b	0000011111100000,
16'b	0000011111100000,
16'b	0000011111100000,
16'b	0000111111110000,
16'b	0000110000111000,
16'b	0000110000111000,
16'b	0000110000111000,
16'b	0001110000111100,
16'b	0001100000011100,
16'b	0011100000011100,
16'b	0011000000001100,
16'b	0111000000001110,
16'b	0111000000001110,
16'b	0111000000001110,
16'b	0111000000001110,
16'b	0111000000001110,
16'b	0111000000001110,
16'b	0111000000001110,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1110000000000111,
16'b	1110000000000111,
16'b	1110000000000111,
16'b	1110000000000111,
16'b	1110000000000111,
16'b	1110000000000111,
16'b	1110000000000111,
16'b	1110000000000111,
16'b	1110000000000111,
16'b	1111000000001111},


{16'b	1111111111110000,
16'b	1111111111111000,
16'b	1111111111111100,
16'b	1111111111111110,
16'b	0111000011111110,
16'b	0111000000111111,
16'b	0111000000011111,
16'b	0111000000001111,
16'b	0111000000001111,
16'b	0111000000001111,
16'b	0111000000011110,
16'b	0111000000111110,
16'b	0111000001111100,
16'b	0111111111111000,
16'b	0111111111111000,
16'b	0111111111100000,
16'b	0111111111110000,
16'b	0111111111111000,
16'b	0111111111111100,
16'b	0111000001111110,
16'b	0111000000111111,
16'b	0111000000001111,
16'b	0111000000001111,
16'b	0111000000000111,
16'b	0111000000000111,
16'b	0111000000001111,
16'b	0111000000011111,
16'b	0111000001111111,
16'b	1111111111111110,
16'b	1111111111111110,
16'b	1111111111111000,
16'b	1111111111110000},

{16'b	0000001111111000,
16'b	0000111111111100,
16'b	0000111111111110,
16'b	0001111111111111,
16'b	0011111001000011,
16'b	0011100000000001,
16'b	0111100000000000,
16'b	0111100000000000,
16'b	1111100000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111100000000000,
16'b	0111110000000000,
16'b	0111110000000001,
16'b	0011111001000011,
16'b	0011111111111111,
16'b	0001111111111110,
16'b	0000111111111100,
16'b	0000011111111000},


{16'b	1111111111100000,
16'b	1111111111111000,
16'b	1111111111111000,
16'b	1111111111111100,
16'b	0111000001111100,
16'b	0111000000111110,
16'b	0111000000011110,
16'b	0111000000011110,
16'b	0111000000011111,
16'b	0111000000001111,
16'b	0111000000001111,
16'b	0111000000001111,
16'b	0111000000001111,
16'b	0111000000001111,
16'b	0111000000001111,
16'b	0111000000001111,
16'b	0111000000001111,
16'b	0111000000001111,
16'b	0111000000001111,
16'b	0111000000001111,
16'b	0111000000001111,
16'b	0111000000001111,
16'b	0111000000001111,
16'b	0111000000011110,
16'b	0111000000011110,
16'b	0111000000111110,
16'b	0111000000111100,
16'b	0111000001111100,
16'b	1111111111111000,
16'b	1111111111111000,
16'b	1111111111110000,
16'b	1111111111000000},

{16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111000000000011,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000001,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111000000000001,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000001000011,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111111111111111},

{16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111000000000011,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000001,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111111111111111,
16'b	1111000000000001,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000,
16'b	1111000000000000}


} ; 
																	
	


// pipeline (ff) to get the pixel color from the array 	 

always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
		drawingRequest <=	1'b0;
	end
	else begin
		drawingRequest <=	1'b0;
	
		if (InsideRectangle == 1'b1 )
			if (offsetX < 16)
			drawingRequest <= (number_bitmap[thousands][offsetY][offsetX]);
			else if ( offsetX > 21 && offsetX < 38) 
				drawingRequest <= (number_bitmap[hundreds][offsetY][offsetX-22]);
			else if ( offsetX > 43 && offsetX < 59)
			  drawingRequest <= (number_bitmap[tens][offsetY][offsetX-44]);
			else if ( offsetX > 64 && offsetX < 80)
			  drawingRequest <= (number_bitmap[units][offsetY][offsetX-65]);
					
				
				//get value from bitmap  
	end 
end

assign RGBout = digit_color ; // this is a fixed color 

endmodule