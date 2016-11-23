/*
    This program is free software: you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation, either version 3 of the License, or
     (at your option) any later version.
 
     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
 
     You should have received a copy of the GNU General Public License
     along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 
     Copyright 2016 Andrew 'bunnie' Huang, all rights reserved 
 */

module reg_expander(
		    input wire 	     wr_clk,
		    input wire 	     reset,

		    input wire 	     rd_clk,

		    input wire [2:0] wr_addr,
		    input wire [7:0] wr_data,

		    input wire 	     we,

		    output reg [55:0] bank0,
		    output reg [7:0] bank1
		    );

   reg 				     we_d;
   reg 				     we_d2;
   wire 			     we_rising;
   reg [55:0] 			     state0;
   reg [7:0] 			     state1;
   
   always @(posedge wr_clk) begin
      we_d2 <= we_d;
      we_d <= we;
   end
   assign we_rising = !we_d2 & we_d;
   
   always @(posedge wr_clk) begin
      if( reset ) begin
	 state0 <= 56'h0;
	 state1 <= 8'h0;
      end else begin
	 if( we_rising ) begin
	    case( wr_addr )
	      3'h0: begin
		 state0[7:0] <= wr_data;
	      end
	      3'h1: begin
		 state0[15:8] <= wr_data;
	      end
	      3'h2: begin
		 state0[23:16] <= wr_data;
	      end
	      3'h3: begin
		 state0[31:24] <= wr_data;
	      end
	      3'h4: begin
		 state0[39:32] <= wr_data;
	      end
	      3'h5: begin
		 state0[47:40] <= wr_data;
	      end
	      3'h6: begin
		 state0[55:48] <= wr_data;
	      end
	      3'h7: begin
		 state1[7:0] <= wr_data;
	      end
	    endcase
	 end // if ( we )
      end // else: !if( reset )
   end // always @ (posedge wr_clk)

   always @(posedge rd_clk) begin
      bank0 <= state0;
      bank1 <= state1;
   end

endmodule // reg_expander
