module mycomp(
    input a,b,
    output o1,o2,o3
);

assign o1 = a & ~b;
assign o2 = ~(a^b);
assign o3 = ~a & b;

endmodule