--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:35:59 01/06/2016
-- Design Name:   
-- Module Name:   /home/csmajs/mxu008/Desktop/lab1/my_alu_tb.vhd
-- Project Name:  lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: my_alu
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
USE ieee.std_logic_arith.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY my_alu_tb IS
END my_alu_tb;
 
ARCHITECTURE behavior OF my_alu_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT my_alu
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         opcode : IN  std_logic_vector(2 downto 0);
         result : OUT  std_logic_vector(7 downto 0);
         carryout : OUT  std_logic;
         overflow : OUT  std_logic;
         zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal opcode : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(7 downto 0) := (others => '0'); 
   signal carryout : std_logic := '0' ; 
   signal overflow : std_logic := '0' ;
   signal zero : std_logic := '0';
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
	signal clock: std_logic;
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: my_alu PORT MAP (
          A => A,
          B => B,
          opcode => opcode,
          result => result,
          carryout => carryout,
          overflow => overflow,
          zero => zero
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
			wait for 10 ns;
			-- ------------------------------------------------------------
			-- Unsigned Add
			-- ------------------------------------------------------------
			report "Unsigned Add";
			opcode <= "000";
					-- Test #1
					A <= conv_std_logic_vector(4, 8);
					B <= conv_std_logic_vector(4, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(8,8)		report "Test_1: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_1: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_1: overflow incorrect"		severity warning;
					assert zero = '0'			report "Test_1: zero incorrect"			severity warning;
					
					-- Test #2
					A <= conv_std_logic_vector(0, 8);
					B <= conv_std_logic_vector(0, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(0,8)		report "Test_2: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_2: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_2: overflow incorrect"		severity warning;
					assert zero = '1'			report "Test_2: zero incorrect"			severity warning;
					
					-- Test #3
					A <= conv_std_logic_vector(255, 8);
					B <= conv_std_logic_vector(1, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(0,8)		report "Test_3: Result incorrect"	severity warning;
					assert carryout = '1' 	report "Test_3: carryout incorrect"		severity warning;
					assert overflow = '1'	report "Test_3: overflow incorrect"		severity warning;
					assert zero = '0'			report "Test_3: zero incorrect"			severity warning;
				
			wait for 10 ns;
			-- -----------------------------------------------------------
			-- Signed Add
			-- -----------------------------------------------------------
			report "signed Add";
			opcode <= "001";
					-- Test #1
					A <= conv_std_logic_vector(0, 8);
					B <= conv_std_logic_vector(0, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(0,8)		report "Test_1: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_1: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_1: overflow incorrect"		severity warning;
					assert zero = '1'			report "Test_1: zero incorrect"			severity warning;
					
					-- Test #2
					A <= conv_std_logic_vector(-2, 8);
					B <= conv_std_logic_vector(-2, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(-4,8)		report "Test_2: Result incorrect"	severity warning;
					assert carryout = '1' 	report "Test_2: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_2: overflow incorrect"		severity warning;
					assert zero = '0'			report "Test_2: zero incorrect"			severity warning;
					
					-- Test #3
					A <= conv_std_logic_vector(-128, 8);
					B <= conv_std_logic_vector(-1, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(127,8)		report "Test_3: Result incorrect"	severity warning;
					assert carryout = '1' 	report "Test_3: carryout incorrect"		severity warning;
					assert overflow = '1'	report "Test_3: overflow incorrect"		severity warning;
					assert zero = '0'			report "Test_3: zero incorrect"			severity warning;
					
					-- Test #4
					A <= conv_std_logic_vector(10, 8);
					B <= conv_std_logic_vector(-15, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(-5,8)		report "Test_4: Result incorrect"	severity warning;
					assert carryout = '1' 	report "Test_4: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_4: overflow incorrect"		severity warning;
					assert zero = '0'			report "Test_4: zero incorrect"			severity warning;
					wait for 10 ns;
			-- ------------------------------------------------------------
			-- Unsigned Sub
			-- ------------------------------------------------------------
			report "Unsigned Sub";
			opcode <= "010";
					-- Test #1
					A <= conv_std_logic_vector(4, 8);
					B <= conv_std_logic_vector(2, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(2,8)		report "Test_1: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_1: carryout incorrect"		severity warning;
					assert overflow = '1'	report "Test_1: overflow incorrect"		severity warning;
					assert zero = '0'			report "Test_1: zero incorrect"			severity warning;
					
					-- Test #2
					A <= conv_std_logic_vector(0, 8);
					B <= conv_std_logic_vector(0, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(0,8)		report "Test_2: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_2: carryout incorrect"		severity warning;
					assert overflow = '1'	report "Test_2: overflow incorrect"		severity warning;
					assert zero = '1'			report "Test_2: zero incorrect"			severity warning;
					
					-- Test #3
					A <= conv_std_logic_vector(128, 8);
					B <= conv_std_logic_vector(1, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(127,8)		report "Test_3: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_3: carryout incorrect"		severity warning;
					assert overflow = '1'	report "Test_3: overflow incorrect"		severity warning;
					assert zero = '0'			report "Test_3: zero incorrect"			severity warning;
				
					wait for 10 ns;
					
			-- -----------------------------------------------------------
			-- Signed Sub
			-- -----------------------------------------------------------
			
			report "signed Sub";
			opcode <= "011";
					-- Test #1
					A <= conv_std_logic_vector(0, 8);
					B <= conv_std_logic_vector(0, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(0,8)		report "Test_1: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_1: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_1: overflow incorrect"		severity warning;
					assert zero = '1'			report "Test_1: zero incorrect"			severity warning;
					
					-- Test #2
					A <= conv_std_logic_vector(-2, 8);
					B <= conv_std_logic_vector(-2, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(0,8)		report "Test_2: Result incorrect"	severity warning;
					assert carryout = '0'	report "Test_2: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_2: overflow incorrect"		severity warning;
					assert zero = '1'			report "Test_2: zero incorrect"			severity warning;
					
					-- Test #3
					A <= conv_std_logic_vector(-128, 8);
					B <= conv_std_logic_vector(-1, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(-127,8)		report "Test_3: Result incorrect"	severity warning;
					assert carryout = '1' 	report "Test_3: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_3: overflow incorrect"		severity warning;
					assert zero = '0'			report "Test_3: zero incorrect"			severity warning;
					
					-- Test #4
					A <= conv_std_logic_vector(10, 8);
					B <= conv_std_logic_vector(-15, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(25,8)		report "Test_4: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_4: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_4: overflow incorrect"		severity warning;
					assert zero = '0'			report "Test_4: zero incorrect"			severity warning;
					
					wait for 10 ns;
			-- ------------------------------------------------------------
			-- Bitwise And
			-- ------------------------------------------------------------
			report "Bitwise And";
			opcode <= "100";
					-- Test #1
					A <= conv_std_logic_vector(0, 8);
					B <= conv_std_logic_vector(0, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(0,8)		report "Test_1: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_1: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_1: overflow incorrect"		severity warning;
					assert zero = '1'			report "Test_1: zero incorrect"			severity warning;
					
					-- Test #2
					A <= conv_std_logic_vector(1, 8);
					B <= conv_std_logic_vector(2, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(0,8)		report "Test_2: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_2: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_2: overflow incorrect"		severity warning;
					assert zero = '1'			report "Test_2: zero incorrect"			severity warning;
					
					-- Test #3
					A <= conv_std_logic_vector(255, 8);
					B <= conv_std_logic_vector(255, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(255,8)		report "Test_3: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_3: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_3: overflow incorrect"		severity warning;
					assert zero = '0'			report "Test_3: zero incorrect"			severity warning;
			
			wait for 10 ns;
			-- ------------------------------------------------------------
			-- Bitwise Or
			-- ------------------------------------------------------------
			
			report "Bitwise Or";
			opcode <= "101";
			
					-- Test #1
					A <= conv_std_logic_vector(0, 8);
					B <= conv_std_logic_vector(0, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(0,8)		report "Test_1: Result incorrect"	severity warning;
					assert carryout = '0'	report "Test_1: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_1: overflow incorrect"		severity warning;
					assert zero = '1'			report "Test_1: zero incorrect"			severity warning;
					
					-- Test #2
					A <= conv_std_logic_vector(1, 8);
					B <= conv_std_logic_vector(2, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(3,8)		report "Test_2: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_2: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_2: overflow incorrect"		severity warning;
					assert zero = '0'			report "Test_2: zero incorrect"			severity warning;
					
					-- Test #3
					A <= conv_std_logic_vector(255, 8);
					B <= conv_std_logic_vector(255, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(255,8)		report "Test_3: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_3: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_3: overflow incorrect"		severity warning;
					assert zero = '0'			report "Test_3: zero incorrect"			severity warning;
					
			wait for 10 ns;
			-- ------------------------------------------------------------
			-- Bitwise Xor
			-- ------------------------------------------------------------
			
			report "Bitwise Xor";
			opcode <= "110";
			
					-- Test #1
					A <= conv_std_logic_vector(0, 8);
					B <= conv_std_logic_vector(0, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(0,8)		report "Test_1: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_1: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_1: overflow incorrect"		severity warning;
					assert zero = '1'			report "Test_1: zero incorrect"			severity warning;
					
					-- Test #2
					A <= conv_std_logic_vector(1, 8);
					B <= conv_std_logic_vector(2, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(3,8)		report "Test_2: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_2: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_2: overflow incorrect"		severity warning;
					assert zero = '0'			report "Test_2: zero incorrect"			severity warning;
					
					-- Test #3
					A <= conv_std_logic_vector(255, 8);
					B <= conv_std_logic_vector(255, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(0,8)		report "Test_3: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_3: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_3: overflow incorrect"		severity warning;
					assert zero = '1'			report "Test_3: zero incorrect"			severity warning;
			
			wait for 10 ns;
			-- ------------------------------------------------------------
			-- Divide A by 2
			-- ------------------------------------------------------------
			report "Divide A by 2";
			opcode <= "111";
					-- Test #1
					A <= conv_std_logic_vector(0, 8);
					B <= conv_std_logic_vector(0, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(0,8)		report "Test_1: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_1: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_1: overflow incorrect"		severity warning;
					assert zero = '1'			report "Test_1: zero incorrect"			severity warning;
					
					-- Test #2
					A <= conv_std_logic_vector(2, 8);
					B <= conv_std_logic_vector(0, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(1,8)		report "Test_2: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_2: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_2: overflow incorrect"		severity warning;
					assert zero = '0'			report "Test_2: zero incorrect"			severity warning;
					
					-- Test #3
					A <= conv_std_logic_vector(255, 8);
					B <= conv_std_logic_vector(255, 8);
					
					wait for 10 ns;
					assert result = conv_std_logic_vector(127,8)		report "Test_3: Result incorrect"	severity warning;
					assert carryout = '0' 	report "Test_3: carryout incorrect"		severity warning;
					assert overflow = '0'	report "Test_3: overflow incorrect"		severity warning;
					assert zero = '0'			report "Test_3: zero incorrect"			severity warning;
      wait for clock_period * 10;

      -- insert stimulus here 

      wait;
   end process;

END;
