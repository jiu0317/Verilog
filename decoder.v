//module
module dec(a,y);
  input [1:0]a;
  output [3:0]y;
  
  and
  (y[0],!a[0],!a[1]),
  (y[1],a[0],!a[1]),
  (y[2],!a[0],a[1]),
  (y[3],a[0],a[1]);
  
endmodule

//test bench
module dec_tb;
  
  dec instance_name (
      .a(I),            // 입력 I를 a에 연결
      .y(F)             // 출력 F를 y에 연결
  );
  
  reg [0:1]I;
  wire [0:3]F;
  
  initial begin
    I=2'b00;
    
    repeat(4) begin
      #5;
      if($time % 5 ==0) I[0]=~I[0]; //5초 마다
      if($time % 10 ==0) I[1]=~I[1]; //10초 마다
    end
    $finish;
  end
    
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
