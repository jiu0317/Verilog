# 기본 구문

### Data Flow 모델링과  Gate level 모델링

Data Flow 모델링은 게이트레벨 모델링으로 작성된 코드와 같은 동작을 하지만 게이트 레벨이 아닌 회로의 동작을 중심으로 추상화 하여 설계하는 방식이다. 

게이트 레벨 모델링을 하게 되면 코드의 길이가 길어지고 코드의 동작을 한눈에 알아볼 수 없다. (사용자가 코드를 짤 때부터 최적화를 한 것이다.)

데이터 플로우 모델링을 하게 되면 Synthesis 가 코드를 optimization하여 회로를 구성하게 된다.

### display
```verilog
$display("==== start ====");
```
--> 변수 출력 가능.
서식 : %d 정수, %t 시간($time), %b 2진수.

%3t : 최소 3자리 시간 출력. (ex : _ _ 1, _ _ 2, _ _ 3 . . . )

### monitor
디스플레이와 달리, 지정된 값이 변하면 반복시키지 않아도 자동으로 출력!
형식은 display 와 동일.

```verilog
$monitor("Time : %3t", $time);
```


### assign function
```verilog
or G1(F,G,K);
```
--> assign F = G | K; 의 연산을 수행하는 G1 게이트를 인스턴스화 한다. 

생성된 **게이트의 인스턴스는 재사용할 수 없다**. 
(모듈은 재사용할 수 있다. 재사용을 하려면 인스턴스로 만드는 것이 아니라 모듈을 만들어서 해당 모듈을 인스턴스화 해야한다.)


### repeat
```verilog
repeat (n) begin
	// 반복 할 코드
end
```
--> 지정한 n번 만큼 코드 반복. (n은 정수)
타이밍 연산자( # ) 없이 사용하면 안됨.

### 레지스터 생성
```verilog
reg [3:0] counter;
```
--> counter 라는 이름의 **4비트 레지스터** 1개.
counter\[3] 에 MSB 저장.

```verilog
reg counter [3:0];
```
--> counter\[0] ~ counter\[3]라는 이름의 **1 비트 레지스터** 4개.


ex)
```verilog
module example;
  reg [3:0] counter1;     // 4비트 레지스터
  reg counter2 [3:0];     // 1비트 레지스터 4개

  initial begin
    counter1 = 4'b1010;   // 4비트 값 할당 가능
    counter2[0] = 1'b1;   // 1비트 값만 할당 가능
    counter2[1] = 1'b0;
    counter2[2] = 1'b1;
    counter2[3] = 1'b0;
  end
endmodule

```


### always
하드웨어의 동작 반복 or 조건에 따라 반응.
always 는 initial 과 같은 레벨이다. (initial 안에 들어가지 않는다. )

```verilog
always @(sensitivity_list) begin
    // 실행할 코드
end
```

sensitivity list : 
@(posedge clk) : clk 의 라이징 엣지에서 실행.
@(negedge clk) : clk의 하강 엣지에서 실행.
@(a or b or c) : 신호 a, b, c가 변경될 때 마다 실행.
@(\*) : 모든 입력이 변경될 때 실행(조합논리회로).

sensitivity list 가 없으면 그냥 실행됨. 
