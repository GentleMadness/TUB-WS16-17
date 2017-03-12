--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:06:54 11/17/2016
-- Design Name:   
-- Module Name:   C:/Users/TOLGA/Documents/Xilinx/ConditionalSumAdder8b/ConditionalSumAdder8b_tb.vhd
-- Project Name:  ConditionalSumAdder8b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ConditionalSumAdder8b
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
 
ENTITY ConditionalSumAdder8b_tb IS
END ConditionalSumAdder8b_tb;
 
ARCHITECTURE behavior OF ConditionalSumAdder8b_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ConditionalSumAdder8b
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         S : OUT  std_logic_vector(7 downto 0);
         Cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(7 downto 0);
   signal Cout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ConditionalSumAdder8b PORT MAP (
          A => A,
          B => B,
          S => S,
          Cout => Cout
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		A<="00010110";
		B<="10010000";
      -- insert stimulus here 
		wait for 100 ns;
		A<="10010110";
		B<="10010000";
      wait;
   end process;

END;
