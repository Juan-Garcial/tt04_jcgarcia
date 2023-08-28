`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.08.2023 19:35:24
// Design Name: 
// Module Name: RELOG_10M
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define USE_POWER_PINS

module tt_um_RELOG_10M_Juan_Garcial(
    input clk,
    input rst,
    input disp_type,
    input fmt,
    input prog,
    input adjust,
    output ampm,
    output reg segments_,
    output [2:0] disp_select_, 
    output [2:0] segment_select_
    );
    
    assign disp_select_ = disp_select;
    assign segment_select_ = segment_select;
    
    //clock registers
    reg [3:0] u_seg_r;
    reg [3:0] d_seg_r;
    reg [3:0] u_min_r;
    reg [3:0] d_min_r;
    reg [4:0] hrs_r;
    wire [3:0] u_hr;
    wire [3:0] d_hr;
    //freq div registers
    reg [12:0] count_a;    
    reg [10:0] count_b;
    reg clk_500u;
    reg clk_1s; 
    // internal resets
    
    wire rst_c;
   
    reg [2:0] segment_select;
    reg [3:0] data_select;
    reg [2:0] disp_select;
    wire [6:0] segments;
    reg [1:0] mode; 
    reg clk_reloj;
  	reg clk_timer;
    reg timer_str;
    reg cron_str;
    reg [4:0]hr_select;
    
    
    bcd_to_7seg D0( 
        
        data_select,
        disp_type,
        segments
);           
	hr_conv D1(
	
	
	fmt,
	hrs_r,
	u_hr,
	d_hr,
	ampm
	
	);


	always@(posedge prog, negedge rst)begin
	
		
		if(rst == 0)begin
		
			mode = 0;
		
		end
		else begin
		
			mode = mode +1;
		
		end
		
	
	end	
  
  always@(mode,adjust,clk_1s)begin // clk reloj select 
   
  	if(mode != 0 )begin
  	
  		clk_reloj = adjust;
  	
  	end
  	else begin
  	
  		
  		clk_reloj = clk_1s;
  	
  	end
  
  end
  

    
    always@(segment_select,segments)begin //selection of module to send output
    
    case(segment_select)
            
            0: segments_ = segments[0]; // 0
            1: segments_ = segments[1]; // 1
            2: segments_ = segments[2]; // 2
            3: segments_ = segments[3]; // 3
            4: segments_ = segments[4]; // 4
            5: segments_ = segments[5]; // 5
            6: segments_ = segments[6]; // 5
            default: segments_ = 1'b1; // Display nothing or error
                        
        endcase
    
    end
    
    always@(*)begin //function select
    
      		case (mode)
        
        		0:begin
					
					case(disp_select)
				    
						0: data_select = u_seg_r; // 0
						1: data_select = d_seg_r; // 1
						2: data_select = u_min_r; // 2
						3: data_select = d_min_r; // 3
						4: data_select = u_hr; // 4
						5: data_select = d_hr; // 5
						default: data_select = 4'b1111; // Display nothing or error
				                
					endcase
		    
        	end
		    1:begin
		    
		    	case(disp_select)
		        
					0: data_select = u_seg_r; // 0
					1: data_select = d_seg_r; // 1
					2: data_select = 10; // 2
					3: data_select = 10; // 3
					4: data_select = 10; // 4
					5: data_select = 10; // 5
				    default: data_select = 4'b1111; // Display nothing or error
		                    
		    	endcase
		    end
		    2:begin
		    
		    	case(disp_select)
		        
					0: data_select = 10; // 0
					1: data_select = 10; // 1
					2: data_select = u_min_r; // 2
					3: data_select = d_min_r; // 3
					4: data_select = 10; // 4
					5: data_select = 10; // 5
				    default: data_select = 4'b1111; // Display nothing or error
		                    
		    	endcase
		    end
		    3:begin
		    
		    	case(disp_select)
		        
					0: data_select = 10; // 0
					1: data_select = 10; // 1
					2: data_select = 10; // 2
					3: data_select = 10; // 3
					4: data_select = u_hr; // 4
					5: data_select = d_hr; // 5
				    default: data_select = 4'b1111; // Display nothing or error
		                    
		    	endcase
        
        	end
        	default data_select = 4'b1111;
       endcase
       end
       
    
    
    always@(posedge clk_500u)begin
    
         count_b = count_b +1;
        
        if(count_b < 2000)begin
            
           
            clk_1s = 0;
            
        end
        else begin
        
            clk_1s = 1;
            count_b = 0;
            
        end
    
    end
    
    always@(posedge clk_500u,negedge rst)begin
    
    	if(rst == 0)begin
    	
    		segment_select = 0;
         	disp_select = 0;
    	
    	
    	end
    	else begin
    	
    		segment_select = segment_select + 1;
    		if(segment_select == 7)begin
    		
    			disp_select = disp_select +1;
    			segment_select = 0;
    			
    			if (disp_select == 6) disp_select = 0;
    		
    		end
    	
    	
    	end
    
         
    end
    
     always@(posedge clk)begin
    
        count_a = count_a +1;
        
        if(count_a < 5000)begin
            
            
            clk_500u = 0;
            
        end
        else begin
        
            clk_500u = 1;
            count_a = 0;
            
        end
    
    end
     
    
    always@(posedge clk_reloj, negedge rst) begin// CLK REGISTER
    
        if(rst == 0)begin
        
            u_seg_r = 0;
            d_seg_r = 0;
            u_min_r = 0;
            d_min_r = 0;
            hrs_r = 0;
        
        end
        
    
    else if (mode == 1 )begin
    
    	u_seg_r = u_seg_r + 1;
            if(u_seg_r >= 10) begin
                
                u_seg_r = 0;
                d_seg_r = d_seg_r + 1;
                
                if(d_seg_r >= 6) begin
                    
                  d_seg_r = 0;
                end
                
             end  
     
    end
    else if(mode == 2 ) begin 
    
    	u_min_r = u_min_r +1;
                  
            if(u_min_r >= 10)begin
                    
                u_min_r = 0;
                 d_min_r = d_min_r +1;
                    
                 if(d_min_r >= 6)begin
                        
                    d_min_r = 0;
                 
                 end
            
            end
    
    end
    else if(mode == 3 )begin
    
    	hrs_r = hrs_r +1;
                        
           if(hrs_r == 24) begin
                        
        	hrs_r = 0;
                            
                        
           end
    
    end
    
    else begin
        
            u_seg_r = u_seg_r + 1;
            if(u_seg_r >= 10) begin
                
                u_seg_r = 0;
                d_seg_r = d_seg_r + 1;
                
                if(d_seg_r >= 6) begin
                    
                  d_seg_r = 0;
                  u_min_r = u_min_r +1;
                  
                  if(u_min_r >= 10)begin
                    
                    u_min_r = 0;
                    d_min_r = d_min_r +1;
                    
                    if(d_min_r >= 6)begin
                        
                        d_min_r = 0;
                        hrs_r = hrs_r +1;
                        
                        if(hrs_r == 24) begin
                        
                            hrs_r = 0;
                            u_seg_r = 0;
                            d_seg_r = 0;
                            u_min_r = 0;
                            d_min_r = 0;
                        
                        end
                       
                    
                    end
                  
                  end  
                
                end
            
            end      
        
        end
    
    
    end
     
endmodule

module bcd_to_7seg(
    input [3:0] bcd_in,
    input fmt,
    output reg [6:0] seg_out
);

    always @(*)begin
	    if(fmt)begin
	    
		case (bcd_in)
		    4'b0000: seg_out = 7'b1000000; // 0
		    4'b0001: seg_out = 7'b1111001; // 1
		    4'b0010: seg_out = 7'b0100100; // 2
		    4'b0011: seg_out = 7'b0110000; // 3
		    4'b0100: seg_out = 7'b0011001; // 4
		    4'b0101: seg_out = 7'b0010010; // 5
		    4'b0110: seg_out = 7'b0000010; // 6
		    4'b0111: seg_out = 7'b1111000; // 7
		    4'b1000: seg_out = 7'b0000000; // 8
		    4'b1001: seg_out = 7'b0011000; // 9
		    4'b1010: seg_out = 7'b1111111; // 10
		    default: seg_out = 7'b1111111; // Display nothing or error
		endcase
	    	
	    end
	    else begin
	    
	    	case (bcd_in)
		    4'b0000: seg_out = ~7'b1000000; // 0
		    4'b0001: seg_out = ~7'b1111001; // 1
		    4'b0010: seg_out = ~7'b0100100; // 2
		    4'b0011: seg_out = ~7'b0110000; // 3
		    4'b0100: seg_out = ~7'b0011001; // 4
		    4'b0101: seg_out = ~7'b0010010; // 5
		    4'b0110: seg_out = ~7'b0000010; // 6
		    4'b0111: seg_out = ~7'b1111000; // 7
		    4'b1000: seg_out = ~7'b0000000; // 8
		    4'b1001: seg_out = ~7'b0011000; // 9
		    4'b1010: seg_out = ~7'b1111111; // 10
		    default: seg_out = ~7'b1111111; // Display nothing or error
		endcase
	    	
	    end
    end

endmodule


module hr_conv(

	input fmt,
	input [4:0]hrs,
	output reg [3:0] u_hr,
	output reg [3:0] d_hr,
	output reg ampm


);

	always@(hrs,fmt)begin
    
    	if(fmt)begin//12hrs
    	
    		case(hrs)
    		
    	 
             0:begin
             		
             	u_hr =	2;	
               d_hr = 1;
               ampm = 0; 
             end
    	 	1:begin
             		
             	u_hr =	1;	
               d_hr = 0;
               ampm = 0;
             end
             2:begin
             		
             	u_hr =	2;	
               d_hr = 0;
               ampm = 0;
             end
             3:begin
             		
             	u_hr =	3;	
               d_hr = 0;
               ampm = 0;
             end
             4:begin
             		
             	u_hr =	4;	
               d_hr = 0;
               ampm = 0;
             end
            5:begin
             		
             	u_hr =	5;	
               d_hr = 0;
               ampm = 0;
             end
             6:begin
             		
             	u_hr =	6;	
               d_hr = 0;
               ampm = 0;
             end
             7:begin
             		
             	u_hr =	7;	
               d_hr = 0;
               ampm = 0;
             end
             8:begin
             		
             	u_hr =	8;	
               d_hr = 0;
               ampm = 0;
             end
             9:begin
             		
             	u_hr =	9;	
               d_hr = 0;
               ampm = 0;
             end
             10:begin
             		
             	u_hr =	0;	
               d_hr = 1;
               ampm = 0;
             end
             11:begin
             		
             	u_hr =	1;	
               d_hr = 1;
               ampm = 0;
             end
             12:begin
             		
             	u_hr =	2;	
               d_hr = 1;
               ampm = 1;
             end
             13:begin
             		
             	u_hr =	1;	
               d_hr = 0;
               ampm = 1;
             end
             14:begin
             		
             	u_hr =	2;	
               d_hr = 0;
               ampm = 1;
             end
             15:begin
             		
             	u_hr =	3;	
               d_hr = 0;
               ampm = 1;
             end
             16:begin
             		
             	u_hr =	4;	
               d_hr = 0;
               ampm = 1;
             end
             17:begin
             		
             	u_hr =	5;	
               d_hr = 0;
               ampm = 1;
             end
             18:begin
             		
             	u_hr =	6;	
               d_hr = 0;
               ampm = 1;
             end
             19:begin
             		
             	u_hr =	7;	
               d_hr = 0;
               ampm = 1;
             end
             20:begin
             		
             	u_hr =	8;	
               d_hr = 0;
               ampm = 1;
             end
             21:begin
             		
             	u_hr =	9;	
               d_hr = 0;
               ampm = 1;
             end
             22:begin
             		
             	u_hr =	0;	
               d_hr = 1;
               ampm = 1;
             end
             23:begin
             		
             	u_hr =	1;	
               d_hr = 1;
               ampm = 1;
             end
             default:begin
             		
             	u_hr =	0;	
               d_hr = 0;
               ampm = 0;
             end
    		
    		endcase
    	
    	end
    	else begin//24hrs
    	
    	ampm = 0;
    	
    	
    	 case(hrs)
    	 
             0:begin
             		
             	u_hr =	0;	
               d_hr = 0;
             end
    	 	1:begin
             		
             	u_hr =	1;	
               d_hr = 0;
             end
             2:begin
             		
             	u_hr =	2;	
               d_hr = 0;
             end
             3:begin
             		
             	u_hr =	3;	
               d_hr = 0;
             end
             4:begin
             		
             	u_hr =	4;	
               d_hr = 0;
             end
            5:begin
             		
             	u_hr =	5;	
               d_hr = 0;
             end
             6:begin
             		
             	u_hr =	6;	
               d_hr = 0;
             end
             7:begin
             		
             	u_hr =	7;	
               d_hr = 0;
             end
             8:begin
             		
             	u_hr =	8;	
               d_hr = 0;
             end
             9:begin
             		
             	u_hr =	9;	
               d_hr = 0;
             end
             10:begin
             		
             	u_hr =	0;	
               d_hr = 1;
             end
             11:begin
             		
             	u_hr =	1;	
               d_hr = 1;
             end
             12:begin
             		
             	u_hr =	2;	
               d_hr = 1;
             end
             13:begin
             		
             	u_hr =	3;	
               d_hr = 1;
             end
             14:begin
             		
             	u_hr =	4;	
               d_hr = 1;
             end
             15:begin
             		
             	u_hr =	5;	
               d_hr = 1;
             end
             16:begin
             		
             	u_hr =	6;	
               d_hr = 1;
             end
             17:begin
             		
             	u_hr =	7;	
               d_hr = 1;
             end
             18:begin
             		
             	u_hr =	8;	
               d_hr = 1;
             end
             19:begin
             		
             	u_hr =	9;	
               d_hr = 1;
             end
             20:begin
             		
             	u_hr =	0;	
               d_hr = 2;
             end
             21:begin
             		
             	u_hr =	1;	
               d_hr = 2;
             end
             22:begin
             		
             	u_hr =	2;	
               d_hr = 2;
             end
             23:begin
             		
             	u_hr =	3;	
               d_hr = 2;
             end
             default:begin
             		
             	u_hr =	0;	
               d_hr = 0;
             end
    	 endcase 
    	 
    	
    	end
    	
    end
	

endmodule
