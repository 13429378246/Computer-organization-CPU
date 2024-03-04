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
    out
);
  input [4:0] in;
  output reg [6:0] out;
  always @(in) begin
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

endmodule

/*counter*/
module counter (
    up,
    clk,
    en,
    out,
    seg
);  //up counter up 0 1...9 seg a,b,c,d,e,f,g  
  input up, clk, en;
  output reg [3:0] out;
  output [6:0] seg;
  always @(posedge clk or negedge en) begin
    if (en == 0) out <= 0;
    else if (up) out <= (out + 1) % 10;
    else out <= (out - 1) % 10;
  end
  segment segdui (
      {1'b0, out},
      seg
  );

endmodule