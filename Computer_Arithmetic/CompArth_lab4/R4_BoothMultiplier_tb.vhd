--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:54:45 01/06/2017
-- Design Name:   
-- Module Name:   /home/yuting/Documents/Computer Arithmetics/MultiplicativeDivider/R4_BoothMultiplier_tb.vhd
-- Project Name:  MultiplicativeDivider
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: R4_BoothMultiplier
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
 
ENTITY R4_BoothMultiplier_tb IS
END R4_BoothMultiplier_tb;
 
ARCHITECTURE behavior OF R4_BoothMultiplier_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT R4_BoothMultiplier
    PORT(
         a : IN  std_logic_vector(15 downto 0);
         b : IN  std_logic_vector(15 downto 0);
         res : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(15 downto 0) := (others => '0');
   signal b : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal res : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: R4_BoothMultiplier PORT MAP (
          a => a,
          b => b,
          res => res
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
			a <= "0000111100001111";
			b <= "0000000000010101";
      wait for 100 ns;	
			a <= "0000111100001111";
			b <= "1111111111100101";
		wait for 100 ns;	
			a <= "1111111100001111";
			b <= "0000000000110100";
		wait for 100 ns;	
			a <= "1111111110001111";
			b <= "1111110000010100";
      -- insert stimulus here 

      wait;
   end process;

END;
