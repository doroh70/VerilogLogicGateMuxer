module mux3_to_1(out, in0, in1, in2, s1, s0);
    output out;
    input in0, in1, in2;
    input s1, s0;
    
    // Internal wire declarations
    wire s1n, s0n;
    wire y0, y1, y2;

    // Gate instantiations
    // Create s1n and s0n signals.
    not (s1n, s1);
    not (s0n, s0);
    // 3-input and gates instantiated
    and (y0, in0, s1n, s0n);
    and (y1, in1, s1n, s0);
    and (y2, in2, s1, s0n);
    // 3-input or gate instantiated
    or (out, y0, y1, y2);
endmodule

module mux3_to_1_8bits(out, in0, in1, in2, s1, s0);
    output [7:0] out;
    input [7:0] in0, in1, in2;
    input s1, s0;
    
    // Instantiate the 1-bit 4-to-1 mux for each bit
    mux3_to_1 mux0(out[0], in0[0], in1[0], in2[0], s1, s0);
    mux3_to_1 mux1(out[1], in0[1], in1[1], in2[1], s1, s0);
    mux3_to_1 mux2(out[2], in0[2], in1[2], in2[2], s1, s0);
    mux3_to_1 mux3(out[3], in0[3], in1[3], in2[3], s1, s0);
    mux3_to_1 mux4(out[4], in0[4], in1[4], in2[4], s1, s0);
    mux3_to_1 mux5(out[5], in0[5], in1[5], in2[5], s1, s0);
    mux3_to_1 mux6(out[6], in0[6], in1[6], in2[6], s1, s0);
    mux3_to_1 mux7(out[7], in0[7], in1[7], in2[7], s1, s0);
endmodule

module xor_nor_nand(out, a, b, s1, s0);
    input[7:0] a, b;
    input s1, s0;
    output[7:0] out;
    wire [7:0] y0, y1, y2;
    
    // Apply the bitwise operations directly to the vectors
    xor x[7:0](y0, a, b); // Bitwise XOR
    nor n1[7:0](y1, a, b); // Bitwise NOR
    nand na1[7:0](y2, a, b); // Bitwise NAND
    
    mux3_to_1_8bits test(out, y0, y1, y2, s1, s0);
endmodule


module stimulus;
    reg[7:0] in0, in1;
    reg s1, s0;
    wire[7:0] out;
    xor_nor_nand x_n_n_1 (out, in0, in1, s1, s0);
    initial 
    begin
        $monitor("Input %b %b \n s1=%b, s0=%b, Output is %b \n", in0, in1, s1, s0, out);
        in0 = 8'b01110111; 
        in1 = 8'b00001011;
        #1 s1 = 0; s0 = 0;
        #1 s1 = 0; s0 = 1;
        #1 s1 = 1; s0 = 0;
        #1 in0 = 8'b01101001; in1 = 8'b10100101;
        #1 s1 = 0; s0 = 0;
        #1 s1 = 0; s0 = 1;
        #1 s1 = 1; s0 = 0;
    end
endmodule
