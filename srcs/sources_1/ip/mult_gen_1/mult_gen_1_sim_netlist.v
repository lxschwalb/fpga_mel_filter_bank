// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Tue Feb 11 02:11:44 2020
// Host        : pc running 64-bit Ubuntu 16.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/alex/mfcc/project_1/project_1.srcs/sources_1/ip/mult_gen_1/mult_gen_1_sim_netlist.v
// Design      : mult_gen_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z007sclg225-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_gen_1,mult_gen_v12_0_14,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_14,Vivado 2018.2" *) 
(* NotValidForBitStream *)
module mult_gen_1
   (CLK,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, PHASE 0.000" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [31:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [31:0]P;

  wire [31:0]A;
  wire [15:0]B;
  wire CLK;
  wire [31:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "46" *) 
  (* C_OUT_LOW = "15" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mult_gen_1_mult_gen_v12_0_14 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "1" *) (* C_A_WIDTH = "32" *) (* C_B_TYPE = "1" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "16" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "1" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "46" *) 
(* C_OUT_LOW = "15" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynq" *) (* ORIG_REF_NAME = "mult_gen_v12_0_14" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module mult_gen_1_mult_gen_v12_0_14
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [31:0]A;
  input [15:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [31:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [31:0]A;
  wire [15:0]B;
  wire CLK;
  wire [31:0]P;
  wire [47:0]PCASC;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

  assign ZERO_DETECT[1] = \<const0> ;
  assign ZERO_DETECT[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "46" *) 
  (* C_OUT_LOW = "15" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mult_gen_1_mult_gen_v12_0_14_viv i_mult
       (.A(A),
        .B(B),
        .CE(1'b0),
        .CLK(CLK),
        .P(P),
        .PCASC(PCASC),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_i_mult_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
Xy0rQtyFjlVkbWfeQXwuqraA3MiYyL0eFNjbY4iEa+s0Iy4tsgQeJeqb8F2nyNFI15QQro+xjbie
m+gt7LRqSA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
ket885wFwjDLqC97HI68cpTwpD1hGBIJdkMh+rsfw+vPf59MdHJNNbcLh5jkiDAOhjCAn8l7Pljd
OAdA4DPaB1th3EEcK28Uhm8xkCE8u1JeKM+cTawL1ZqM7f5vFJDMTdaQdo2ODraPwf63iOc4O7I1
Jp0iW8w4eq4dmJxUtLQ=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
0sLRbF/nd38eurlUzps5D+y+9REEleMhJud3+B55Wgm1hYo1ntzC4vdMFNHAcAq1l46fEiE/D85o
eYPC/WuBoZraAAbt+2vzvO+6NgUIpKKrii5bWkc7zSRBw4OUgkdgOToRQnup7uEq7pNL5gER2W2q
jpbl57Ks7667W7TbtoCx+55cY2wmHeQ+Fi9eAhxvopt9UQ7JhiAITU32QV0QOUo0C5DuMrCOfUPt
Q4mY/sCujPAsGwpHpQOH6JmVeTJ9/9FBANFdHkzv6F+8T8a1pEE2+YcJXysHrFHMtW27J1ZZCZGA
hChjmCakAGz4Jve6Njfz9RKNiLrrvv0gHwgvEw==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Z45gwqdZGpYP0Kv2lPvhL9t/dewTJD5ANS61F5BSLbdhMd8PVbRummT3J9CrH0Xrbuzjih6sOpQw
kP9SCPfkWk0LECt8HjobCatSEoRRONU79HyCEoDk93VT8CY8JL1BVS13wUngEWn6CIfitTyUUXR/
CxyxtdDZQFDUfHXEX4XQ0Yn12IXvHzgVAVLyG8UmGQWtQl4u7U/ZvMszHbCI4hHi6FW2kYvzBYlf
e14GZYOKCoOlqFp/3u2vs2rSSE9ciWV/SYIJDbOxsQCcBEM+UYYOzWikcZxKJAlJhndq92g1JKTL
sQcp7SBbbJ1O6Xynuz0MZ47Dfl+F87qkHSjwDQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2017_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
AeZ3V4sxDArImz8Q4W0bdOLintyw5zFj71qsxS4fYZUiRz8fNjC87lJzQ+YnUM13/42C5tAz/W5B
5De7uFmIgyIiHZ7Y1Ljeaa49Hank9rJJwKCFDSSNL8oJL51I1jWnn7YQnA7UX2zo1TTkepqKq7HW
QLVQHxdIfz7XQJ1KYPLfGQXcsGEecPlraNmNXeykJAgtAFm5XnR8iyVOGbjm9W9BUx0070wOpVoK
DNLr58vy3yAgTwtSBr+RexJEsBPZIUDyrA9NgYHy91GC6l4e/tQMTkA5GUgHnQd/YiVINSR358nO
A3j+0MMXq+Hrg0TJtfXsqD7mdjD7gjs4pqa1Vw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
BTz6m4RfoEciTWA22aqSQ7leYhQBT580p+3gUMnEkDKrl8y/O8yBG9prYh9eaBfxpy/1/zsYPTfE
O0sD3klOHeyC81JjLy2AWCWL1sk9/7n5I9vvSHXaQP4PHYRjAzqZC2XENPD0SKyVkobaEQpad+o8
VjB8RI608B9GgMaZvYA=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
D7Hbf96be8hL6h8aH9GXSy4IzBK9xG0ri9cVSVfA+REat+znGl+3rKoWJP3Y8xVsMkc1boG+wuph
DvXt9Y8VIRQAHNgamdZlVmWFc7YNNoioXwxsiPQUGQ033qF9EQryRyyXiVxfPqJOSfqv7PrbvgOT
5UDZUXtmOWGVrgoDlz45TFPs5v+lO6i3RYt0nujylzKTS8VLhLp7chpkjrCdjQc8hZGNDkUI5WPz
T16PgMtr8+aqlEn030MgQ09L5vJki+2qisAmejQVoQ30QbY0N/13XTb4LdaYF1u53Ib59hKf/1nP
//1d/wsq1f4QJoIkaVIa2ngZqWphjv4BhaOjtw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bqQJnGkdA7YtifRZAHXI4WfCmq6HqEJQ1OKNXlivhH7FnunFzm4wgDTFhu/6xuUltuC1MX+XJ0FD
wTTjc+aZfYir1rl/T4aHf80pUsoHFSkKSZNHcMOF32473n1+LzQZA7CPNWuQfHbX+Dwqi6hPu46t
XxHexHEVIMYecOjTndRcWl3Dd94BOJRMOa5ayuAlHPryZwKYpmtmEe8c3jkdHkfOIaq9sFbacSnu
1HTyJicweeForrY2+s5izjkGS3jrGrdKyUS1wNqiCRcsif23qz8mvCOKbeotKiAcIqCJRT7L7B1c
ibUOD4JPKai9gxv5Epwlb0DCpi6FsFO6Dcua9w==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PXqL5MLr3KdNqZXl0F7ouW5BxNmICq60c8cLPjsC/YfIx4FAkphdwCUt2wQ6q22svK42VQo4gCAJ
lc68ior6Ynk+YoIUcn/B2Mx0JiD7kHDnHdiZnjJ60NT+T1LH60b2tedpyDzjZ3KSCcaqClvFO7AB
ho5C5/VEGFQxLH3tu7HX13hZOF7BCBJSQTVFZulnSBf2pAmQxj9zNpyc2BK7oJZqySWoT1YoM7lM
x5dXS5E9tNZ8449V6j4FKUCwEFCgyNWtIgPDbVxvgN8kbmCEzYw7T2CP+idPgpBEmFvw5DYnaymG
+u/7cAJF2CkYDn/WUvb7q5E7tq727OyTFQod2A==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 11952)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
