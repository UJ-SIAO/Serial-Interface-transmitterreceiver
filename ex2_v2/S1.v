module S1(clk,
		  rst,
		  RB1_RW,
		  RB1_A,
		  RB1_D,
		  RB1_Q,
		  sen,
		  sd
		  );

input  clk, rst;
input  [7:0] RB1_Q;  // data path for RB1: output port
output RB1_RW;       // control signal for RB1: Read/Write
output [4:0] RB1_A;  // control signal for RB1: address
output [7:0] RB1_D;  // data path for RB1: input port
output sen, sd;

reg RB1_RW;
reg [4:0] RB1_A;
reg [7:0] RB1_D;
reg sen, sd;

reg [20:0]recive_data0;
reg [20:0]recive_data1;
reg [20:0]recive_data2;
reg [20:0]recive_data3;
reg [20:0]recive_data4;
reg [20:0]recive_data5;
reg [20:0]recive_data6;
reg [20:0]recive_data7;
reg [4:0] addr_cnt;
reg [2:0] RB2_addr_cnt;
reg [4:0] bits_cnt;
reg flag_finish_reci;

reg [1:0]state;
reg [1:0]next_state;
parameter idle=0;
parameter recive=1;
parameter form=2;
parameter transfer=3;

always@(posedge clk or posedge rst)begin
	if(rst)
		RB1_RW<=1;
	else begin
		if(state == recive) begin
			RB1_RW<=1;
		end
		else 
			RB1_RW<=1;
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		addr_cnt<=0;
	else begin
		if(state == recive) begin
			if(addr_cnt == 18)
				addr_cnt<=0;
			else
				addr_cnt<=addr_cnt+1;
		end
		else
			addr_cnt<=0;
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		RB1_A<=0;
	else begin
		if(state == recive)begin
			RB1_A<=addr_cnt;
		end
		else
			RB1_A<=0;
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		flag_finish_reci<=0;
	else begin
		if(RB1_A == 18)
			flag_finish_reci<=1;
		else
			flag_finish_reci<=0;
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)begin
		recive_data0<=0;
		recive_data1<=0;
		recive_data2<=0;
		recive_data3<=0;
		recive_data4<=0;
		recive_data5<=0;
		recive_data6<=0;
		recive_data7<=0;
	end
	else begin
		if(state == recive)begin
			if(RB1_A>=1)begin
				recive_data0[RB1_A-1]<=RB1_Q[7];
				recive_data1[RB1_A-1]<=RB1_Q[6];
				recive_data2[RB1_A-1]<=RB1_Q[5];
				recive_data3[RB1_A-1]<=RB1_Q[4];
				recive_data4[RB1_A-1]<=RB1_Q[3];
				recive_data5[RB1_A-1]<=RB1_Q[2];
				recive_data6[RB1_A-1]<=RB1_Q[1];
				recive_data7[RB1_A-1]<=RB1_Q[0];	
			end
		end
		else if(state == form)begin
			recive_data0[20:18]<=3'b000;
			recive_data1[20:18]<=3'b001;
			recive_data2[20:18]<=3'b010;
			recive_data3[20:18]<=3'b011;
			recive_data4[20:18]<=3'b100;
			recive_data5[20:18]<=3'b101;
			recive_data6[20:18]<=3'b110;
			recive_data7[20:18]<=3'b111;	
		end
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)begin
		sen<=1;
	end
	else begin
		if(state == transfer)begin
			if(bits_cnt >= 21 )
				sen<=1;
			else
				sen<=0;
		end
		else
			sen<=1;
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		RB2_addr_cnt<=0;
	else begin
		if(state == transfer)begin
			if(RB2_addr_cnt == 7 && bits_cnt == 21)
				RB2_addr_cnt<=0;
			else if (bits_cnt == 21)
				RB2_addr_cnt<=RB2_addr_cnt+1;
		end
		else
			RB2_addr_cnt<=0;
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		bits_cnt<=0;
	else begin
		if(state == transfer)begin
			if(bits_cnt == 21)
				bits_cnt<=0;
			else
				bits_cnt<=bits_cnt+1;
		end
		else
			bits_cnt<=0;
	end
end

always@(negedge clk or posedge rst)begin
	if(rst)
		sd<=0;
	else begin
		if(sen==1)
			sd<=0;
		else begin
			case(RB2_addr_cnt)
				0: sd<= (bits_cnt >= 1 ) ?  recive_data0[21-bits_cnt] : 0;
				1: sd<= (bits_cnt >= 1 ) ?  recive_data1[21-bits_cnt] : 0;
				2: sd<= (bits_cnt >= 1 ) ?  recive_data2[21-bits_cnt] : 0;
				3: sd<= (bits_cnt >= 1 ) ?  recive_data3[21-bits_cnt] : 0;
				4: sd<= (bits_cnt >= 1 ) ?  recive_data4[21-bits_cnt] : 0;
				5: sd<= (bits_cnt >= 1 ) ?  recive_data5[21-bits_cnt] : 0;
				6: sd<= (bits_cnt >= 1 ) ?  recive_data6[21-bits_cnt] : 0;
				7: sd<= (bits_cnt >= 1 ) ?  recive_data7[21-bits_cnt] : 0;
				default : sd<=0;
			endcase
		end
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		next_state<=recive;
	else begin
		case(state)
			idle: 		next_state <= recive;
			recive: 	next_state <= form;
			form:		next_state <= transfer;
			transfer:	next_state <= idle;
			default:	next_state <= idle;
		endcase
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		state<=idle;
	else begin
		if(state == idle)begin
			state<=next_state;
		end
		else if(state == recive)begin
			if(flag_finish_reci)
				state<=next_state;
			else
				state<=state;
		end
		else if(state == form)begin
			state<=next_state;
		end
		else if(state == transfer)begin
			if(RB2_addr_cnt == 7 && bits_cnt == 21)
				state<=next_state;
			else
				state<=state;
		end
	end
end
endmodule
