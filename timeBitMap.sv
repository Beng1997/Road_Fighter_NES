
  module timeBitMap (

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
	32'b01111111101001100000110011111100,
	32'b00001100001001100000110010000000,
	32'b00001100001001010000010010000000,
	32'b00001100001001010001010010000000,
	32'b00001100001001010001010010000000,
	32'b00001100001001010001010011111100,
	32'b00001100001001001000010010000000,
	32'b00001100001001001010010010000000,
	32'b00001100001001001010010010000000,
	32'b00001100001001001010010010000000,
	32'b00001100001001000100010011000000,
	32'b00001100001001000100010011111110,
	32'b00000000000000000000000000000000,
	32'b00000000000000000000000000000000 };


 
 
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
