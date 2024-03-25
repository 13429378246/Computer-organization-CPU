
module type #(
    parameter R = 7'b0000011,
    parameter I = 7'b0000111,
    parameter S = 7'b0001111,
    parameter B = 7'b0001011,
    parameter U = 7'b0011011,
    parameter J = 7'b0011111
) (
    in,
    opcode,
    imm,
    func,
    rs2,
    rs1,
    rd

);
  input [31:0] in;
  output reg [31:0] imm;
  output reg [4:0] rs2, rs1, rd;
  output reg [11:0] func;
  output wire [6:0] opcode;
  assign opcode = in[6:0];
  always @(*) begin
    case (opcode)
      R: begin
        imm  <= 0;
        func <= {1'b0,in[14:12],1'b0,in[31:25]};
        rs2  <= in[24:20];
        rs1  <= in[19:15];
        rd   <= in[11:7];
      end
      I: begin
        imm  <= {{20{in[31]}}, in[31:20]};
        func <= {1'b0,in[14:12],8'b0};
        rs2  <= 0;
        rs1  <= in[19:15];
        rd   <= in[11:7];
      end
      S: begin
        imm  <= {{20{in[31]}}, in[31:25], in[11:7]};
        func <= {1'b0,in[14:12],8'b0};
        rs2  <= in[24:20];
        rs1  <= in[19:15];
        rd   <= 0;
      end
      B: begin
        imm  <= {{20{in[31]}},in[31], in[7], in[30:25], in[11:8]};
        func <= {1'b0,in[14:12],8'b0};
        rs2  <= in[24:20];
        rs1  <= in[19:15];
        rd   <= 0;
      end
      U: begin
        imm  <= {in[31:12],12'b0};
        func <= 0;
        rs2  <= 0;
        rs1  <= 0;
        rd   <= in[11:7];
      end
      J: begin
        imm  <= {{12{in[31]}}, in[31], in[19:12], in[20], in[30:21]};
        func <= {1'b0,in[14:12],1'b0,in[31:25]};
        rs2  <= 0;
        rs1  <= 0;
        rd   <= in[11:7];
      end
      default: begin
      imm<=0;
      func<=0;
      rs2<=0;
      rs1<=0;
      rd<=0;
      end
      


    endcase
  end



endmodule
