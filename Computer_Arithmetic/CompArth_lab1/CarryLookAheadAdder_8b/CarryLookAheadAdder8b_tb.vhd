--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:42:40 11/16/2016
-- Design Name:   
-- Module Name:   /home/yuting/Documents/Computer Arithmetics/CLAA8bit/CarryLookaheadAdder8b_tb.vhd
-- Project Name:  CarryLookAheadAdder4b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CarryLookaheadAdder8b
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
 
ENTITY CarryLookaheadAdder8b_tb IS
END CarryLookaheadAdder8b_tb;
 
ARCHITECTURE behavior OF CarryLookaheadAdder8b_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CarryLookaheadAdder8b
    PORT(
         a : IN  std_logic_vector(7 downto 0);
         b : IN  std_logic_vector(7 downto 0);
         ci : IN  std_logic;
         C : OUT  std_logic;
         S : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(7 downto 0) := (others => '0');
   signal b : std_logic_vector(7 downto 0) := (others => '0');
   signal ci : std_logic := '0';

 	--Outputs
   signal C : std_logic;
   signal S : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CarryLookaheadAdder8b PORT MAP (
          a => a,
          b => b,
          ci => ci,
          C => C,
          S => S
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
			a <= "10000000";
			b <= "10010011";
			ci <= '1';
      wait for 100 ns;
			a <= "10000000";
			b <= "10010011";
			ci <= '0';
	   wait for 100 ns;	
			a <= "00100000";
			b <= "01110011";
			ci <= '1';
      wait for 100 ns;
			a <= "00100000";
			b <= "01110011";
			ci <= '0';
      wait;
   end process;

END;
