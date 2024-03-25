module typetb();

  // Define parameters for convenience
  localparam R = 7'b0000011;
  localparam I = 7'b0000111;
  localparam S = 7'b0001111;
  localparam B = 7'b0001011;
  localparam U = 7'b0011011;
  localparam J = 7'b0011111;

  // Instantiate the module under test
  
    // Define signals
  reg [31:0] in;
  wire [6:0] opcode;
  wire [31:0] imm;
  wire [11:0] func;
  wire [4:0] rs2, rs1, rd;
  reg clk;
type dut (
    .in(in),
    .opcode(opcode),
    .imm(imm),
    .func(func),
    .rs2(rs2),
    .rs1(rs1),
    .rd(rd)
  );

 always #5 clk = ~clk;
 
always @(posedge clk) begin 
    in <= in + 1; 
  end


  // Initial block to apply inputs
  initial begin
    // Example input values
        in = 32'h12345600;
    clk = 0;

    // Print outputs
    $display("Opcode: %b", opcode);
    $display("Immediate: %b", imm);
    $display("Function: %b", func);
    $display("RS2: %b", rs2);
    $display("RS1: %b", rs1);
    $display("RD: %b", rd);
        #1000; 
    $finish;

  end

endmodule
