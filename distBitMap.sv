
  module distBitMap (

					input	logic	clk, 
					input	logic	resetN, 
					input logic	[10:0] offsetX,// offset from top left  position 
					input logic	[10:0] offsetY, 
					input	logic	InsideRectangle, //input that the pixel is within a bracket 
 
					output	logic	scoreHeaderDR, //output that the pixel should be dispalyed 
					output	logic	[7:0] scoreHeaderRGB  //rgb value from the bitmap 

 ) ; 
 
 
// generating the bitmap 
 

localparam logic [7:0] COLOR_ENCODING = 8'b01101101 ;// RGB value in the bitmap representing the BITMAP coolor
localparam logic [7:0] TRANSPARENT_ENCODING = 8'h00 ;// RGB value in the bitmap representing a transparent pixel  
logic[0:15][0:31] object_colors = {
32'b00000000000000000000000000000000,
32'b00000000000000000000000000000000,
32'b00000000000000000000000000000000,
32'b01111110000100001111000111111110,
32'b01000011000100011000100000110000,
32'b01000001100100010000110000110000,
32'b01000000100100010000000000110000,
32'b01000000100100011100000000110000,
32'b01000000100100001111100000110000,
32'b01000000100100000001110000110000,
32'b01000000100100000000010000110000,
32'b01000001100100110000010000110000,
32'b01000001000100010000110000110000,
32'b01111111000100011111100000110000,
32'b01111000000100000111000000110000,
32'b00000000000000000000000000000000

};


 
 
//////////--------------------------------------------------------------------------------------------------------------= 
//hit bit map has one bit per edge:  hit_colors[3:0] =   {Left, Top, Right, Bottom}	 
//there is one bit per edge, in the corner two bits are set  
 logic [0:3] [0:3] [3:0] hit_colors = 
		   {16'hC446,     
			16'h8C62,    
			16'h8932, 
			16'h9113}; 
 // pipeline (ff) to get the pixel color from the array 	 
//////////--------------------------------------------------------------------------------------------------------------= 
always_ff@(posedge clk or negedge resetN) 
begin 
	if(!resetN) begin 
		scoreHeaderRGB <=	8'h00; 
	end 
	else begin 
		scoreHeaderRGB <= TRANSPARENT_ENCODING ; // default   
 
		if (InsideRectangle == 1'b1 ) 
		begin // inside an external bracket  
			scoreHeaderRGB <= (object_colors[offsetY][offsetX] ==  1 ) ? COLOR_ENCODING  : TRANSPARENT_ENCODING; 
		end  	 
		 
	end 
end 
 
//////////--------------------------------------------------------------------------------------------------------------= 
// decide if to draw the pixel or not 
assign scoreHeaderDR = (scoreHeaderRGB != TRANSPARENT_ENCODING ) ? 1'b1 : 1'b0 ; // get optional transparent command from the bitmpap   
 
endmodule 
