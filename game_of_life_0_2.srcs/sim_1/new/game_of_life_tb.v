`timescale 1ns / 1ps

module game_of_life_tb();

reg clk;
reg switch;
reg read;

wire[0:31]data_out_0;
wire[0:31]data_out_1;
wire[0:31]data_out_2;
wire[0:31]data_out_3;
wire[0:31]row;
//wire led;
parameter clock_period = 10;

always #(clock_period/2) clk <= ~clk;

initial
begin 
clk = 0;
read = 0;
switch = 0;
#(clock_period * 5)
read = 0;
switch = 0;
#(clock_period * 5)
read = 0;
switch = 1;
#(clock_period * 5) //1
read = 1;    
#(clock_period * 5) 
read = 0;
#(clock_period * 5) //2
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //3
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //4
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //5
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //6
read = 1;    
#(clock_period * 5) 
read = 0;
#(clock_period * 5) //7
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //8
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //0
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //1
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //2
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //3
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //4
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //5
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //6
read = 1;    
#(clock_period * 5) 
read = 0;
#(clock_period * 5) //7
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //8
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //1
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //2
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //3
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //4
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //5
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //6
read = 1;    
#(clock_period * 5) 
read = 0;
#(clock_period * 5) //7
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //8
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //1
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //2
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //3
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //4
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //5
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //6
read = 1;    
#(clock_period * 5) 
read = 0;
#(clock_period * 5) //7
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //8
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //1
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //2
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //3
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //4
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //5
read = 1;    
#(clock_period * 5)
read = 0;
#(clock_period * 5) //6
read = 1;    
#(clock_period * 5) 
read = 0;
#(clock_period * 5) //7
read = 1;    
#(clock_period * 5)
read = 0;
repeat(1000)
    begin
        #(clock_period * 5) //8
        read = 1;    
        #(clock_period * 5)
        read = 0;
    end
end

game_of_life game(
                    .clk(clk),
                    .data_out_0(data_out_0),
                    .data_out_1(data_out_1),
                    .data_out_2(data_out_2),
                    .data_out_3(data_out_3),
                    .row(row),
                    .read(read),
                    .led(led),
                    .switch(switch)
                    );

endmodule

