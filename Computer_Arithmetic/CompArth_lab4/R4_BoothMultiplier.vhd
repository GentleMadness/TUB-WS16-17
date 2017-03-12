----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:53:40 01/05/2017 
-- Design Name: 
-- Module Name:    R4_BoothMultiplier - Behavioral 
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
use IEEE.STD_LOGIC_signed.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity R4_BoothMultiplier is
    Port ( a : in  STD_LOGIC_VECTOR (15 downto 0);--multipicant
           b : in  STD_LOGIC_VECTOR (15 downto 0);--multiplier
           res : out  STD_LOGIC_VECTOR (31 downto 0));
end R4_BoothMultiplier;

architecture Behavioral of R4_BoothMultiplier is

component PPgenBoothR4 is
    Port ( a    : in  STD_LOGIC_VECTOR (15 downto 0);--multiplicand
			  w    : in  STD_LOGIC_VECTOR (2 downto 0);-- booth bits group
           pp   : out  STD_LOGIC_VECTOR (16 downto 0)); -- partial product

end component;

component csa4to2_24b is
    Port ( A : in  STD_LOGIC_VECTOR (23 downto 0);
           B : in  STD_LOGIC_VECTOR (23 downto 0);
           C : in  STD_LOGIC_VECTOR (23 downto 0);
           D : in  STD_LOGIC_VECTOR (23 downto 0);
           SOUT: out  STD_LOGIC_VECTOR (23 downto 0);
           COUT: out  STD_LOGIC_VECTOR (23 downto 0));
end component; 

component csa4to2_32b is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           C : in  STD_LOGIC_VECTOR (31 downto 0);
           D : in  STD_LOGIC_VECTOR (31 downto 0);
           SOUT: out  STD_LOGIC_VECTOR (31 downto 0);
           COUT: out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component CarryLookAheadAdder32b is
    Port ( a : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           b : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           ci : in  STD_LOGIC;
           --C : out  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR(31 DOWNTO 0));
end component;

--- the first booth bits group-----------
signal bg : STD_LOGIC_VECTOR(2 DOWNTO 0);

-- to save some trouble, we do the sign extension here instead of buiding another module for that

-- partial products before sign extension
signal p0,p1,p2,p3,p4,p5,p6,p7: STD_LOGIC_VECTOR(16 DOWNTO 0); 

-- sign extended partial products:
signal se0,se1,se2,se3,se4,se5,se6,se7: STD_LOGIC_VECTOR(23 DOWNTO 0);

-- 4to2 csa part------
-- we use 24 bits here coz the MSB of pp4 is at 23th bit after sign extension.
signal sum1,sum2,carry1,carry2: STD_LOGIC_VECTOR(23 DOWNTO 0);
-- the outputs of the first two 4to2 csa needs to be modified into 32bit before being added together
signal s_sum1, s_sum2, s_c1, s_c2:STD_LOGIC_VECTOR(31 DOWNTO 0);
signal sum3, carry3: STD_LOGIC_VECTOR(31 DOWNTO 0);
-- carry lookahead adder part ------
signal s_c3 :STD_LOGIC_VECTOR(31 DOWNTO 0); -- carry3 needs to be shifted before CLA stage.

begin
-- set the first booth bits group mannually-------
bg <= b(1 downto 0)&"0";

-- generate 8 partial product------
pp0: PPgenBoothR4 port map(a,bg,p0);
pp1: PPgenBoothR4 port map(a,b(3 downto 1),p1);
pp2: PPgenBoothR4 port map(a,b(5 downto 3),p2);
pp3: PPgenBoothR4 port map(a,b(7 downto 5),p3);
pp4: PPgenBoothR4 port map(a,b(9 downto 7),p4);
pp5: PPgenBoothR4 port map(a,b(11 downto 9),p5);
pp6: PPgenBoothR4 port map(a,b(13 downto 11),p6);
pp7: PPgenBoothR4 port map(a,b(15 downto 13),p7);

----- sign extenstion for the 8 partial products, Figure 5 in lab instruction PDF-------

------the first 4to2csa stage, add the first 4 pp ----------------
se0 <= "0000" & (not p0(16)) & p0(16) & p0(16) & p0;
se1 <= "0001" & (not p1(16)) & p1 & "00";
se2 <= "01" & (not p2(16)) & p2 & "0000";
se3 <= not(p3(16)) & p3 & "000000";
---------the second 4to2csa stage----------------------
se4 <= "000001" & (not p4(16)) & p4;
se5 <= "0001" & (not p5(16)) & p5 & "00";
se6 <= "01" & (not p6(16)) & p6 & "0000";
se7 <= not(p7(16)) & p7 & "000000";

-------- first 4to2csa stage addition----------
counter_1: csa4to2_24b port map (se0, se1, se2, se3, sum1, carry1);

-------- Second 4to2csa stage ----------
counter_2: csa4to2_24b port map (se4, se5, se6, se7, sum2, carry2);

-------- Third 4to2csa stage, add sum1,sum2,carry1,carry2 together-------
--need to shift the 4 numbers before use a csa again--------------
s_sum1 <= "00000001" & sum1; ----- add the missing 1 in the sign extension part of p3 back.
s_sum2 <= sum2 & "00000000";
s_c1 <= "0000000" & carry1 & "0";
s_c2 <= carry2(22 downto 0) & "000000000";
---- add together -----------
counter_3: csa4to2_32b port map (s_sum1, s_sum2, s_c1, s_c2, sum3, carry3);  

------ Final Products generated by 32bit CLA -------------
s_c3 <= carry3(30 downto 0) & "0"; --shift before do the final addition
cla: CarryLookAheadAdder32b port map(sum3,s_c3,'0',res);

end Behavioral;

