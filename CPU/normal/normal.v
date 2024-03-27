`timescale 1ns / 1ps
/*en high active*/

/*segment*/

//---a---
//f     b
//---g---
//e     c
//---d---
/*mux*/
module mux2to32 (
    a0,
    a1,
    in,
    out
);
  input [31:0] a1, a0;//input in the module must wire       out connect to the module must wire
  output in;
  output [31:0] out;
  assign out = in ? a1 : a0;
endmodule

/*decode*/
module decoder3to8 (
    en,
    in,
    out
);
  input [2:0] in;
  input en;
  output reg [7:0] out;
  always @(en or in) begin
    out = 8'b0;
    out[in] = en;
  end
endmodule

/*shift*/
module shift (
    in,
    sb,
    ri,
    arith,
    out
);  //input,shiftbits,isright,arithmatic,output
  input [31:0] in;
  input [4:0] sb;
  input ri, arith;
  output reg [31:0] out;
  always @* begin
    if (!ri) begin
      out = in << sb;
    end else if (arith) begin  //arithmatic  using sign bit
      out = $signed(in) >>> sb;
    end else begin
      out = in >> sb;
    end
  end
endmodule

/*segment*/
module segment (
    in,
    en,
    out,
);
  input [4:0] in;
  input en;
  output reg [6:0] out;
  always @(*) begin
  if(en) begin
    case (in)
      5'd0: out = 7'b1111110;
      5'd1: out = 7'b0110000;
      5'd2: out = 7'b1101011;
      5'd3: out = 7'b1111001;
      5'd4: out = 7'b0110011;
      5'd5: out = 7'b1011011;
      5'd6: out = 7'b1011111;
      5'd7: out = 7'b1110000;
      5'd8: out = 7'b1111111;
      5'd9: out = 7'b1111011;
      default: out = 7'b0000000;
    endcase
    end
  end

endmodule

/*counter*/
module counter (
    up,
    clk,
    reset,
    en,
    out,
    seg
);  //up counter up 0 1...9 seg a,b,c,d,e,f,g  
  input up, clk, reset,en;
  output reg [3:0] out;
  output [6:0] seg;
  always @(posedge clk or negedge reset) begin
    if (!reset) out <= 0;
    else if (en) begin
      if (up) out <= (out + 1) % 10;
      else out <= (out - 1) % 10;
    end
  end
  segment segdui (
      {1'b0, out},
      seg
  );

endmodule

/*clock 50MHz*/
module clock (
    clk,
    sec_clk
);
  input clk;
  output reg sec_clk = 1;
  reg [24:0] clk_cnt = 0;
  always @(posedge clk) begin
    if (clk_cnt == 25'd24999999) begin
      clk_cnt <= 0;
      sec_clk <= ~sec_clk;
    end else begin
      clk_cnt <= clk_cnt + 25'd1;
    end
  end


endmodule

/*decoder5to32*/
module decoder5to32 (
    in,
    en,
    out
);
  input [4:0] in;
  input en;
  output reg [31:0] out;
  always @(*) begin
    if (en == 1'b0) out = 32'h0000_0000;
    else begin
      case (in)
        5'd0: out <= 32'h0000_0001;
        5'd1: out <= 32'h0000_0002;
        5'd2: out <= 32'h0000_0004;
        5'd3: out <= 32'h0000_0008;

        5'd4: out <= 32'h0000_0010;
        5'd5: out <= 32'h0000_0020;
        5'd6: out <= 32'h0000_0040;
        5'd7: out <= 32'h0000_0080;

        5'd8:  out <= 32'h0000_0100;
        5'd9:  out <= 32'h0000_0200;
        5'd10: out <= 32'h0000_0400;
        5'd11: out <= 32'h0000_0800;

        5'd12: out <= 32'h0000_1000;
        5'd13: out <= 32'h0000_2000;
        5'd14: out <= 32'h0000_4000;
        5'd15: out <= 32'h0000_8000;

        5'd16: out <= 32'h0001_0000;
        5'd17: out <= 32'h0002_0000;
        5'd18: out <= 32'h0004_0000;
        5'd19: out <= 32'h0008_0000;

        5'd20: out <= 32'h0010_0000;
        5'd21: out <= 32'h0020_0000;
        5'd22: out <= 32'h0040_0000;
        5'd23: out <= 32'h0080_0000;

        5'd24: out <= 32'h0100_0000;
        5'd25: out <= 32'h0200_0000;
        5'd26: out <= 32'h0400_0000;
        5'd27: out <= 32'h0800_0000;

        5'd28: out <= 32'h1000_0000;
        5'd29: out <= 32'h2000_0000;
        5'd30: out <= 32'h4000_0000;
        5'd31: out <= 32'h8000_0000;

      endcase
    end
  end
endmodule
/*1 bit adder or suber*/
module add1(
    fx,
    fy, 
    fci,
    fadd,
    out
);
  input fx,fy,fci,fadd;
  output out;
    assign out = fx + fy & fadd + fci;
endmodule

/*adder or suber*/
module adder32 (
    x,
    y,
    add,
    out);  //add==1 +;add=0 -
  input [31:0] x, y;
  input add;
  output [31:0] out;

  assign out=(add==1)?(x+y):(x-y);  
endmodule


module register32 (
    in,
    en,
    reset,
    clk,
    out
);
  input [31:0] in;
  input clk, en, reset;
  output reg [31:0] out;
  always @(posedge clk or negedge reset) begin
    if (!reset) out <= 0;
    else begin
      if (en) out <= in;
    end
  end
endmodule

