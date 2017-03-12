----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:13:02 12/03/2016 
-- Design Name: 
-- Module Name:    CSA_16_Input - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CSA_16_Input is
    Port ( s0 : in  STD_LOGIC_VECTOR (10 downto 0);
           s1 : in  STD_LOGIC_VECTOR (10 downto 0);
           s2 : in  STD_LOGIC_VECTOR (10 downto 0);
           s3 : in  STD_LOGIC_VECTOR (10 downto 0);
           s4 : in  STD_LOGIC_VECTOR (10 downto 0);
           s5 : in  STD_LOGIC_VECTOR (10 downto 0);
           s6 : in  STD_LOGIC_VECTOR (10 downto 0);
           s7 : in  STD_LOGIC_VECTOR (10 downto 0);
           s8 : in  STD_LOGIC_VECTOR (10 downto 0);
           s9 : in  STD_LOGIC_VECTOR (10 downto 0);
           s10 : in  STD_LOGIC_VECTOR (10 downto 0);
           s11 : in  STD_LOGIC_VECTOR (10 downto 0);
           s12 : in  STD_LOGIC_VECTOR (10 downto 0);
           s13 : in  STD_LOGIC_VECTOR (10 downto 0);
           s14 : in  STD_LOGIC_VECTOR (10 downto 0);
           s15 : in  STD_LOGIC_VECTOR (10 downto 0);
			  COUT : out STD_LOGIC;			  
           SUM : out  STD_LOGIC_VECTOR (10 downto 0)
			  );
end CSA_16_Input;

architecture Behavioral of CSA_16_Input is

component Sign_Extension is
    Port ( sin : in  STD_LOGIC_VECTOR (10 downto 0);
           sout : out  STD_LOGIC_VECTOR (14 downto 0));
end component; 

component csa4to2 is
    Port ( A : in  STD_LOGIC_VECTOR (14 downto 0);
           B : in  STD_LOGIC_VECTOR (14 downto 0);
           C : in  STD_LOGIC_VECTOR (14 downto 0);
           D : in  STD_LOGIC_VECTOR (14 downto 0);
           SOUT : out  STD_LOGIC_VECTOR (14 downto 0);
           COUT : out  STD_LOGIC_VECTOR (14 downto 0)
			  );
end component;
   
component CarryLookAheadAdder15b is
    Port ( a : in  STD_LOGIC_VECTOR(14 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR(14 DOWNTO 0);
           ci : in  STD_LOGIC;
           C : out  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR(14 DOWNTO 0));
end component;

component Shifting4bits_Right is
    Port ( CSA_sum : in  STD_LOGIC_VECTOR (14 downto 0);
           Final_Res : out  STD_LOGIC_VECTOR (10 downto 0));
end component;

signal se0,se1,se2,se3,se4,se5,se6,se7,se8,se9,se10,se11,se12,se13,se14,se15 : STD_LOGIC_VECTOR(14 downto 0);
signal st00, st01,st02,st03,st04,st05,st06,st07 : STD_LOGIC_VECTOR (14 downto 0);
signal st10, st11,st12,st13 : STD_LOGIC_VECTOR (14 downto 0);
signal st20, st21 : STD_LOGIC_VECTOR (14 downto 0);
signal st011, st033, st055, st077, st111, st133, st211 : STD_LOGIC_VECTOR (14 downto 0);
signal ci_0 : STD_LOGIC := '0';
--signal carryout : STD_LOGIC;
signal sumout : STD_LOGIC_VECTOR (14 DOWNTO 0);

begin 
--Sign Extension Stage
u0 : Sign_Extension port map (s0,se0);
u1 : Sign_Extension port map (s1,se1);
u2 : Sign_Extension port map (s2,se2);
u3 : Sign_Extension port map (s3,se3);
u4 : Sign_Extension port map (s4,se4);
u5 : Sign_Extension port map (s5,se5);
u6 : Sign_Extension port map (s6,se6);
u7 : Sign_Extension port map (s7,se7);
u8 : Sign_Extension port map (s8,se8);
u9 : Sign_Extension port map (s9,se9);
u10 : Sign_Extension port map (s10,se10);
u11 : Sign_Extension port map (s11,se11);
u12 : Sign_Extension port map (s12,se12);
u13 : Sign_Extension port map (s13,se13); 
u14 : Sign_Extension port map (s14,se14);
u15 : Sign_Extension port map (s15,se15);
-- First 4to2 Counter Stage, 16 to 8    
u16 : csa4to2 port map (se0,se1,se2,se3,st00,st01);
u17 : csa4to2 port map (se4,se5,se6,se7,st02,st03);  
u18 : csa4to2 port map (se8,se9,se10,se11,st04,st05);
u19 : csa4to2 port map (se12,se13,se14,se15,st06,st07);

-- Shift carry 1-bit to the left, throw away the MSB
st011 <= st01(13 downto 0) & '0';
st033 <= st03(13 downto 0) & '0';
st055 <= st05(13 downto 0) & '0';
st077 <= st07(13 downto 0) & '0';

-- Second 4to2 Counter Stage, 8 to 4
u20 : csa4to2 port map (st00,st011,st02,st033,st10,st11);
u21 : csa4to2 port map (st04,st055,st06,st077,st12,st13);

-- Shift carry 1-bit to the left, throw away the MSB
st111 <= st11(13 downto 0) & '0';
st133 <= st13(13 downto 0) & '0';

-- Third 4to2 Counter Stage, 4 to 2
u22 : csa4to2 port map (st10,st111,st12,st133,st20,st21);

-- Shift C 1-bit to the left, throw away the MSB
st211 <= st21(13 downto 0) & '0';

-- Fast Adder
u23 : CarryLookAheadAdder15b port map (st20,st211,ci_0,COUT, sumout);

u24: Shifting4bits_Right port map(sumout, SUM);
--se00 <= st00;
--se011 <= st01;
--se22 <= st02;
--se33 <= st03;
--se44 <= st04;
--se55 <= st05;
--se66 <= st06;
--se77 <= st07;
--se88 <= st10;
--se99 <= st11;
--se100 <= st12;
--se111 <= st13;
--se122 <= st20;
--se133 <= st20;
--se144 <= st21;
--se155 <= st21;

end Behavioral;
