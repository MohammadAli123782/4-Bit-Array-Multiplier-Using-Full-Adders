module full_adder (
    input  wire A,
    input  wire B,
    input  wire Cin,
    output wire Sum,
    output wire Cout
);

    assign Sum  = A ^ B ^ Cin;
    assign Cout = (A & B) | (Cin & (A ^ B));

endmodule


module multiplier_4x4 (
    input  wire [3:0] M,
    input  wire [3:0] Q,
    output wire [7:0] P
);

    wire x00, x10, x20, x30;
    wire x01, x11, x21, x31;
    wire x02, x12, x22, x32;
    wire x03, x13, x23, x33;

    wire s12, s13, s14;
    wire s23, s24, s25;

    wire c10, c11, c12, c13;
    wire c20, c21, c22, c23;
    wire c30, c31, c32;


    assign x00 = M[0] & Q[0];
    assign x10 = M[1] & Q[0];
    assign x20 = M[2] & Q[0];
    assign x30 = M[3] & Q[0];

    assign x01 = M[0] & Q[1];
    assign x11 = M[1] & Q[1];
    assign x21 = M[2] & Q[1];
    assign x31 = M[3] & Q[1];

    assign x02 = M[0] & Q[2];
    assign x12 = M[1] & Q[2];
    assign x22 = M[2] & Q[2];
    assign x32 = M[3] & Q[2];

    assign x03 = M[0] & Q[3];
    assign x13 = M[1] & Q[3];
    assign x23 = M[2] & Q[3];
    assign x33 = M[3] & Q[3];

    assign P[0] = x00;

    full_adder FA10 (
        .A    (x10),
        .B    (x01),
        .Cin  (1'b0),
        .Sum  (P[1]),
        .Cout (c10)
    );

    full_adder FA11 (
        .A    (x20),
        .B    (x11),
        .Cin  (c10),
        .Sum  (s12),
        .Cout (c11)
    );

    full_adder FA12 (
        .A    (x30),
        .B    (x21),
        .Cin  (c11),
        .Sum  (s13),
        .Cout (c12)
    );

    full_adder FA13 (
        .A    (1'b0),
        .B    (x31),
        .Cin  (c12),
        .Sum  (s14),
        .Cout (c13)
    );


    full_adder FA20 (
        .A    (s12),
        .B    (x02),
        .Cin  (1'b0),
        .Sum  (P[2]),
        .Cout (c20)
    );

    full_adder FA21 (
        .A    (s13),
        .B    (x12),
        .Cin  (c20),
        .Sum  (s23),
        .Cout (c21)
    );

    full_adder FA22 (
        .A    (s14),
        .B    (x22),
        .Cin  (c21),
        .Sum  (s24),
        .Cout (c22)
    );

    full_adder FA23 (
        .A    (c13),
        .B    (x32),
        .Cin  (c22),
        .Sum  (s25),
        .Cout (c23)
    );


    full_adder FA30 (
        .A    (s23),
        .B    (x03),
        .Cin  (1'b0),
        .Sum  (P[3]),
        .Cout (c30)
    );

    full_adder FA31 (
        .A    (s24),
        .B    (x13),
        .Cin  (c30),
        .Sum  (P[4]),
        .Cout (c31)
    );

    full_adder FA32 (
        .A    (s25),
        .B    (x23),
        .Cin  (c31),
        .Sum  (P[5]),
        .Cout (c32)
    );

    full_adder FA33 (
        .A    (c23),
        .B    (x33),
        .Cin  (c32),
        .Sum  (P[6]),
        .Cout (P[7])
    );

endmodule
