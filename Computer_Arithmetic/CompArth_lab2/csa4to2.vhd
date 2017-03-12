----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:11:41 11/30/2016 
-- Design Name: 
-- Module Name:    csa4to2 - Behavioral 
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
 
entity csa4to2 is
    Port ( A : in  STD_LOGIC_VECTOR (14 downto 0);
           B : in  STD_LOGIC_VECTOR (14 downto 0);
           C : in  STD_LOGIC_VECTOR (14 downto 0);
           D : in  STD_LOGIC_VECTOR (14 downto 0);
           SOUT : out  STD_LOGIC_VECTOR (14 downto 0);
           COUT : out  STD_LOGIC_VECTOR (14 downto 0));
end csa4to2;

architecture Behavioral of csa4to2 is

component counter4to2 is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c : in  STD_LOGIC;
           d : in  STD_LOGIC;
			  ti: in  STD_LOGIC;
			  t_o: out  STD_LOGIC;
           cout : out  STD_LOGIC;
           s : out  STD_LOGIC);
end component;
signal t_i : STD_LOGIC :='0';
signal t_out : STD_LOGIC_VECTOR(14 downto 0);

begin
u0 : counter4to2 port map  (A(0),  B(0),  C(0),  D(0),  t_i,       t_out(0),  COUT(0),  SOUT(0));
u1 : counter4to2 port map  (A(1),  B(1),  C(1),  D(1),  t_out(0),  t_out(1),  COUT(1),  SOUT(1));
u2 : counter4to2 port map  (A(2),  B(2),  C(2),  D(2),  t_out(1),  t_out(2),  COUT(2),  SOUT(2));
u3 : counter4to2 port map  (A(3),  B(3),  C(3),  D(3),  t_out(2),  t_out(3),  COUT(3),  SOUT(3));
u4 : counter4to2 port map  (A(4),  B(4),  C(4),  D(4),  t_out(3),  t_out(4),  COUT(4),  SOUT(4));
u5 : counter4to2 port map  (A(5),  B(5),  C(5),  D(5),  t_out(4),  t_out(5),  COUT(5),  SOUT(5));
u6 : counter4to2 port map  (A(6),  B(6),  C(6),  D(6),  t_out(5),  t_out(6),  COUT(6),  SOUT(6));
u7 : counter4to2 port map  (A(7),  B(7),  C(7),  D(7),  t_out(6),  t_out(7),  COUT(7),  SOUT(7));
u8 : counter4to2 port map  (A(8),  B(8),  C(8),  D(8),  t_out(7),  t_out(8),  COUT(8),  SOUT(8));
u9 : counter4to2 port map  (A(9),  B(9),  C(9),  D(9),  t_out(8),  t_out(9),  COUT(9),  SOUT(9));
u10 : counter4to2 port map (A(10), B(10), C(10), D(10), t_out(9),  t_out(10), COUT(10), SOUT(10));
u11 : counter4to2 port map (A(11), B(11), C(11), D(11), t_out(10), t_out(11), COUT(11), SOUT(11));
u12 : counter4to2 port map (A(12), B(12), C(12), D(12), t_out(11), t_out(12), COUT(12), SOUT(12));
u13 : counter4to2 port map (A(13), B(13), C(13), D(13), t_out(12), t_out(13), COUT(13), SOUT(13));
u14 : counter4to2 port map (A(14), B(14), C(14), D(14), t_out(13), t_out(14), COUT(14), SOUT(14));

end Behavioral;

