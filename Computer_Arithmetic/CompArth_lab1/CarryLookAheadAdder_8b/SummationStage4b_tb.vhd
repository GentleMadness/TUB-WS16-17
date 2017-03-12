--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:21:00 11/16/2016
-- Design Name:   
-- Module Name:   C:/Users/TOLGA/Documents/Xilinx/CarryLookAheadAdder8b/SummationStage_tb.vhd
-- Project Name:  CarryLookAheadAdder8b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SummationStage
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
 
ENTITY SummationStage4b_tb IS
END SummationStage4b_tb;
 
ARCHITECTURE behavior OF SummationStage4b_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SummationStage4b
    PORT(
         p : IN  std_logic_vector(3 downto 0);
         c : IN  std_logic_vector(2 downto 0);
         ci : IN  std_logic;
         sum : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal p : std_logic_vector(3 downto 0) := (others => '0');
   signal c : std_logic_vector(2 downto 0) := (others => '0');
   signal ci : std_logic := '0';

 	--Outputs
   signal sum : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SummationStage4b PORT MAP (
          p => p,
          c => c,
          ci => ci,
          sum => sum
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		p <= "1111";
		c <= "001";
		ci<= '1';
		wait for 100 ns;
		p <= "1111";
		c <= "001";
		ci<= '0';
		

      -- insert stimulus here 

      wait;
   end process;

END;
