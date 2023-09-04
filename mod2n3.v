

//Modulo 2^n +3 implementation for n=4 and Input bit width = 8 bits i.e mod 19 implementation at n bit //boundary
module fulladd1b(sum,cout,a,b,cin);
  //1-bit Full Adder, Works for maximum values of inputs a=127, b=127 and cin=1
  //IO port declaration
  output sum,cout;
  input a,b,cin;

  //Internal nets
  wire s1,c1,c2;

  //Structural Description
  xor(s1,a,b);
  and(c1,a,b);
  xor(sum,s1,cin);
  and(c2,s1,cin);
  or(cout,c2,c1);

endmodule

module fullAdd6b(sum,cout,a,b,cin);
    //8-bit full adder
    //I/O port declarations
    output [7:0] sum;
    output cout;
    input [7:0] a,b;
    input cin;
    //nets
    wire c1,c2,c3,c4,c5,c6,c7;
    //Instantiation
    fulladd1b fa0(sum[0],c1,a[0],b[0],cin);
    fulladd1b fa1(sum[1],c2,a[1],b[1],c1);
    fulladd1b fa2(sum[2],c3,a[2],b[2],c2);
    fulladd1b fa3(sum[3],c4,a[3],b[3],c3);
    fulladd1b fa4(sum[4],c5,a[4],b[4],c4); 
    fulladd1b fa5(sum[5],c6,a[5],b[5],c5);
    fulladd1b fa6(sum[6],c7,a[6],b[6],c6);
    fulladd1b fa7(sum[7],cout,a[7],b[7],c7);
    
endmodule

