//3상 버퍼 (buffer with enable)

assign Y = E ? A : 4'bz;
// E 가 1 이면 A, 0 이면 4'bz (high impedance) 를 Y 에 할당.

//design
module tristate(A, Y, E);
  input [3:0]A;
  input E;
  output [3:0]Y;
  
  assign Y=E ? A : 4'bz;
  
endmodule

//tb
module tri_tb;
  
  reg [3:0]A=4'b0000;
  reg E=1'b0;
  wire [3:0]Y;
  
  tristate tristate_inst(.A(A), .Y(Y), .E(E));
  
  always begin
    #1;
    A=A+4'b0001;
  end
  
  always begin
    #16;
    E = E+1'b1;
    if($time==32)$finish;
  end
  
  initial begin 
    $monitor("time=%3t, e=%b, a=%b, y=%b", $time, A, E, Y);
  end
  
    
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
