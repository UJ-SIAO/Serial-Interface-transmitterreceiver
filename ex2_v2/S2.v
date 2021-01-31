module S2(clk,
		  rst,
		  S2_done,
		  RB2_RW,
		  RB2_A,
		  RB2_D,
		  RB2_Q,
		  sen,
		  sd);

input clk, rst;
input [17:0] RB2_Q;
input sen, sd;

output S2_done, RB2_RW;
output [2:0] RB2_A;
output [17:0] RB2_D;

reg	S2_done, RB2_RW;
reg [2:0] RB2_A;
reg [17:0] RB2_D;

reg  sen_1;
reg  sen_2;
wire neg_sen;
reg	 [20:0]recive_data0;
reg  [20:0]recive_data1;
reg  [20:0]recive_data2;
reg  [20:0]recive_data3;
reg  [20:0]recive_data4;
reg  [20:0]recive_data5;
reg  [20:0]recive_data6;
reg  [20:0]recive_data7;
reg  [4:0] bits_cnt;
reg  [4:0] package_cnt;
reg  [4:0] finish_cnt;
reg  sd_temp;

always@(posedge clk or posedge rst)begin
	if(rst)begin
		package_cnt<=0;
	end
	else begin
		if(sen == 1 && bits_cnt == 21)
			package_cnt<=package_cnt+1;
		else
			package_cnt<=package_cnt;
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		sd_temp<=0;
	else 
		sd_temp<=sd;
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
			if(package_cnt == 0)
				recive_data0[21-bits_cnt]<=sd_temp;
			else if (package_cnt == 1)
				recive_data1[21-bits_cnt]<=sd_temp;
			else if (package_cnt == 2)
				recive_data2[21-bits_cnt]<=sd_temp;
			else if (package_cnt == 3)
				recive_data3[21-bits_cnt]<=sd_temp;
			else if (package_cnt == 4)
				recive_data4[21-bits_cnt]<=sd_temp;
			else if (package_cnt == 5)
				recive_data5[21-bits_cnt]<=sd_temp;
			else if (package_cnt == 6)
				recive_data6[21-bits_cnt]<=sd_temp;
			else if (package_cnt == 7)
				recive_data7[21-bits_cnt]<=sd_temp;
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		bits_cnt<=0;
	else begin
		if(!sen)
			bits_cnt<=bits_cnt+1;
		else
			bits_cnt<=0;
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		RB2_RW<=1;
	else begin
		if(package_cnt == 8 && finish_cnt == 7)
			RB2_RW<=0;
		else if(package_cnt >= 1 && bits_cnt == 10)
			RB2_RW<=0;
		else
			RB2_RW<=1;
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		RB2_A<=0;
	else begin
			case(package_cnt)
				0: 	RB2_A <= 0;
				1:	RB2_A<=(bits_cnt >=10) ? recive_data0[20:18] : 0 ;
				2:	RB2_A<=(bits_cnt >=10) ? recive_data1[20:18] : 0 ;
				3:	RB2_A<=(bits_cnt >=10) ? recive_data2[20:18] : 0 ;
				4:	RB2_A<=(bits_cnt >=10) ? recive_data3[20:18] : 0 ;
				5:	RB2_A<=(bits_cnt >=10) ? recive_data4[20:18] : 0 ;
				6:	RB2_A<=(bits_cnt >=10) ? recive_data5[20:18] : 0 ;
				7:	RB2_A<=(bits_cnt >=10) ? recive_data6[20:18] : 0 ;
				8:	RB2_A<=recive_data7[20:18];
				default : RB2_A <= 0;
			endcase
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		RB2_D<=0;
	else begin
			case(package_cnt )
				0: 	RB2_D <= 1;
				1:	RB2_D<=(bits_cnt >=10) ? recive_data0[17:0] : 0 ;
				2:	RB2_D<=(bits_cnt >=10) ? recive_data1[17:0] : 0 ;
				3:	RB2_D<=(bits_cnt >=10) ? recive_data2[17:0] : 0 ;
				4:	RB2_D<=(bits_cnt >=10) ? recive_data3[17:0] : 0 ;
				5:	RB2_D<=(bits_cnt >=10) ? recive_data4[17:0] : 0 ;
				6:	RB2_D<=(bits_cnt >=10) ? recive_data5[17:0] : 0 ;
				7:	RB2_D<=(bits_cnt >=10) ? recive_data6[17:0] : 0 ;
				8:	RB2_D<=recive_data7[17:0];
				default : RB2_D <= 0;
			endcase
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		finish_cnt<=0;
	else begin
		if(!RB2_RW) begin
			finish_cnt <= finish_cnt+1;
		end
		else
			finish_cnt <=finish_cnt;
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		S2_done<=0;
	else begin
		if(finish_cnt == 9)
			S2_done<=1;
		else
			S2_done<=0;
	end
end
endmodule