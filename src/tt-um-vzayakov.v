`default_nettype none
module tt_um_vzayakov_top (
	ui_in,
	ui_out,
	uio_in,
	uio_out,
	uio_oe,
	ena
	clk,
	rst_n
);
	input wire [7:0] ui_in;
	output wire [7:0] ui_out;
	input wire [7:0] uio_in;
	output wire [7:0] uio_out;
	input wire ena;
	input wire clk;
	input wire rst_n;
	wire R_move_switch;
	wire R_up_switch;
	wire L_move_switch;
	wire L_up_switch;
	wire serve_L_button;
	wire VGA_BLANK_N;
	wire VGA_CLK;
	wire VGA_SYNC_N;
	wire VGA_VS;
	wire VGA_HS;
	wire VGA_R;
	wire VGA_G;
	wire VGA_B;
	wire [6:0] HEX0;
	wire [6:0] HEX1;
	wire [6:0] HEX2;
	wire [6:0] HEX3;
	wire [6:0] HEX4;
	wire [6:0] HEX5;
	wire [6:0] HEX6;
	wire [6:0] HEX7;
	wire blank;
	wire [8:0] row;
	wire [9:0] col;
	wire [3:0] L1;
	wire [3:0] L2;
	wire [3:0] L3;
	wire [3:0] L4;
	wire [3:0] R1;
	wire [3:0] R2;
	wire [3:0] R3;
	wire [3:0] R4;
	assign R_move_switch = ui_in[0];
	assign R_up_switch = ui_in[1];
	assign L_move_switch = ui_in[2];
	assign L_up_switch = ui_in[3];
	assign serve_L_button = ui_in[4];
	assign ui_out[0] = VGA_CLK;
	assign ui_out[1] = VGA_BLANK_N;
	assign ui_out[2] = VGA_SYNC_N;
	assign ui_out[3] = VGA_VS;
	assign ui_out[4] = VGA_HS;
	assign ui_out[5] = VGA_R;
	assign ui_out[6] = VGA_G;
	assign ui_out[7] = VGA_B;
	assign VGA_SYNC_N = 1'b0;
	assign VGA_BLANK_N = ~blank;
	assign VGA_CLK = ~clock;
	pong DUT(
		.serve_L_async(serve_L_button),
		.reset_L(rst_n),
		.CLOCK_50(clock),
		.R_move_async(R_move_switch),
		.R_up_async(R_up_switch),
		.L_move_async(L_move_switch),
		.L_up_async(L_up_switch),
		.VGA_R(VGA_R),
		.VGA_G(VGA_G),
		.VGA_B(VGA_B),
		.HS(VGA_HS),
		.VS(VGA_VS),
		.blank(blank),
		.HEX0(HEX0),
		.HEX1(HEX1),
		.HEX2(HEX2),
		.HEX3(HEX3),
		.HEX4(HEX4),
		.HEX5(HEX5),
		.HEX6(HEX6),
		.HEX7(HEX7),
		.L1(L1),
		.L2(L2),
		.L3(L3),
		.L4(L4),
		.R1(R1),
		.R2(R2),
		.R3(R3),
		.R4(R4)
	);
	SevenSegment SSL1(
		.BCDnumber(L1),
		.hexOutput_L(HEX4)
	);
	SevenSegment SSL2(
		.BCDnumber(L2),
		.hexOutput_L(HEX5)
	);
	SevenSegment SSL3(
		.BCDnumber(L3),
		.hexOutput_L(HEX6)
	);
	SevenSegment SSL4(
		.BCDnumber(L4),
		.hexOutput_L(HEX7)
	);
	SevenSegment SSR1(
		.BCDnumber(R1),
		.hexOutput_L(HEX0)
	);
	SevenSegment SSR2(
		.BCDnumber(R2),
		.hexOutput_L(HEX1)
	);
	SevenSegment SSR3(
		.BCDnumber(R3),
		.hexOutput_L(HEX2)
	);
	SevenSegment SSR4(
		.BCDnumber(R4),
		.hexOutput_L(HEX3)
	);
endmodule
module SevenSegment (
	BCDnumber,
	hexOutput_L
);
	input wire [3:0] BCDnumber;
	output reg [6:0] hexOutput_L;
	always @(*)
		case (BCDnumber)
			4'd0: hexOutput_L = 7'b1000000;
			4'd1: hexOutput_L = 7'b1111001;
			4'd2: hexOutput_L = 7'b0100100;
			4'd3: hexOutput_L = 7'b0110000;
			4'd4: hexOutput_L = 7'b0011001;
			4'd5: hexOutput_L = 7'b0010010;
			4'd6: hexOutput_L = 7'b0000011;
			4'd7: hexOutput_L = 7'b1111000;
			4'd8: hexOutput_L = 7'b0000000;
			4'd9: hexOutput_L = 7'b0011000;
			default: hexOutput_L = 7'b1111111;
		endcase
endmodule
module pong (
	serve_L_async,
	reset_L,
	CLOCK_50,
	R_move_async,
	R_up_async,
	L_move_async,
	L_up_async,
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	HEX6,
	HEX7,
	VGA_R,
	VGA_G,
	VGA_B,
	HS,
	VS,
	blank,
	L1,
	L2,
	L3,
	L4,
	R1,
	R2,
	R3,
	R4
);
	input wire serve_L_async;
	input wire reset_L;
	input wire CLOCK_50;
	input wire R_move_async;
	input wire R_up_async;
	input wire L_move_async;
	input wire L_up_async;
	input wire [6:0] HEX0;
	input wire [6:0] HEX1;
	input wire [6:0] HEX2;
	input wire [6:0] HEX3;
	input wire [6:0] HEX4;
	input wire [6:0] HEX5;
	input wire [6:0] HEX6;
	input wire [6:0] HEX7;
	output wire VGA_R;
	output wire VGA_G;
	output wire VGA_B;
	output wire HS;
	output wire VS;
	output wire blank;
	output wire [3:0] L1;
	output wire [3:0] L2;
	output wire [3:0] L3;
	output wire [3:0] L4;
	output wire [3:0] R1;
	output wire [3:0] R2;
	output wire [3:0] R3;
	output wire [3:0] R4;
	wire [8:0] row;
	wire [8:0] sum_left;
	wire [8:0] sum_right;
	wire [8:0] Q_BR;
	wire [8:0] LPad_row;
	wire [8:0] RPad_row;
	wire [9:0] col;
	wire [9:0] Q_BC;
	wire is_btwn_LPad;
	wire is_btwn_RPad;
	wire reset_paddle;
	wire reset_ballcol;
	wire reset_ballrow;
	wire preset_left;
	wire reset_left;
	wire preset_up;
	wire reset_up;
	wire clr_score;
	wire en_BR;
	wire en_BC;
	wire en_LPadR;
	wire en_RPadR;
	wire en_Lscore;
	wire en_Rscore;
	wire showScoreRight;
	wire showScoreLeft;
	wire LWin;
	wire RWin;
	reg D_left;
	wire VS_display_done;
	wire rightHit;
	wire leftHit;
	wire up;
	wire left;
	reg in_done;
	wire out_done;
	wire R_move;
	wire R_up;
	wire L_move;
	wire L_up;
	wire serve_L;
	wire isB_L1;
	wire isB_R1;
	wire isB_L2;
	wire isB_R2;
	wire isB_L3;
	wire isB_R3;
	wire isB_L4;
	wire isB_R4;
	vga vg(
		.reset(~reset_L),
		.CLOCK_50(CLOCK_50),
		.HS(HS),
		.VS(VS),
		.blank(blank),
		.row(row),
		.col(col)
	);
	Synchronizer sync1(
		.async(serve_L_async),
		.clock(CLOCK_50),
		.sync(serve_L)
	);
	Synchronizer sync2(
		.async(R_move_async),
		.clock(CLOCK_50),
		.sync(R_move)
	);
	Synchronizer sync3(
		.async(R_up_async),
		.clock(CLOCK_50),
		.sync(R_up)
	);
	Synchronizer sync4(
		.async(L_move_async),
		.clock(CLOCK_50),
		.sync(L_move)
	);
	Synchronizer sync5(
		.async(L_up_async),
		.clock(CLOCK_50),
		.sync(L_up)
	);
	pong_fsm pfsm(
		.serve_L(serve_L),
		.reset_L(reset_L),
		.LWin(LWin),
		.RWin(RWin),
		.CLOCK_50(CLOCK_50),
		.VS_display_done(VS_display_done),
		.reset_paddle(reset_paddle),
		.reset_ballcol(reset_ballcol),
		.reset_ballrow(reset_ballrow),
		.preset_left(preset_left),
		.preset_up(preset_up),
		.reset_left(reset_left),
		.reset_up(reset_up),
		.clr_score(clr_score),
		.en_BR(en_BR),
		.en_BC(en_BC),
		.en_LPadR(en_LPadR),
		.en_RPadR(en_RPadR),
		.en_Lscore(en_Lscore),
		.en_Rscore(en_Rscore),
		.showScoreRight(showScoreRight),
		.showScoreLeft(showScoreLeft)
	);
	Ball b(
		.clock(CLOCK_50),
		.reset_ballrow(reset_ballrow),
		.reset_ballcol(reset_ballcol),
		.reset_left(reset_left),
		.preset_left(preset_left),
		.reset_up(reset_up),
		.en_BR(en_BR),
		.en_BC(en_BC),
		.D_left(D_left),
		.leftHit(leftHit),
		.rightHit(rightHit),
		.RWin(RWin),
		.LWin(LWin),
		.Q_BC(Q_BC),
		.Q_BR(Q_BR),
		.up(up),
		.left(left)
	);
	Paddle leftPaddle(
		.en_P(en_LPadR),
		.move(L_move),
		.clock(CLOCK_50),
		.reset_paddle(reset_paddle),
		.up(L_up),
		.Q_P(LPad_row)
	);
	Paddle rightPaddle(
		.en_P(en_RPadR),
		.move(R_move),
		.clock(CLOCK_50),
		.reset_paddle(reset_paddle),
		.up(R_up),
		.Q_P(RPad_row)
	);
	Color c(
		.VGA_row(row),
		.VGA_col(col),
		.Q_BR(Q_BR),
		.Q_BC(Q_BC),
		.Q_LP(LPad_row),
		.Q_RP(RPad_row),
		.VGA_R(VGA_R),
		.VGA_G(VGA_G),
		.VGA_B(VGA_B),
		.showScoreRight(showScoreRight),
		.showScoreLeft(showScoreLeft),
		.isB_L1(isB_L1),
		.isB_R1(isB_R1),
		.isB_L2(isB_L2),
		.isB_R2(isB_R2),
		.isB_L3(isB_L3),
		.isB_R3(isB_R3),
		.isB_L4(isB_L4),
		.isB_R4(isB_R4)
	);
	Scoring s(
		.en_Rscore(en_Rscore),
		.en_Lscore(en_Lscore),
		.clr_score(clr_score),
		.CLOCK_50(CLOCK_50),
		.L1(L1),
		.L2(L2),
		.L3(L3),
		.L4(L4),
		.R1(R1),
		.R2(R2),
		.R3(R3),
		.R4(R4)
	);
	ScoreOnDisplay scoreL1(
		.rowChoice(9'd64),
		.colChoice(10'd200),
		.curr_row(row),
		.curr_col(col),
		.hexOutput_L(HEX4),
		.is_between(isB_L1)
	);
	ScoreOnDisplay scoreR1(
		.rowChoice(9'd64),
		.colChoice(10'd540),
		.curr_row(row),
		.curr_col(col),
		.hexOutput_L(HEX0),
		.is_between(isB_R1)
	);
	ScoreOnDisplay scoreL2(
		.rowChoice(9'd64),
		.colChoice(10'd160),
		.curr_row(row),
		.curr_col(col),
		.hexOutput_L(HEX5),
		.is_between(isB_L2)
	);
	ScoreOnDisplay scoreR2(
		.rowChoice(9'd64),
		.colChoice(10'd500),
		.curr_row(row),
		.curr_col(col),
		.hexOutput_L(HEX1),
		.is_between(isB_R2)
	);
	ScoreOnDisplay scoreL3(
		.rowChoice(9'd64),
		.colChoice(10'd120),
		.curr_row(row),
		.curr_col(col),
		.hexOutput_L(HEX6),
		.is_between(isB_L3)
	);
	ScoreOnDisplay scoreR3(
		.rowChoice(9'd64),
		.colChoice(10'd460),
		.curr_row(row),
		.curr_col(col),
		.hexOutput_L(HEX2),
		.is_between(isB_R3)
	);
	ScoreOnDisplay scoreL4(
		.rowChoice(9'd64),
		.colChoice(10'd80),
		.curr_row(row),
		.curr_col(col),
		.hexOutput_L(HEX7),
		.is_between(isB_L4)
	);
	ScoreOnDisplay scoreR4(
		.rowChoice(9'd64),
		.colChoice(10'd420),
		.curr_row(row),
		.curr_col(col),
		.hexOutput_L(HEX3),
		.is_between(isB_R4)
	);
	DFlipFlop doneff(
		.D(in_done),
		.Q(out_done),
		.clock(CLOCK_50),
		.preset_L(),
		.reset_L()
	);
	always @(*)
		if (VS_display_done)
			in_done = 1'b1;
		else
			in_done = 1'b0;
	assign VS_display_done = (((row == 9'd479) && (col == 10'd639)) && ~out_done ? 1'b1 : 1'b0);
	Adder #(.WIDTH(9)) addL(
		.A(Q_BR),
		.B(9'd3),
		.Cin(1'b0),
		.Sum(sum_left),
		.Cout()
	);
	Adder #(.WIDTH(9)) addR(
		.A(Q_BR),
		.B(9'd3),
		.Cin(1'b0),
		.Sum(sum_right),
		.Cout()
	);
	OffsetCheck #(.WIDTH(9)) oc_left(
		.low(LPad_row),
		.delta(9'd51),
		.val(sum_left),
		.is_between(is_btwn_LPad)
	);
	OffsetCheck #(.WIDTH(9)) oc_right(
		.low(RPad_row),
		.delta(9'd51),
		.val(sum_right),
		.is_between(is_btwn_RPad)
	);
	always @(*)
		if ((is_btwn_RPad && rightHit) && VS_display_done)
			D_left = 1'b1;
		else if ((is_btwn_LPad && leftHit) && VS_display_done)
			D_left = 1'b0;
		else
			D_left = left;
endmodule
module pong_fsm (
	serve_L,
	reset_L,
	LWin,
	RWin,
	CLOCK_50,
	VS_display_done,
	reset_paddle,
	reset_ballcol,
	reset_ballrow,
	preset_left,
	preset_up,
	reset_left,
	reset_up,
	clr_score,
	en_BR,
	en_BC,
	en_LPadR,
	en_RPadR,
	en_Lscore,
	en_Rscore,
	showScoreRight,
	showScoreLeft
);
	input wire serve_L;
	input wire reset_L;
	input wire LWin;
	input wire RWin;
	input wire CLOCK_50;
	input wire VS_display_done;
	output reg reset_paddle;
	output reg reset_ballcol;
	output reg reset_ballrow;
	output reg preset_left;
	output reg preset_up;
	output reg reset_left;
	output reg reset_up;
	output reg clr_score;
	output reg en_BR;
	output reg en_BC;
	output reg en_LPadR;
	output reg en_RPadR;
	output reg en_Lscore;
	output reg en_Rscore;
	output reg showScoreRight;
	output reg showScoreLeft;
	wire [3:0] currState;
	reg [3:0] nextState;
	DFlipFlop dff0(
		.D(nextState[0]),
		.Q(currState[0]),
		.clock(CLOCK_50),
		.reset_L(reset_L),
		.preset_L(1'b1)
	);
	DFlipFlop dff1(
		.D(nextState[1]),
		.Q(currState[1]),
		.clock(CLOCK_50),
		.reset_L(reset_L),
		.preset_L(1'b1)
	);
	DFlipFlop dff2(
		.D(nextState[2]),
		.Q(currState[2]),
		.clock(CLOCK_50),
		.reset_L(reset_L),
		.preset_L(1'b1)
	);
	DFlipFlop dff3(
		.D(nextState[3]),
		.Q(currState[3]),
		.clock(CLOCK_50),
		.reset_L(reset_L),
		.preset_L(1'b1)
	);
	always @(*) begin
		reset_paddle = 1'b0;
		reset_ballcol = 1'b0;
		reset_ballrow = 1'b0;
		preset_left = 1'b0;
		preset_up = 1'b0;
		reset_left = 1'b0;
		reset_up = 1'b0;
		clr_score = 1'b0;
		en_BR = 1'b0;
		en_BC = 1'b0;
		en_LPadR = 1'b0;
		en_RPadR = 1'b0;
		en_Lscore = 1'b0;
		en_Rscore = 1'b0;
		showScoreLeft = 1'b0;
		showScoreRight = 1'b0;
		case (currState)
			4'b0000: begin
				nextState = 4'b0001;
				reset_up = 1'b1;
				reset_left = 1'b1;
				reset_paddle = 1'b1;
				reset_ballcol = 1'b1;
				reset_ballrow = 1'b1;
				clr_score = 1'b1;
				en_BR = 1'b1;
				en_BC = 1'b1;
				en_LPadR = 1'b1;
				en_RPadR = 1'b1;
			end
			4'b0001:
				if (~serve_L && VS_display_done)
					nextState = 4'b0011;
				else
					nextState = 4'b0001;
			4'b0010: begin
				nextState = 4'b0100;
				preset_left = 1'b1;
				reset_up = 1'b1;
				en_BR = 1'b1;
				en_BC = 1'b1;
				en_LPadR = 1'b1;
				en_RPadR = 1'b1;
			end
			4'b0011: begin
				nextState = 4'b0100;
				reset_left = 1'b1;
				reset_up = 1'b1;
				en_BR = 1'b1;
				en_BC = 1'b1;
				en_LPadR = 1'b1;
				en_RPadR = 1'b1;
			end
			4'b0100:
				if (LWin && VS_display_done)
					nextState = 4'b0101;
				else if (RWin && VS_display_done)
					nextState = 4'b0110;
				else if (VS_display_done)
					nextState = 4'b1001;
				else
					nextState = 4'b0100;
			4'b1001: begin
				nextState = 4'b0100;
				en_BR = 1'b1;
				en_BC = 1'b1;
				en_LPadR = 1'b1;
				en_RPadR = 1'b1;
			end
			4'b0101: begin
				nextState = 4'b0111;
				reset_up = 1'b1;
				reset_paddle = 1'b1;
				reset_ballcol = 1'b1;
				reset_ballrow = 1'b1;
				en_BR = 1'b1;
				en_BC = 1'b1;
				en_Lscore = 1'b1;
				en_LPadR = 1'b1;
				en_RPadR = 1'b1;
			end
			4'b0110: begin
				nextState = 4'b1000;
				reset_up = 1'b1;
				reset_paddle = 1'b1;
				reset_ballcol = 1'b1;
				reset_ballrow = 1'b1;
				en_BR = 1'b1;
				en_BC = 1'b1;
				en_Rscore = 1'b1;
				en_LPadR = 1'b1;
				en_RPadR = 1'b1;
			end
			4'b0111: begin
				if (~serve_L && VS_display_done)
					nextState = 4'b0011;
				else
					nextState = 4'b0111;
				showScoreLeft = 1'b1;
			end
			4'b1000: begin
				if (~serve_L && VS_display_done)
					nextState = 4'b0010;
				else
					nextState = 4'b1000;
				showScoreRight = 1'b1;
			end
		endcase
	end
endmodule
module Ball (
	clock,
	reset_ballrow,
	reset_ballcol,
	reset_left,
	preset_left,
	reset_up,
	en_BR,
	en_BC,
	D_left,
	leftHit,
	rightHit,
	RWin,
	LWin,
	Q_BC,
	Q_BR,
	up,
	left
);
	input wire clock;
	input wire reset_ballrow;
	input wire reset_ballcol;
	input wire reset_left;
	input wire preset_left;
	input wire reset_up;
	input wire en_BR;
	input wire en_BC;
	input wire D_left;
	output wire leftHit;
	output wire rightHit;
	output wire RWin;
	output wire LWin;
	output wire [9:0] Q_BC;
	output wire [8:0] Q_BR;
	output wire up;
	output wire left;
	wire cout1;
	wire cout2;
	wire ballTop;
	wire ballBottom;
	wire [9:0] addLeftIn;
	wire [9:0] D_BC;
	wire [8:0] D_BR;
	wire [8:0] addUpIn;
	wire Q_up;
	wire Q_left;
	reg D_up;
	wire [8:0] resetBallRow;
	wire [9:0] resetBallCol;
	Register #(.WIDTH(9)) BallRow(
		.en(en_BR),
		.clear(1'b0),
		.D(D_BR),
		.Q(Q_BR),
		.clock(clock)
	);
	Register #(.WIDTH(10)) BallCol(
		.en(en_BC),
		.clear(1'b0),
		.D(D_BC),
		.Q(Q_BC),
		.clock(clock)
	);
	Mux2to1 #(.WIDTH(9)) MuxUp(
		.I0(9'd1),
		.I1(9'b111111111),
		.S(Q_up),
		.Y(addUpIn)
	);
	Mux2to1 #(.WIDTH(10)) MuxLeft(
		.I0(10'd2),
		.I1(10'b1111111110),
		.S(Q_left),
		.Y(addLeftIn)
	);
	Adder #(.WIDTH(9)) RowAdd(
		.Cin(1'b0),
		.Cout(cout1),
		.A(addUpIn),
		.B(Q_BR),
		.Sum(resetBallRow)
	);
	Adder #(.WIDTH(10)) ColAdd(
		.Cin(1'b0),
		.Cout(cout2),
		.A(addLeftIn),
		.B(Q_BC),
		.Sum(resetBallCol)
	);
	Mux2to1 #(.WIDTH(9)) ResetRow(
		.I0(resetBallRow),
		.I1(9'd238),
		.S(reset_ballrow),
		.Y(D_BR)
	);
	Mux2to1 #(.WIDTH(10)) ResetCol(
		.I0(resetBallCol),
		.I1(10'd318),
		.S(reset_ballcol),
		.Y(D_BC)
	);
	MagComp #(.WIDTH(9)) mc1(
		.A(Q_BR),
		.B(9'd0),
		.AltB(),
		.AgtB(),
		.AeqB(ballTop)
	);
	MagComp #(.WIDTH(9)) mc2(
		.A(Q_BR),
		.B(9'd476),
		.AltB(),
		.AgtB(),
		.AeqB(ballBottom)
	);
	MagComp #(.WIDTH(10)) mc3(
		.A(Q_BC),
		.B(10'd64),
		.AltB(),
		.AgtB(),
		.AeqB(leftHit)
	);
	MagComp #(.WIDTH(10)) mc4(
		.A(Q_BC),
		.B(10'd572),
		.AltB(),
		.AgtB(),
		.AeqB(rightHit)
	);
	MagComp #(.WIDTH(10)) mc5(
		.A(Q_BC),
		.B(10'd0),
		.AltB(),
		.AgtB(),
		.AeqB(RWin)
	);
	MagComp #(.WIDTH(10)) mc6(
		.A(Q_BC),
		.B(10'd636),
		.AltB(),
		.AgtB(),
		.AeqB(LWin)
	);
	DFlipFlop leftff(
		.D(D_left),
		.preset_L(~preset_left),
		.reset_L(~reset_left),
		.clock(clock),
		.Q(Q_left)
	);
	DFlipFlop upff(
		.D(D_up),
		.preset_L(1'b1),
		.reset_L(~reset_up),
		.clock(clock),
		.Q(Q_up)
	);
	assign up = Q_up;
	assign left = Q_left;
	always @(*)
		if (ballTop)
			D_up = 1'b0;
		else if (ballBottom)
			D_up = 1'b1;
		else
			D_up = Q_up;
endmodule
module Paddle (
	en_P,
	move,
	clock,
	reset_paddle,
	up,
	Q_P
);
	input wire en_P;
	input wire move;
	input wire clock;
	input wire reset_paddle;
	input wire up;
	output wire [8:0] Q_P;
	wire cout;
	wire bounds0lt;
	wire bounds1gt;
	reg [8:0] AddIn;
	wire [8:0] D_P;
	wire [8:0] M_P;
	Register #(.WIDTH(9)) PaddleRow(
		.en(en_P),
		.clear(1'b0),
		.D(D_P),
		.Q(Q_P),
		.clock(clock)
	);
	Adder #(.WIDTH(9)) PaddleRowAdd(
		.A(AddIn),
		.B(Q_P),
		.Cin(1'b0),
		.Sum(M_P),
		.Cout(cout)
	);
	Mux2to1 #(.WIDTH(9)) resetPaddle(
		.I0(M_P),
		.I1(9'd215),
		.S(reset_paddle),
		.Y(D_P)
	);
	MagComp #(.WIDTH(9)) bounds0(
		.A(Q_P),
		.B(9'd5),
		.AltB(bounds0lt),
		.AgtB(),
		.AeqB()
	);
	MagComp #(.WIDTH(9)) bounds1(
		.A(Q_P),
		.B(9'd426),
		.AltB(),
		.AgtB(bounds1gt),
		.AeqB()
	);
	always @(*)
		if (bounds0lt & up)
			case (Q_P)
				9'd4: AddIn = 9'b111111100;
				9'd3: AddIn = 9'b111111101;
				9'd2: AddIn = 9'b111111110;
				9'd1: AddIn = 9'b111111111;
				default: AddIn = 9'd0;
			endcase
		else if (bounds1gt & ~up)
			case (Q_P)
				9'd427: AddIn = 9'd4;
				9'd428: AddIn = 9'd3;
				9'd429: AddIn = 9'd2;
				9'd430: AddIn = 9'd1;
				default: AddIn = 9'd0;
			endcase
		else if (move & ~up)
			AddIn = 9'd5;
		else if (move & up)
			AddIn = 9'b111111011;
		else
			AddIn = 9'd0;
endmodule
module Color (
	VGA_row,
	VGA_col,
	Q_BC,
	Q_BR,
	Q_LP,
	Q_RP,
	showScoreLeft,
	showScoreRight,
	isB_L1,
	isB_R1,
	isB_L2,
	isB_R2,
	isB_L3,
	isB_R3,
	isB_L4,
	isB_R4,
	VGA_R,
	VGA_G,
	VGA_B
);
	input wire [8:0] VGA_row;
	input wire [9:0] VGA_col;
	input wire [9:0] Q_BC;
	input wire [8:0] Q_BR;
	input wire [8:0] Q_LP;
	input wire [8:0] Q_RP;
	input wire showScoreLeft;
	input wire showScoreRight;
	input wire isB_L1;
	input wire isB_R1;
	input wire isB_L2;
	input wire isB_R2;
	input wire isB_L3;
	input wire isB_R3;
	input wire isB_L4;
	input wire isB_R4;
	output reg VGA_R;
	output reg VGA_G;
	output reg VGA_B;
	wire BR_isB;
	wire BC_isB;
	wire LPR_isB;
	wire LPC_isB;
	wire RPR_isB;
	wire RPC_isB;
	wire rowBound;
	wire rowBound1;
	wire colBound;
	wire colBound1;
	wire RSC_isB;
	wire LSC_isB;
	wire SR_isB;
	wire showScore;
	assign showScore = showScoreLeft | showScoreRight;
	OffsetCheck #(.WIDTH(9)) BallRow(
		.low(Q_BR),
		.delta(9'd3),
		.val(VGA_row),
		.is_between(BR_isB)
	);
	OffsetCheck #(.WIDTH(10)) BallCol(
		.low(Q_BC),
		.delta(10'd3),
		.val(VGA_col),
		.is_between(BC_isB)
	);
	OffsetCheck #(.WIDTH(9)) LPaddleRow(
		.low(Q_LP),
		.delta(9'd47),
		.val(VGA_row),
		.is_between(LPR_isB)
	);
	OffsetCheck #(.WIDTH(10)) LPaddleCol(
		.low(10'd60),
		.delta(10'd3),
		.val(VGA_col),
		.is_between(LPC_isB)
	);
	OffsetCheck #(.WIDTH(9)) RPaddleRow(
		.low(Q_RP),
		.delta(9'd47),
		.val(VGA_row),
		.is_between(RPR_isB)
	);
	OffsetCheck #(.WIDTH(10)) RPaddleCol(
		.low(10'd577),
		.delta(10'd3),
		.val(VGA_col),
		.is_between(RPC_isB)
	);
	RangeCheck #(.WIDTH(10)) rightScoreCol(
		.low(10'd470),
		.high(10'd490),
		.val(VGA_col),
		.is_between(RSC_isB)
	);
	RangeCheck #(.WIDTH(10)) leftScoreCol(
		.low(10'd150),
		.high(10'd170),
		.val(VGA_col),
		.is_between(LSC_isB)
	);
	RangeCheck #(.WIDTH(9)) ScoreRow(
		.low(9'd230),
		.high(9'd250),
		.val(VGA_row),
		.is_between(SR_isB)
	);
	MagComp #(.WIDTH(9)) RowBoundary(
		.A(9'd0),
		.B(VGA_row),
		.AeqB(rowBound),
		.AltB(),
		.AgtB()
	);
	MagComp #(.WIDTH(9)) RowBoundary1(
		.A(9'd479),
		.B(VGA_row),
		.AeqB(rowBound1),
		.AltB(),
		.AgtB()
	);
	MagComp #(.WIDTH(10)) ColBoundary(
		.A(10'd0),
		.B(VGA_col),
		.AeqB(colBound),
		.AltB(),
		.AgtB()
	);
	MagComp #(.WIDTH(10)) ColBoundary1(
		.A(10'd639),
		.B(VGA_col),
		.AeqB(colBound1),
		.AltB(),
		.AgtB()
	);
	always @(*)
		if (BR_isB & BC_isB) begin
			VGA_R = 1'b1;
			VGA_G = 1'b1;
			VGA_B = 1'b1;
		end
		else if (LPR_isB & LPC_isB) begin
			VGA_R = 1'b1;
			VGA_G = 1'b1;
			VGA_B = 1'b0;
		end
		else if (RPR_isB & RPC_isB) begin
			VGA_R = 1'b0;
			VGA_G = 1'b1;
			VGA_B = 1'b1;
		end
		else if (((rowBound | rowBound1) | colBound) | colBound1) begin
			VGA_R = 1'b1;
			VGA_G = 1'b0;
			VGA_B = 1'b0;
		end
		else if ((RSC_isB & SR_isB) & showScoreRight) begin
			VGA_R = 1'b0;
			VGA_G = 1'b1;
			VGA_B = 1'b0;
		end
		else if ((LSC_isB & SR_isB) & showScoreLeft) begin
			VGA_R = 1'b0;
			VGA_G = 1'b1;
			VGA_B = 1'b0;
		end
		else if ((isB_L1 | isB_R1) & showScore) begin
			VGA_R = 1'b1;
			VGA_G = 1'b0;
			VGA_B = 1'b1;
		end
		else if ((isB_L2 | isB_R2) & showScore) begin
			VGA_R = 1'b0;
			VGA_G = 1'b0;
			VGA_B = 1'b1;
		end
		else if ((isB_L3 | isB_R3) & showScore) begin
			VGA_R = 1'b0;
			VGA_G = 1'b1;
			VGA_B = 1'b0;
		end
		else if ((isB_L4 | isB_R4) & showScore) begin
			VGA_R = 1'b1;
			VGA_G = 1'b1;
			VGA_B = 1'b0;
		end
		else begin
			VGA_R = 1'b0;
			VGA_G = 1'b0;
			VGA_B = 1'b0;
		end
endmodule
module Scoring (
	en_Rscore,
	en_Lscore,
	clr_score,
	CLOCK_50,
	L1,
	L2,
	L3,
	L4,
	R1,
	R2,
	R3,
	R4
);
	input wire en_Rscore;
	input wire en_Lscore;
	input wire clr_score;
	input wire CLOCK_50;
	output wire [3:0] L1;
	output wire [3:0] L2;
	output wire [3:0] L3;
	output wire [3:0] L4;
	output wire [3:0] R1;
	output wire [3:0] R2;
	output wire [3:0] R3;
	output wire [3:0] R4;
	wire L1_gt9;
	wire L2_gt9;
	wire L3_gt9;
	wire L4_gt9;
	wire R1_gt9;
	wire R2_gt9;
	wire R3_gt9;
	wire R4_gt9;
	wire clr_L1;
	wire clr_L2;
	wire clr_L3;
	wire clr_L4;
	wire clr_R1;
	wire clr_R2;
	wire clr_R3;
	wire clr_R4;
	MagComp #(.WIDTH(4)) L1gt9(
		.A(L1),
		.B(4'd9),
		.AgtB(L1_gt9),
		.AeqB(),
		.AltB()
	);
	MagComp #(.WIDTH(4)) L2gt9(
		.A(L2),
		.B(4'd9),
		.AgtB(L2_gt9),
		.AeqB(),
		.AltB()
	);
	MagComp #(.WIDTH(4)) L3gt9(
		.A(L3),
		.B(4'd9),
		.AgtB(L3_gt9),
		.AeqB(),
		.AltB()
	);
	MagComp #(.WIDTH(4)) L4gt9(
		.A(L4),
		.B(4'd9),
		.AgtB(L4_gt9),
		.AeqB(),
		.AltB()
	);
	MagComp #(.WIDTH(4)) R1gt9(
		.A(R1),
		.B(4'd9),
		.AgtB(R1_gt9),
		.AeqB(),
		.AltB()
	);
	MagComp #(.WIDTH(4)) R2gt9(
		.A(R2),
		.B(4'd9),
		.AgtB(R2_gt9),
		.AeqB(),
		.AltB()
	);
	MagComp #(.WIDTH(4)) R3gt9(
		.A(R3),
		.B(4'd9),
		.AgtB(R3_gt9),
		.AeqB(),
		.AltB()
	);
	MagComp #(.WIDTH(4)) R4gt9(
		.A(R4),
		.B(4'd9),
		.AgtB(R4_gt9),
		.AeqB(),
		.AltB()
	);
	assign clr_L1 = L1_gt9 | clr_score;
	assign clr_L2 = L2_gt9 | clr_score;
	assign clr_L3 = L3_gt9 | clr_score;
	assign clr_L4 = L4_gt9 | clr_score;
	assign clr_R1 = R1_gt9 | clr_score;
	assign clr_R2 = R2_gt9 | clr_score;
	assign clr_R3 = R3_gt9 | clr_score;
	assign clr_R4 = R4_gt9 | clr_score;
	Counter #(.WIDTH(4)) LScore1(
		.en(en_Lscore),
		.clear(clr_L1),
		.load(1'b0),
		.up(1'b1),
		.clock(CLOCK_50),
		.D(4'b0000),
		.Q(L1)
	);
	Counter #(.WIDTH(4)) LScore2(
		.en(L1_gt9),
		.clear(clr_L2),
		.load(1'b0),
		.up(1'b1),
		.clock(CLOCK_50),
		.D(4'b0000),
		.Q(L2)
	);
	Counter #(.WIDTH(4)) LScore3(
		.en(L2_gt9),
		.clear(clr_L3),
		.load(1'b0),
		.up(1'b1),
		.clock(CLOCK_50),
		.D(4'b0000),
		.Q(L3)
	);
	Counter #(.WIDTH(4)) LScore4(
		.en(L3_gt9),
		.clear(clr_L4),
		.load(1'b0),
		.up(1'b1),
		.clock(CLOCK_50),
		.D(4'b0000),
		.Q(L4)
	);
	Counter #(.WIDTH(4)) RScore1(
		.en(en_Rscore),
		.clear(clr_R1),
		.load(1'b0),
		.up(1'b1),
		.clock(CLOCK_50),
		.D(4'b0000),
		.Q(R1)
	);
	Counter #(.WIDTH(4)) RScore2(
		.en(R1_gt9),
		.clear(clr_R2),
		.load(1'b0),
		.up(1'b1),
		.clock(CLOCK_50),
		.D(4'b0000),
		.Q(R2)
	);
	Counter #(.WIDTH(4)) RScore3(
		.en(R2_gt9),
		.clear(clr_R3),
		.load(1'b0),
		.up(1'b1),
		.clock(CLOCK_50),
		.D(4'b0000),
		.Q(R3)
	);
	Counter #(.WIDTH(4)) RScore4(
		.en(R3_gt9),
		.clear(clr_R4),
		.load(1'b0),
		.up(1'b1),
		.clock(CLOCK_50),
		.D(4'b0000),
		.Q(R4)
	);
endmodule
module ScoreOnDisplay (
	rowChoice,
	curr_row,
	colChoice,
	curr_col,
	hexOutput_L,
	is_between
);
	input wire [8:0] rowChoice;
	input wire [8:0] curr_row;
	input wire [9:0] colChoice;
	input wire [9:0] curr_col;
	input wire [6:0] hexOutput_L;
	output wire is_between;
	wire [9:0] a1_out;
	wire [8:0] a2_out;
	wire [8:0] a3_out;
	wire isB_Arow;
	wire isB_Acol;
	wire isB_Brow;
	wire isB_Bcol;
	wire isB_Crow;
	wire isB_Ccol;
	wire isB_Drow;
	wire isB_Dcol;
	wire isB_Erow;
	wire isB_Ecol;
	wire isB_Frow;
	wire isB_Fcol;
	wire isB_Grow;
	wire isB_Gcol;
	wire isA;
	wire isB;
	wire isC;
	wire isD;
	wire isE;
	wire isF;
	wire isG;
	assign isA = (isB_Arow & isB_Acol) & ~hexOutput_L[0];
	assign isB = (isB_Brow & isB_Bcol) & ~hexOutput_L[1];
	assign isC = (isB_Crow & isB_Ccol) & ~hexOutput_L[2];
	assign isD = (isB_Drow & isB_Dcol) & ~hexOutput_L[3];
	assign isE = (isB_Erow & isB_Ecol) & ~hexOutput_L[4];
	assign isF = (isB_Frow & isB_Fcol) & ~hexOutput_L[5];
	assign isG = (isB_Grow & isB_Gcol) & ~hexOutput_L[6];
	assign is_between = (((((isA | isB) | isC) | isD) | isE) | isF) | isG;
	Adder #(.WIDTH(10)) a1(
		.A(colChoice),
		.B(10'd20),
		.Sum(a1_out),
		.Cout(),
		.Cin(1'b0)
	);
	Adder #(.WIDTH(9)) a2(
		.A(rowChoice),
		.B(9'd20),
		.Sum(a2_out),
		.Cout(),
		.Cin(1'b0)
	);
	Adder #(.WIDTH(9)) a3(
		.A(rowChoice),
		.B(9'd40),
		.Sum(a3_out),
		.Cout(),
		.Cin(1'b0)
	);
	OffsetCheck #(.WIDTH(9)) A_row(
		.low(rowChoice),
		.delta(9'd2),
		.val(curr_row),
		.is_between(isB_Arow)
	);
	OffsetCheck #(.WIDTH(10)) A_col(
		.low(colChoice),
		.delta(10'd20),
		.val(curr_col),
		.is_between(isB_Acol)
	);
	OffsetCheck #(.WIDTH(9)) B_row(
		.low(rowChoice),
		.delta(9'd20),
		.val(curr_row),
		.is_between(isB_Brow)
	);
	OffsetCheck #(.WIDTH(10)) B_col(
		.low(a1_out),
		.delta(10'd2),
		.val(curr_col),
		.is_between(isB_Bcol)
	);
	OffsetCheck #(.WIDTH(9)) C_row(
		.low(rowChoice + 9'd20),
		.delta(9'd20),
		.val(curr_row),
		.is_between(isB_Crow)
	);
	OffsetCheck #(.WIDTH(10)) C_col(
		.low(a1_out),
		.delta(10'd2),
		.val(curr_col),
		.is_between(isB_Ccol)
	);
	OffsetCheck #(.WIDTH(9)) D_row(
		.low(a3_out),
		.delta(9'd2),
		.val(curr_row),
		.is_between(isB_Drow)
	);
	OffsetCheck #(.WIDTH(10)) D_col(
		.low(colChoice),
		.delta(10'd20),
		.val(curr_col),
		.is_between(isB_Dcol)
	);
	OffsetCheck #(.WIDTH(9)) E_row(
		.low(a2_out),
		.delta(9'd20),
		.val(curr_row),
		.is_between(isB_Erow)
	);
	OffsetCheck #(.WIDTH(10)) E_col(
		.low(colChoice),
		.delta(10'd2),
		.val(curr_col),
		.is_between(isB_Ecol)
	);
	OffsetCheck #(.WIDTH(9)) F_row(
		.low(rowChoice),
		.delta(9'd20),
		.val(curr_row),
		.is_between(isB_Frow)
	);
	OffsetCheck #(.WIDTH(10)) F_col(
		.low(colChoice),
		.delta(10'd2),
		.val(curr_col),
		.is_between(isB_Fcol)
	);
	OffsetCheck #(.WIDTH(9)) G_row(
		.low(a2_out),
		.delta(9'd2),
		.val(curr_row),
		.is_between(isB_Grow)
	);
	OffsetCheck #(.WIDTH(10)) G_col(
		.low(colChoice),
		.delta(10'd20),
		.val(curr_col),
		.is_between(isB_Gcol)
	);
endmodule
module vga (
	CLOCK_50,
	reset,
	HS,
	VS,
	blank,
	row,
	col
);
	input wire CLOCK_50;
	input wire reset;
	output wire HS;
	output wire VS;
	output wire blank;
	output wire [8:0] row;
	output wire [9:0] col;
	reg en_vs;
	wire en_hs;
	wire en_row;
	wire en_col;
	reg clear_vs;
	wire clear_hs;
	reg clear_row;
	wire clear_col;
	wire [19:0] Q_VS;
	reg [19:0] D_VS;
	wire [10:0] Q_HS;
	reg [10:0] D_HS;
	wire [8:0] Q_row;
	wire [8:0] D_row;
	wire [9:0] Q_col;
	wire [9:0] D_col;
	reg load_vs;
	reg load_hs;
	wire load_row;
	wire load_col;
	wire VS_done;
	wire HS_done;
	wire isB_vp;
	wire isB_vd;
	wire isB_hp;
	wire isB_hd;
	MagComp #(.WIDTH(20)) vs_done(
		.A(Q_VS),
		.B(20'd833599),
		.AeqB(VS_done),
		.AgtB(),
		.AltB()
	);
	MagComp #(.WIDTH(11)) hs_done(
		.A(Q_HS),
		.B(11'd1599),
		.AeqB(HS_done),
		.AgtB(),
		.AltB()
	);
	Counter #(.WIDTH(20)) VSCounter(
		.en(en_vs),
		.clear(clear_vs),
		.load(load_vs),
		.up(1'b1),
		.clock(CLOCK_50),
		.D(D_VS),
		.Q(Q_VS)
	);
	Counter #(.WIDTH(11)) HSCounter(
		.en(en_hs),
		.clear(clear_hs),
		.load(load_hs),
		.up(1'b1),
		.clock(CLOCK_50),
		.D(D_HS),
		.Q(Q_HS)
	);
	Counter #(.WIDTH(9)) RowCounter(
		.en(en_row),
		.clear(clear_row),
		.load(load_row),
		.up(1'b1),
		.clock(CLOCK_50),
		.D(D_row),
		.Q(Q_row)
	);
	Counter #(.WIDTH(10)) ColCounter(
		.en(en_col),
		.clear(clear_col),
		.load(load_col),
		.up(1'b1),
		.clock(CLOCK_50),
		.D(D_col),
		.Q(Q_col)
	);
	RangeCheck #(.WIDTH(20)) VS_pulse(
		.val(Q_VS),
		.high(20'd3199),
		.low(20'd0),
		.is_between(isB_vp)
	);
	RangeCheck #(.WIDTH(20)) VS_display(
		.val(Q_VS),
		.high(20'd817599),
		.low(20'd49600),
		.is_between(isB_vd)
	);
	RangeCheck #(.WIDTH(11)) HS_pulse(
		.val(Q_HS),
		.high(11'd191),
		.low(11'd0),
		.is_between(isB_hp)
	);
	RangeCheck #(.WIDTH(11)) HS_display(
		.val(Q_HS),
		.high(11'd1567),
		.low(11'd288),
		.is_between(isB_hd)
	);
	wire [1:0] currState;
	reg [1:0] nextState;
	DFlipFlop dff0(
		.D(nextState[0]),
		.Q(currState[0]),
		.clock(CLOCK_50),
		.reset_L(~reset),
		.preset_L(1'b1)
	);
	DFlipFlop dff1(
		.D(nextState[1]),
		.Q(currState[1]),
		.clock(CLOCK_50),
		.reset_L(~reset),
		.preset_L(1'b1)
	);
	assign en_col = ~Q_HS[0] & isB_hd;
	assign en_row = HS_done & isB_vd;
	assign en_hs = ~HS_done;
	assign clear_hs = HS_done;
	assign clear_col = HS_done | (currState == 2'b00);
	always @(*) begin
		en_vs = 1'b0;
		load_vs = 1'b0;
		load_hs = 1'b0;
		clear_vs = 1'b0;
		D_HS = 11'd0;
		D_VS = 20'd0;
		clear_row = 1'b0;
		case (currState)
			2'b00: begin
				nextState = 2'b01;
				clear_row = 1'b1;
				load_vs = 1'b1;
				load_hs = 1'b1;
				D_HS = 11'd1;
				D_VS = 20'd1;
				en_vs = 1'b0;
			end
			2'b01:
				if (VS_done) begin
					nextState = 2'b10;
					clear_vs = 1'b1;
					clear_row = 1'b1;
					en_vs = 1'b0;
				end
				else begin
					nextState = 2'b01;
					en_vs = 1'b1;
					clear_row = 1'b0;
					load_vs = 1'b0;
					load_hs = 1'b0;
				end
			2'b10: begin
				nextState = 2'b01;
				en_vs = 1'b1;
				clear_vs = 1'b0;
				clear_row = 1'b0;
			end
		endcase
	end
	assign HS = ~isB_hp;
	assign VS = ~isB_vp;
	assign blank = ~(isB_vd & isB_hd);
	assign row = Q_row;
	assign col = Q_col;
endmodule
module Adder (
	A,
	B,
	Cin,
	Sum,
	Cout
);
	parameter WIDTH = 8;
	input wire [WIDTH - 1:0] A;
	input wire [WIDTH - 1:0] B;
	input wire Cin;
	output wire [WIDTH - 1:0] Sum;
	output wire Cout;
	assign {Cout, Sum} = (A + B) + Cin;
endmodule
module Mux2to1 (
	I0,
	I1,
	S,
	Y
);
	parameter WIDTH = 8;
	input wire [WIDTH - 1:0] I0;
	input wire [WIDTH - 1:0] I1;
	input wire S;
	output wire [WIDTH - 1:0] Y;
	assign Y = (S ? I1 : I0);
endmodule
module DFlipFlop (
	Q,
	D,
	clock,
	reset_L,
	preset_L
);
	output reg Q;
	input wire D;
	input wire clock;
	input wire reset_L;
	input wire preset_L;
	always @(posedge clock or negedge reset_L or negedge preset_L)
		if (~reset_L)
			Q <= 0;
		else if (~preset_L)
			Q <= 1;
		else
			Q <= D;
endmodule
module Register (
	en,
	clear,
	clock,
	D,
	Q
);
	parameter WIDTH = 8;
	input wire en;
	input wire clear;
	input wire clock;
	input wire [WIDTH - 1:0] D;
	output reg [WIDTH - 1:0] Q;
	always @(posedge clock)
		if (en)
			Q <= D;
		else if (clear)
			Q <= 1'sb0;
endmodule
module Counter (
	en,
	clear,
	load,
	up,
	clock,
	D,
	Q
);
	parameter WIDTH = 8;
	input wire en;
	input wire clear;
	input wire load;
	input wire up;
	input wire clock;
	input wire [WIDTH - 1:0] D;
	output reg [WIDTH - 1:0] Q;
	always @(posedge clock)
		if (clear)
			Q <= 1'sb0;
		else if (load)
			Q <= D;
		else if (en & up)
			Q <= Q + 1;
		else if (en & ~up)
			Q <= Q - 1;
endmodule
module Synchronizer (
	async,
	clock,
	sync
);
	input wire async;
	input wire clock;
	output reg sync;
	reg async_1;
	always @(posedge clock) begin
		async_1 <= async;
		sync <= async_1;
	end
endmodule
module MagComp (
	A,
	B,
	AltB,
	AeqB,
	AgtB
);
	parameter WIDTH = 8;
	input wire [WIDTH - 1:0] A;
	input wire [WIDTH - 1:0] B;
	output wire AltB;
	output wire AeqB;
	output wire AgtB;
	assign AeqB = A == B;
	assign AltB = A < B;
	assign AgtB = A > B;
endmodule
module RangeCheck (
	val,
	high,
	low,
	is_between
);
	parameter WIDTH = 8;
	input wire [WIDTH - 1:0] val;
	input wire [WIDTH - 1:0] high;
	input wire [WIDTH - 1:0] low;
	output reg is_between;
	wire valLtHigh;
	wire valGtHigh;
	wire valEqHigh;
	wire valLtLow;
	wire valGtLow;
	wire valEqLow;
	MagComp #(.WIDTH(WIDTH)) comp1(
		.A(val),
		.B(high),
		.AeqB(valEqHigh),
		.AgtB(valGtHigh),
		.AltB(valLtHigh)
	);
	MagComp #(.WIDTH(WIDTH)) comp2(
		.A(val),
		.B(low),
		.AeqB(valEqLow),
		.AgtB(valGtLow),
		.AltB(valLtLow)
	);
	always @(*)
		if (valGtHigh | valLtLow)
			is_between = 1'b0;
		else
			is_between = 1'b1;
endmodule
module OffsetCheck (
	delta,
	low,
	val,
	is_between
);
	parameter WIDTH = 8;
	input wire [WIDTH - 1:0] delta;
	input wire [WIDTH - 1:0] low;
	input wire [WIDTH - 1:0] val;
	output wire is_between;
	wire [WIDTH - 1:0] sum;
	wire cout;
	wire [WIDTH:0] full_sum;
	wire [WIDTH:0] full_val;
	wire [WIDTH:0] full_low;
	Adder #(.WIDTH(WIDTH)) add(
		.A(low),
		.B(delta),
		.Cin(1'b0),
		.Sum(sum),
		.Cout(cout)
	);
	assign full_sum = {cout, sum};
	assign full_val = {1'b0, val};
	assign full_low = {1'b0, low};
	RangeCheck #(.WIDTH(WIDTH + 1)) rc(
		.val(full_val),
		.high(full_sum),
		.low(full_low),
		.is_between(is_between)
	);
endmodule