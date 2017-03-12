--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:06:46 11/16/2016
-- Design Name:   
-- Module Name:   C:/Users/TOLGA/Documents/Xilinx/CarryLookAheadAdder8b/CarryLookAheadStage4b_tb.vhd
-- Project Name:  CarryLookAheadAdder8b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CarryLookAheadStage4b
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
 
ENTITY CarryLookAheadStage4b_tb IS
END CarryLookAheadStage4b_tb;
 
ARCHITECTURE behavior OF CarryLookAheadStage4b_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CarryLookAheadStage4b
    PORT(
         g : IN  std_logic_vector(3 downto 0);
         p : IN  std_logic_vector(3 downto 0);
         ci : IN  std_logic;
         co : OUT  std_logic_vector(2 downto 0);
         co2 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal g : std_logic_vector(3 downto 0) := (others => '0');
   signal p : std_logic_vector(3 downto 0) := (others => '0');
   signal ci : std_logic := '0';

 	--Outputs
   signal co : std_logic_vector(2 downto 0);
   signal co2 : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CarryLookAheadStage4b PORT MAP (
          g => g,
          p => p,
          ci => ci,
          co => co,
          co2 => co2
        );



   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		g <= "0011";
		p <= "0011";
		ci<= '0';
		wait for 100 ns;
		
		g <= "0011";
		p <= "0011";
		ci<= '1';
		wait for 100 ns;
		
		g <= "1111";
		p <= "1111";
		ci<= '0';
		wait for 100 ns;
		
		g <= "1111";
		p <= "1111";
		ci<= '1';
		wait for 100 ns;
		g <= "0000";
		p <= "0000";
		ci<= '0';
		wait for 100 ns;
		g <= "0000";
		p <= "0011";
		ci<= '0';
		wait for 100 ns;
		g <= "0000";
		p <= "0011";
		ci<= '1';
      -- insert stimulus here 

      wait;
   end process;

END;
