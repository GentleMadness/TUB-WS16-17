----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:21:57 12/17/2016 
-- Design Name: 
-- Module Name:    reg16 - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg16 is
    Port ( clk : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (10 downto 0);
           q0 : out  STD_LOGIC_VECTOR (10 downto 0);
           q1 : out  STD_LOGIC_VECTOR (10 downto 0);
           q2 : out  STD_LOGIC_VECTOR (10 downto 0);
           q3 : out  STD_LOGIC_VECTOR (10 downto 0);
           q4 : out  STD_LOGIC_VECTOR (10 downto 0);
           q5 : out  STD_LOGIC_VECTOR (10 downto 0);
           q6 : out  STD_LOGIC_VECTOR (10 downto 0);
           q7 : out  STD_LOGIC_VECTOR (10 downto 0);
           q8 : out  STD_LOGIC_VECTOR (10 downto 0);
           q9 : out  STD_LOGIC_VECTOR (10 downto 0);
           q10 : out  STD_LOGIC_VECTOR (10 downto 0);
           q11 : out  STD_LOGIC_VECTOR (10 downto 0);
           q12 : out  STD_LOGIC_VECTOR (10 downto 0);
           q13 : out  STD_LOGIC_VECTOR (10 downto 0);
           q14 : out  STD_LOGIC_VECTOR (10 downto 0);
           q15 : out  STD_LOGIC_VECTOR (10 downto 0);
           rst : in  STD_LOGIC);
end reg16; 

architecture Behavioral of reg16 is

component Register_11b is
    Port ( d : in  STD_LOGIC_VECTOR (10 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR (10 downto 0));
end component;

signal qq0,qq1,qq2,qq3,qq4,qq5,qq6,qq7,qq8,qq9,qq10,qq11,qq12,qq13,qq14,qq15: STD_LOGIC_VECTOR (10 downto 0);
signal cnt: STD_LOGIC_VECTOR (3 downto 0);

begin

u0: Register_11b port map (input, clk, rst, qq0);
u1: Register_11b port map (qq0, clk, rst, qq1);
u2: Register_11b port map (qq1, clk, rst, qq2);
u3: Register_11b port map (qq2, clk, rst, qq3);
u4: Register_11b port map (qq3, clk, rst, qq4);
u5: Register_11b port map (qq4, clk, rst, qq5);
u6: Register_11b port map (qq5, clk, rst, qq6);
u7: Register_11b port map (qq6, clk, rst, qq7);
u8: Register_11b port map (qq7, clk, rst, qq8);
u9: Register_11b port map (qq8, clk, rst, qq9);
u10: Register_11b port map (qq9, clk, rst, qq10);
u11: Register_11b port map (qq10, clk, rst, qq11);
u12: Register_11b port map (qq11, clk, rst, qq12);
u13: Register_11b port map (qq12, clk, rst, qq13);
u14: Register_11b port map (qq13, clk, rst, qq14);
u15: Register_11b port map (qq14, clk, rst, qq15);
-- Output is generated every 16 clock cycles. Use counter to countrol the frequency.

process (clk, rst)
 begin
 if clk'event and clk = '1' then
	 --q <= d; 
    q0 <= qq0;  q1 <= qq1;  q2 <= qq2;  q3 <= qq3;
	 q4 <= qq4;  q5 <= qq5;  q6 <= qq6;  q7 <= qq7;
	 q8 <= qq8;  q9 <= qq9;  q10 <= qq10;  q11 <= qq11;
	 q12 <= qq12; q13 <= qq13; q14 <= qq14; q15 <= qq15;
 end if;


	end process;
end Behavioral;

