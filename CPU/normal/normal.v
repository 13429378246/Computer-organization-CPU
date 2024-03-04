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
  input [31:0] a1, a0;
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

/*adder or suber*/
module adder32 (
    x,
    y,
    add,
    out
);  //add==1 +;add=0 -
  input [31:0] x, y;
  input add;
  output [31:0] out;
  function [1:0] add1;
    input fx, fy, fci, fadd;
    assign add1 = fx + fy & fadd + fci;
  endfunction

  add1 adder0 (
      x[0],
      y[0],
      ~add,
      add,
      out[0]
  );
  add1 adder1 (
      x[1],
      y[1],
      out[0],
      add,
      out[1]
  );
  add1 adder2 (
      x[2],
      y[2],
      out[1],
      add,
      out[2]
  );
  add1 adder3 (
      x[3],
      y[3],
      out[2],
      add,
      out[3]
  );
  add1 adder4 (
      x[4],
      y[4],
      out[3],
      add,
      out[4]
  );
  add1 adder5 (
      x[5],
      y[5],
      out[4],
      add,
      out[5]
  );
  add1 adder6 (
      x[6],
      y[6],
      out[5],
      add,
      out[6]
  );
  add1 adder7 (
      x[7],
      y[7],
      out[6],
      add,
      out[7]
  );
  add1 adder8 (
      x[8],
      y[8],
      out[7],
      add,
      out[8]
  );
  add1 adder9 (
      x[9],
      y[9],
      out[8],
      add,
      out[9]
  );
  add1 adder10 (
      x[10],
      y[10],
      out[9],
      add,
      out[10]
  );
  add1 adder11 (
      x[11],
      y[11],
      out[10],
      add,
      out[11]
  );
  add1 adder12 (
      x[12],
      y[12],
      out[11],
      add,
      out[12]
  );
  add1 adder13 (
      x[13],
      y[13],
      out[12],
      add,
      out[13]
  );
  add1 adder14 (
      x[14],
      y[14],
      out[13],
      add,
      out[14]
  );
  add1 adder15 (
      x[15],
      y[15],
      out[14],
      add,
      out[15]
  );
  add1 adder16 (
      x[16],
      y[16],
      out[15],
      add,
      out[16]
  );
  add1 adder17 (
      x[17],
      y[17],
      out[16],
      add,
      out[17]
  );
  add1 adder18 (
      x[18],
      y[18],
      out[17],
      add,
      out[18]
  );
  add1 adder19 (
      x[19],
      y[19],
      out[18],
      add,
      out[19]
  );
  add1 adder20 (
      x[20],
      y[20],
      out[19],
      add,
      out[20]
  );
  add1 adder21 (
      x[21],
      y[21],
      out[20],
      add,
      out[21]
  );
  add1 adder22 (
      x[22],
      y[22],
      out[21],
      add,
      out[22]
  );
  add1 adder23 (
      x[23],
      y[23],
      out[22],
      add,
      out[23]
  );
  add1 adder24 (
      x[24],
      y[24],
      out[23],
      add,
      out[24]
  );
  add1 adder25 (
      x[25],
      y[25],
      out[24],
      add,
      out[25]
  );
  add1 adder26 (
      x[26],
      y[26],
      out[25],
      add,
      out[26]
  );
  add1 adder27 (
      x[27],
      y[27],
      out[26],
      add,
      out[27]
  );
  add1 adder28 (
      x[28],
      y[28],
      out[27],
      add,
      out[28]
  );
  add1 adder29 (
      x[29],
      y[29],
      out[28],
      add,
      out[29]
  );
  add1 adder30 (
      x[30],
      y[30],
      out[29],
      add,
      out[30]
  );
  add1 adder31 (
      x[31],
      y[31],
      out[30],
      add,
      out[31]
  );

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

