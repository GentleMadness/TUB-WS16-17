--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:14:53 01/05/2017
-- Design Name:   
-- Module Name:   /home/yuting/Documents/Computer Arithmetics/MultiplicativeDivider/PPgenBoothR4_tb.vhd
-- Project Name:  MultiplicativeDivider
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PPgenBoothR4
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
 
ENTITY PPgenBoothR4_tb IS
END PPgenBoothR4_tb;
 
ARCHITECTURE behavior OF PPgenBoothR4_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PPgenBoothR4
    PORT(
         a : IN  std_logic_vector(15 downto 0);
         w : IN  std_logic_vector(2 downto 0);
         pp : OUT  std_logic_vector(16 downto 0);
         sig : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(15 downto 0) := (others => '0');
   signal w : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal pp : std_logic_vector(16 downto 0);
   signal sig : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PPgenBoothR4 PORT MAP (
          a => a,
          w => w,
          pp => pp,
          sig => sig
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
			a <= "0000111100001111";
			w <= "101";
      wait for 100 ns;	
			a <= "0000111100000000";
			w <= "101";
		wait for 100 ns;
			a <= "1100110011001100";
			w <= "111";
		wait for 100 ns;
			a <= "1100110011001100";
			w <= "100";
		wait for 100 ns;
			a <= "1100110011001100";
			w <= "001";
      -- insert stimulus here 

      wait;
   end process;

END;
