`timescale 1ns / 1ps

module game_of_life(
        clk,
        data_out_0,
        data_out_1,
        data_out_2,
        data_out_3,
        row,
        read,
        led,
        switch
    );
    input clk;
    output [0:31] data_out_0;
    output [0:31] data_out_1;
    output [0:31] data_out_2;
    output [0:31] data_out_3;
    output reg[0:31] row;
    input read;
    
    output led;
    
    reg last_read;
    
    reg executed = 0;
    
    localparam WIDTH = 128;
    localparam HEIGHT = 32;
        
    reg matrix1[0:WIDTH-1][0:HEIGHT-1];
    reg matrix2[0:WIDTH-1][0:HEIGHT-1];
    
    input switch;
    
    reg [0:7]i , j;
    reg [0:3]counter = 0;
    
    initial
    begin  
        last_read <= 0;        
                
        for(i = 0; i < HEIGHT; i = i + 1)
            for(j = 0; j < WIDTH; j = j + 1)
            begin
                matrix2[j][i] <= 0;
                matrix1[j][i] <= 0;
            end 
            
        //Blinker
        matrix2[5][3] <= 1;
        matrix2[5][4] <= 1;
        matrix2[5][5] <= 1;
        //Block
        matrix2[20][20] <= 1;
        matrix2[20][21] <= 1;
        matrix2[21][20] <= 1;
        matrix2[21][21] <= 1;
        //Penta-Decathlon
        matrix2[100][15] <= 1;
        matrix2[101][15] <= 1;
        matrix2[102][14] <= 1;
        matrix2[102][16] <= 1;
        matrix2[103][15] <= 1;
        matrix2[104][15] <= 1;
        matrix2[105][15] <= 1;
        matrix2[106][15] <= 1;
        matrix2[107][14] <= 1;
        matrix2[107][16] <= 1;
        matrix2[108][15] <= 1;
        matrix2[109][15] <= 1;
        //Beacon
        matrix2[30][10] <= 1;
        matrix2[31][10] <= 1;
        matrix2[30][11] <= 1;
        matrix2[31][11] <= 1; 
        matrix2[32][12] <= 1;
        matrix2[33][12] <= 1;
        matrix2[32][13] <= 1;
        matrix2[33][13] <= 1;
        //Gosper Glider Gun
            //1st Block
        matrix2[38][10] <= 1;
        matrix2[38][11] <= 1;
        matrix2[39][10] <= 1;
        matrix2[39][11] <= 1;
            //Left Gun
        matrix2[48][10] <= 1;
        matrix2[48][11] <= 1;
        matrix2[48][12] <= 1;
        matrix2[49][9]  <= 1;
        matrix2[49][13] <= 1;
        matrix2[50][8]  <= 1;
        matrix2[50][14] <= 1;
        matrix2[51][8]  <= 1;
        matrix2[51][14] <= 1;
        matrix2[52][11] <= 1;
        matrix2[53][9]  <= 1;
        matrix2[53][13] <= 1;
        matrix2[54][10] <= 1;
        matrix2[54][11] <= 1;
        matrix2[54][12] <= 1;
        matrix2[55][11] <= 1;
            //Right Gun
        matrix2[58][8] <= 1;
        matrix2[59][8] <= 1;
        matrix2[58][9] <= 1;
        matrix2[59][9] <= 1;
        matrix2[58][10] <= 1;
        matrix2[59][10] <= 1;
        matrix2[60][7] <= 1;
        matrix2[60][11] <= 1;
        matrix2[62][7] <= 1;
        matrix2[62][6] <= 1;
        matrix2[62][11] <= 1;
        matrix2[62][12] <= 1;
            //2nd Block
        matrix2[72][8] <= 1;
        matrix2[73][8] <= 1;
        matrix2[72][9] <= 1;
        matrix2[73][9] <= 1;
        //                
    end
    
always@(posedge clk)
begin       
    if(switch && executed == 0)
    begin
        executed <= 1;
        for(i = 1; i < HEIGHT - 1; i = i + 1)
        begin
            for(j = 1; j < WIDTH - 1; j = j + 1)
            begin       
                counter = 0;         
                counter = 
                    matrix1[j-1][i-1] + 
                    matrix1[j]  [i-1] +
                    matrix1[j+1][i-1] +
                    matrix1[j-1][i]   +
                    matrix1[j+1][i]   +
                    matrix1[j-1][i+1] +
                    matrix1[j]  [i+1] +
                    matrix1[j+1][i+1];
        
                if(matrix1[j][i] == 0 && counter == 3)
                    matrix2[j][i] <= 1;
                else if(matrix1[j][i] == 1 && counter < 2)
                    matrix2[j][i] <= 0; 
                else if(matrix1[j][i] == 1 && counter > 3)
                    matrix2[j][i] <= 0; 
                else if(matrix1[j][i] == 1 && (counter == 2 || counter == 3))
                    matrix2[j][i] <= 1;        
                                       
            end     
        end
    end                     
                                
    else if(last_read == 1 && read == 0)
    begin
        row = row + 1;
        if(row >= HEIGHT)
        begin
            executed = 0;
            row = 0;
        end
    end
        for(i = 0; i < HEIGHT; i = i + 1)
            for(j = 0; j < WIDTH; j = j + 1)
                matrix1[j][i] <= matrix2[j][i]; 
                
end

assign led = switch;

always@(posedge clk)
    last_read = read;
    
assign data_out_0 = {       matrix2[0][row],
                            matrix2[1][row],
                            matrix2[2][row],
                            matrix2[3][row],
                            matrix2[4][row],
                            matrix2[5][row],
                            matrix2[6][row],
                            matrix2[7][row],
                            matrix2[8][row],
                            matrix2[9][row],
                            matrix2[10][row],
                            matrix2[11][row],
                            matrix2[12][row],
                            matrix2[13][row],
                            matrix2[14][row],
                            matrix2[15][row],
                            matrix2[16][row],
                            matrix2[17][row],
                            matrix2[18][row],
                            matrix2[19][row],
                            matrix2[20][row],
                            matrix2[21][row],
                            matrix2[22][row],
                            matrix2[23][row],
                            matrix2[24][row],
                            matrix2[25][row],
                            matrix2[26][row],
                            matrix2[27][row],
                            matrix2[28][row],
                            matrix2[29][row],
                            matrix2[30][row],
                            matrix2[31][row]
                            };
assign data_out_1 = {       matrix2[32][row],
                            matrix2[33][row],
                            matrix2[34][row],
                            matrix2[35][row],
                            matrix2[36][row],
                            matrix2[37][row],
                            matrix2[38][row],
                            matrix2[39][row],
                            matrix2[40][row],
                            matrix2[41][row],
                            matrix2[42][row],
                            matrix2[43][row],
                            matrix2[44][row],
                            matrix2[45][row],
                            matrix2[46][row],
                            matrix2[47][row],
                            matrix2[48][row],
                            matrix2[49][row],
                            matrix2[50][row],
                            matrix2[51][row],
                            matrix2[52][row],
                            matrix2[53][row],
                            matrix2[54][row],
                            matrix2[55][row],
                            matrix2[56][row],
                            matrix2[57][row],
                            matrix2[58][row],
                            matrix2[59][row],
                            matrix2[60][row],
                            matrix2[61][row],
                            matrix2[62][row],
                            matrix2[63][row]
                            };                    
                            
assign data_out_2 = {       matrix2[64][row],
                            matrix2[65][row],
                            matrix2[66][row],
                            matrix2[67][row],
                            matrix2[68][row],
                            matrix2[69][row],
                            matrix2[70][row],
                            matrix2[71][row],
                            matrix2[72][row],
                            matrix2[73][row],
                            matrix2[74][row],
                            matrix2[75][row],
                            matrix2[76][row],
                            matrix2[77][row],
                            matrix2[78][row],
                            matrix2[79][row],
                            matrix2[80][row],
                            matrix2[81][row],
                            matrix2[82][row],
                            matrix2[83][row],
                            matrix2[84][row],
                            matrix2[85][row],
                            matrix2[86][row],
                            matrix2[87][row],
                            matrix2[88][row],
                            matrix2[89][row],
                            matrix2[90][row],
                            matrix2[91][row],
                            matrix2[92][row],
                            matrix2[93][row],
                            matrix2[94][row],
                            matrix2[95][row]
                            };       
                                                         
assign data_out_3 = {       matrix2[96][row],
                            matrix2[97][row],
                            matrix2[98][row],
                            matrix2[99][row],
                            matrix2[100][row],
                            matrix2[101][row],
                            matrix2[102][row],
                            matrix2[103][row],
                            matrix2[104][row],
                            matrix2[105][row],
                            matrix2[106][row],
                            matrix2[107][row],
                            matrix2[108][row],
                            matrix2[109][row],
                            matrix2[110][row],
                            matrix2[111][row],
                            matrix2[112][row],
                            matrix2[113][row],
                            matrix2[114][row],
                            matrix2[115][row],
                            matrix2[116][row],
                            matrix2[117][row],
                            matrix2[118][row],
                            matrix2[119][row],
                            matrix2[120][row],
                            matrix2[121][row],
                            matrix2[122][row],
                            matrix2[123][row],
                            matrix2[124][row],
                            matrix2[125][row],
                            matrix2[126][row],
                            matrix2[127][row]
                            };              
endmodule