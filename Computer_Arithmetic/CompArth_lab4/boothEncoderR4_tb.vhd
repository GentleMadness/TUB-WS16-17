--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   07:44:40 01/04/2017
-- Design Name:   
-- Module Name:   C:/Users/TOLGA/Documents/Xilinx/MultiplicativeDivider/boothEncoderR4_tb.vhd
-- Project Name:  MultiplicativeDivider
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: boothEncoderR4
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
 
ENTITY boothEncoderR4_tb IS
END boothEncoderR4_tb;
 
ARCHITECTURE behavior OF boothEncoderR4_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT boothEncoderR4
    PORT(
         w : IN  std_logic_vector(2 downto 0);
         sel1 : OUT  std_logic;
         sel2 : OUT  std_logic;
         s : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal w : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal sel1 : std_logic;
   signal sel2 : std_logic;
   signal s : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 --  constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: boothEncoderR4 PORT MAP (
          w => w,
          sel1 => sel1,
          sel2 => sel2,
          s => s
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
			w <= "110";
		wait for 10 ns;
			w <= "011";
      wait;
   end process;

END;
