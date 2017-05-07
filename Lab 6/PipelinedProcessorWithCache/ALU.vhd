library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALU;

architecture structural of ALU is
component Addition
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           CarryIn : in  STD_LOGIC;
           CarryOut : out  STD_LOGIC;
			  Ovf : out  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component Subtraction
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           CarryIn : in  STD_LOGIC;
           CarryOut : out  STD_LOGIC;
			  Ovf : out  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component mux16to1
    Port ( input : in  STD_LOGIC_VECTOR (15 downto 0);
           sel : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC);
end component;
component Logic_And
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
	        B : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component Logic_Or
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
	        B : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component Complementary_number
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component Arithmetic_Shift
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component Right_logic_shift
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component Left_logic_shift
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component Left_cycle_rotation
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component Right_cycle_rotation
    Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
component or_gate
    Port ( A : in  STD_LOGIC;
	        B : in  STD_LOGIC;
           output : out  STD_LOGIC);
end component;
component Mux16
    Port ( input : in  	STD_LOGIC_VECTOR (15 downto 0);
           output : out  	STD_LOGIC;
           control : in  	STD_LOGIC_VECTOR (3 downto 0));
end component;
signal carry_sub,carry_add:std_logic;
signal add_output,sub_output,log_and_output,log_or_output,compl_num_output,arithm_output,r_log_shift_output,l_log_shift_output,r_cyc_output,l_cyc_output:std_logic_vector(31 downto 0);
signal temp_output:std_logic_vector(31 downto 0);
signal temp_Zero:std_logic_vector(30 downto 0);
signal Ovf_add,Ovf_sub:std_logic;
begin

  Add:Addition port map(A=>A,B=>B,CarryIn=>'0',CarryOut=>carry_add,Ovf=>Ovf_add,output=>add_output);
  Sub:Subtraction port map(A=>A,B=>B,CarryIn=>'0',CarryOut=>carry_sub,Ovf=>Ovf_sub,output=>sub_output);
  Log_And:Logic_And port map(A=>A,B=>B,output=>log_and_output);
  Log_Or:Logic_Or port map(A=>A,B=>B,output=>log_or_output);
  Com_number:Complementary_number port map(input=>A,output=>compl_num_output);
  Arith_shift:Arithmetic_Shift port map(input=>A,output=>arithm_output);
  R_Logic_shift:Right_logic_shift port map(input=>A,output=>r_log_shift_output);
  L_Logic_shift:Left_logic_shift port map(input=>A,output=>l_log_shift_output);
  R_cycle_rot:Right_cycle_rotation port map(input=>A,output=>r_cyc_output);
  L_cycle_rot:Left_cycle_rotation port map(input=>A,output=>l_cyc_output);
  
  Mux_instances:for i in 0 to 31 generate
    mux:Mux16 port map(input(0)=>add_output(i),
                          input(1)=>sub_output(i),
                          input(2)=>log_and_output(i),
								  input(3)=>log_or_output(i),
								  input(4)=>compl_num_output(i),
								  input(5)=>'0',
								  input(6)=>'0',
								  input(7)=>'0',
								  input(8)=>arithm_output(i),
								  input(9)=>l_log_shift_output(i),
								  input(10)=>r_log_shift_output(i),
                          input(11)=>'0',
								  input(12)=>l_cyc_output(i),
								  input(13)=>r_cyc_output(i),
								  input(14)=>'0',
								  input(15)=>'0',
                          control=>Op,
								  output=>temp_output(i));
  end generate;
 
 -----------------------------------------------------------------------------------------------------------
 --------------------------------------OUTPUTS--------------------------------------------------------------
 -----------------------------------------------------------------------------------------------------------
 
 ------------------------------------Mux for Cout Output----------------------------------------------------
 mux_Cout:Mux16 port map(input(0)=>carry_add,
                            input(1)=>carry_sub,
                            input(2)=>'0',
								    input(3)=>'0',
								    input(4)=>'0',
								    input(5)=>'0',
								    input(6)=>'0',
								    input(7)=>'0',
								    input(8)=>'0',
								    input(9)=>'0',
								    input(10)=>'0',
								    input(11)=>'0',
                            input(12)=>'0',
								    input(13)=>'0',
                            input(14)=>'0',
								    input(15)=>'0',
								    control=>Op,
								    output=>Cout);
 ------------------------------------Mux for Ovf Output-----------------------------------------------------
 mux_Ovf:Mux16 port map(input(0)=>Ovf_add,
                            input(1)=>Ovf_sub,
                            input(2)=>'0',
								    input(3)=>'0',
								    input(4)=>'0',
								    input(5)=>'0',
								    input(6)=>'0',
								    input(7)=>'0',
								    input(8)=>'0',
								    input(9)=>'0',
								    input(10)=>'0',
								    input(11)=>'0',
                            input(12)=>'0',
								    input(13)=>'0',
                            input(14)=>'0',
								    input(15)=>'0',
								    control=>Op,
								    output=>Ovf);
 output<=temp_output;
 ---------------------------------Or Tree for Zero Output--------------------------------------------------
 First_or_gate:or_gate port map(A=>temp_output(0),B=>temp_output(1),output=>temp_Zero(0));
 or_gate_instances:
 for i in 1 to 30 generate
    or_gates:or_gate port map(A=>temp_output(i+1),B=>temp_Zero(i-1),output=>temp_Zero(i));
 end generate; 
 Zero<=not temp_Zero(30);
end structural;