module ls6b(dout, c, din);
   //4-bit Left shift block, Works for 4 bit input only
   
   input wire [4:0] din;
   output [4:0] dout;
   output wire c;
   reg en;

   and a1(c, din[4], en);
   and a2(dout[4], din[3], en);
   and a3(dout[3], din[2], en);
   and a4(dout[2], din[1], en);
   and a5(dout[1], din[0], en);
   and a6(dout[0], 1'b0, en);

   initial
   begin
      en = 1'b1;
   end
endmodule


module comp2s(ocmp, in);
  //Computes one's bit complement
   input [7:0] in;
   output [7:0] ocmp;

   not n1(ocmp[7], in[7]);
   not n2(ocmp[6], in[6]);
   not n3(ocmp[5], in[5]);
   not n4(ocmp[4], in[4]);
   not n5(ocmp[3], in[3]);
   not n6(ocmp[2], in[2]);
   not n7(ocmp[1], in[1]);
   not n8(ocmp[0], in[0]);
   
      
 endmodule


module buffer(out, in, oe);
//Buffer-for 8 bit input
    input [7:0] in;
    input oe;
    output [7:0] out;
    
    bufif1 b1(out[7], in[7] , oe);
    bufif1 b2(out[6], in[6] , oe);
    bufif1 b3(out[5], in[5] , oe);
    bufif1 b4(out[4], in[4] , oe);
    bufif1 b5(out[3], in[3] , oe);
    bufif1 b6(out[2], in[2] , oe);
    bufif1 b7(out[1], in[1] , oe);
    bufif1 b8(out[0], in[0] , oe);
    
 endmodule


module decoder4to19b(d, orf, en);
//4 to 19 decoder 

   input [4:0] orf;
   wire [4:0] a; 
   input en;
   //output [15:0] d;
   output [19:0] d;
   wire [4:0] ab;

   assign a[4:0]=orf[4:0];
   
   not ng1(ab[0], a[0]);
   not ng2(ab[1], a[1]);
   not ng3(ab[2], a[2]);
   not ng4(ab[3], a[3]);
   not ng5(ab[4], a[4]);

   and ag1(d[0], en, ab[4], ab[3], ab[2], ab[1], ab[0]);
   and ag2(d[1], en, ab[4], ab[3], ab[2], ab[1], a[0]);
   and ag3(d[2], en, ab[4], ab[3], ab[2], a[1], ab[0]);
   and ag4(d[3], en, ab[4], ab[3], ab[2], a[1], a[0]);
   and ag5(d[4], en, ab[4], ab[3], a[2], ab[1], ab[0]);
   and ag6(d[5], en, ab[4], ab[3], a[2], ab[1], a[0]);
   and ag7(d[6], en, ab[4], ab[3], a[2], a[1], ab[0]);
   and ag8(d[7], en, ab[4], ab[3], a[2], a[1], a[0]);
   and ag9(d[8], en, ab[4], a[3], ab[2], ab[1], ab[0]);
   and ag10(d[9], en, ab[4], a[3], ab[2], ab[1], a[0]);
   and ag11(d[10], en, ab[4], a[3], ab[2], a[1], ab[0]);
   and ag12(d[11], en, ab[4], a[3], ab[2], a[1], a[0]);
   and ag13(d[12], en, ab[4], a[3], a[2], ab[1], ab[0]);
   and ag14(d[13], en, ab[4], a[3], a[2], ab[1], a[0]);
   and ag15(d[14], en, ab[4], a[3], a[2], a[1], ab[0]);
   and ag16(d[15], en, ab[4], a[3], a[2], a[1], a[0]);
   and ag17(d[16], en, a[4], ab[3], ab[2], ab[1], ab[0]);
   and ag18(d[17], en, a[4], ab[3], ab[2], ab[1], a[0]);
   and ag19(d[18], en, a[4], ab[3], ab[2], a[1], ab[0]);
   and ag20(d[19], en, a[4], ab[3], ab[2], a[1], a[0]);
   


endmodule



module orgate(m, x);
//Or's identical values of inputs that generate similar mod 2^n+3 residues to output select signal to 
//RAM cell implementation
   

   input wire [20:0] x;
   
   output wire [9:0] m;
   

   or or0(m[0], x[19], x[0]);                    //(din)^2 mod 19 = 0               
   or or1(m[1], x[1], x[18], x[20]);    			 //1
   or or2(m[2], x[2], x[17]);                    //4
   or or3(m[3], x[3], x[16]);                    //9
   or or4(m[4], x[4], x[15]);				          //16
   or or5(m[5], x[5], x[14]);            		    //6
   or or6(m[6], x[6], x[13]);				          //17
   or or7(m[7], x[7], x[12]);                    //11
   or or8(m[8], x[8], x[11]);                    //7
   or or9(m[9], x[9], x[10]);                    //5    
  
endmodule



module ramCell4(dout1, din1, dset, sel);
//Ram cell implementation(Squarer look up)with output as dout1, inputs as din1(carry forward to next cell), 
//dset-the residue of mod 2^n+3, and sel input from previous orgate matrix. 
 
   input wire [4:0] din1;
   input wire [4:0] dset;
   output [4:0] dout1;
   input wire sel;
   wire s[4:0];

   and a0(s[0], sel, dset[0]);
   or  o0(dout1[0], din1[0], s[0]);

   and a1(s[1], sel, dset[1]);
   or  o1(dout1[1], din1[1], s[1]);

   and a2(s[2], sel, dset[2]);
   or  o2(dout1[2], din1[2], s[2]);

   and a3(s[3], sel, dset[3]);
   or  o3(dout1[3], din1[3], s[3]);

   and a4(s[4], sel, dset[4]);
   or  o4(dout1[4], din1[4], s[4]); 

	
endmodule


  

module main(memOut1, memOut2, din);
//
 
 input [7:0] din;
 wire [4:0] dout;
 wire c;
 wire en;
 assign en = 1'b1;

 
 wire cot;
 reg ci;
 wire [3:0] x,y;  
 reg [7:0] a,b;
 reg cin;
  wire [7:0] sum;
 wire cout;
 
 wire [7:0] ocmp, ocmp2;
 wire [7:0] tcmp, tcmp2;
 wire [7:0] xmty;
 

reg [7:0] in;
wire oe;
wire [7:0] out1, out2;

wire nto;


reg [4:0] orf;
wire [4:0] z;

wire [19:0] d1, d2;

wire [4:0] ab;

 assign z[4:0]=orf[4:0];
 assign en = 1'b1;


wire [9:0] sel1,sel2;


 wire [4:0] din1;
 wire [4:0] dset;
 wire [9:0] sel;
 wire s[4:0];

 output wire [4:0] memOut1, memOut2;
  wire [5:0] dout1 [8:0]; 
  wire [5:0] dout2 [8:0]; 

  

   assign x[0] = din[0];
   assign x[1] = din[1];
   assign x[2] = din[2];
   assign x[3] = din[3];
      
   assign y[0] = din[4];
   assign y[1] = din[5];
   assign y[2] = din[6];
   assign y[3] = din[7];

wire c1,c2,c3;

//Computes left shift (2y) 
ls6b ls1(dout, c, {1'b0,y});

//Full adder with a=b=8 bit inputs and Cin=1 bit(Performs y+2y)
fullAdd6b fa2(sum,cout,{4'b0000,y},{3'b000,dout},1'b0);

//Computes ones complement(One's complement of -3y) 
comp2s tc1(ocmp, sum);

//Computes two's complement of -3y
fullAdd6b fa3(tcmp, c1, ocmp, 8'b00000001, 1'b0);

//Computes (x+(-3y))
fullAdd6b fa4(xmty, c2, {4'b0000,x}, tcmp, 1'b0);

//Computes one's complement of (x+(-3y))
comp2s tc2(ocmp2, xmty);

//Computes two's complement of (x+(-3y))
fullAdd6b fa5(tcmp2, c3, ocmp2, 8'b00000001, 1'b0);

//Tristate buffer with control input as MSB of (x+(-3y))
//If xmty[7] = 1, then out1=tcmp2
//Else out2 = xmty = (x+(-3y)) for nto=1=not(xmty[7])

buffer bu1(out1, tcmp2, xmty[7]);
not n1(nto, xmty[7]);
buffer bu2(out2, xmty, nto);

//Out1 is input to 4 to 19 decoder-1
//Out2 is input to 4 to 19 decoder-2

decoder4to19b de1(d1, out1[4:0], en);
decoder4to19b de2(d2, out2[4:0], en);

//Output of decoder-1 is input to orgate matrix-1
//Output of decoder-2 is input to orgate matrix-2
orgate og1(sel1, {1'b0,d1});
orgate og2(sel2, {1'b0,d2});

//Select output of decoder-1(sel1) is input to Squarer look up-1 to obtain output-1 as memOut1
ramCell4 rc0(dout1[0], 5'b0, 5'b0, sel1[0]);
ramCell4 rc1(dout1[1], dout1[0], 5'b00001, sel1[1]);
ramCell4 rc2(dout1[2], dout1[1], 5'b00100, sel1[2]);
ramCell4 rc3(dout1[3], dout1[2], 5'b01001, sel1[3]);
ramCell4 rc4(dout1[4], dout1[3], 5'b10000, sel1[4]);
ramCell4 rc5(dout1[5], dout1[4], 5'b00110, sel1[5]);
ramCell4 rc6(dout1[6], dout1[5], 5'b10001, sel1[6]);
ramCell4 rc7(dout1[7], dout1[6], 5'b01011, sel1[7]);
ramCell4 rc8(dout1[8], dout1[7], 5'b00111, sel1[8]);
ramCell4 rc9(memOut1,   dout1[8], 5'b00101, sel1[9]);

//Select output of decoder-2(sel2) is input to Squarer look up-2 to obtain output-2 as memOut2
ramCell4 rc10(dout2[0], 5'b0, 5'b0, sel2[0]);
ramCell4 rc11(dout2[1], dout2[0], 5'b00001, sel2[1]);
ramCell4 rc12(dout2[2], dout2[1], 5'b00100, sel2[2]);
ramCell4 rc13(dout2[3], dout2[2], 5'b01001, sel2[3]);
ramCell4 rc14(dout2[4], dout2[3], 5'b10000, sel2[4]);
ramCell4 rc15(dout2[5], dout2[4], 5'b00110, sel2[5]);
ramCell4 rc16(dout2[6], dout2[5], 5'b10001, sel2[6]);
ramCell4 rc17(dout2[7], dout2[6], 5'b01011, sel2[7]);
ramCell4 rc18(dout2[8], dout2[7], 5'b00111, sel2[8]);
ramCell4 rc19(memOut2,   dout2[8], 5'b00101, sel2[9]);


endmodule

 

