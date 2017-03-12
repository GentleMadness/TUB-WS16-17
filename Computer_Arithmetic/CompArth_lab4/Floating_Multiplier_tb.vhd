--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:32:29 01/27/2017
-- Design Name:   
-- Module Name:   /home/yuting/Downloads/CA_lab4/Floating_Multiplier_tb.vhd
-- Project Name:  lab4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Floating_Multiplier
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Floating_Multiplier_tb IS
END Floating_Multiplier_tb;
 
ARCHITECTURE behavior OF Floating_Multiplier_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Floating_Multiplier
    PORT(
         A : IN  std_logic_vector(22 downto 0);
         B : IN  std_logic_vector(22 downto 0);
         P : OUT  std_logic_vector(22 downto 0);
         Sign_flag : OUT  std_logic;
         Zero_flag : OUT  std_logic;
         Over_flag : OUT  std_logic;
         Under_flag : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(22 downto 0) := (others => '0');
   signal B : std_logic_vector(22 downto 0) := (others => '0');

 	--Outputs
   signal P : std_logic_vector(22 downto 0);
   signal Sign_flag : std_logic;
   signal Zero_flag : std_logic;
   signal Over_flag : std_logic;
   signal Under_flag : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Floating_Multiplier PORT MAP (
          A => A,
          B => B,
          P => P,
          Sign_flag => Sign_flag,
          Zero_flag => Zero_flag,
          Over_flag => Over_flag,
          Under_flag => Under_flag
        );
 
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
		A <= "0" & "10000001" & "10111110000000";
		B <= "1" & "01111101" & "01011110000000";
      wait for 10 ns;
		A <= "0" & "10000001" & "10111110000000";
		B <= "0" & "01111101" & "01011110000000";
		wait for 10 ns; -- OverFlow
		A <= "0" & "11111101" & "00111110000000";
		B <= "0" & "11111101" & "01011110000000";		
		wait for 10 ns; 
		A <= "1" & "01000000" & "10111110000000";
		B <= "1" & "01000000" & "01011110000000";
				wait for 10 ns; -- UnderFLow
		A <= "0" & "01000000" & "10111110000000";
		B <= "1" & "00111111" & "01011110000000";
      wait;
   end process;

END;
