----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:51:40 01/06/2016 
-- Design Name: 
-- Module Name:    my_alu - Behavioral 
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
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

---------------------------------------------------------------------------------

entity my_alu is
		generic( NUMBITS : natural := 8);
    Port ( A : in  STD_LOGIC_VECTOR (NUMBITS-1 downto 0);
           B : in  STD_LOGIC_VECTOR (NUMBITS-1 downto 0);
           opcode : in  STD_LOGIC_VECTOR (2 downto 0);
           result : out  STD_LOGIC_VECTOR (NUMBITS-1 downto 0);
           carryout : out  STD_LOGIC;
           overflow : out  STD_LOGIC;
           zero : out  STD_LOGIC);
end my_alu;

---------------------------------------------------------------------------------

architecture Behavioral of my_alu is

signal total : STD_LOGIC_VECTOR(NUMBITS downto 0) := (others => '0');

begin
	process(A,B,opcode,total)
	begin
		case opcode is
			-- Unsigned add operation
			when "000" =>
				total <= STD_LOGIC_VECTOR((unsigned('0' & A) + unsigned('0' & B)));
				carryout <= total(NUMBITS);
				overflow <= total(NUMBITS);
			
			-- Signed add operation
			when "001" =>
				total <= STD_LOGIC_VECTOR((A(NUMBITS-1) & signed(A)) + (B(NUMBITS-1) & signed(B)));
				if ((A(NUMBITS-1) = '0' and B(NUMBITS-1) = '0' and total(NUMBITS-1) = '1') or (A(NUMBITS-1) = '1' and B(NUMBITS-1) = '1' and total(NUMBITS-1) = '0'))
					then overflow <= '1';
				else
					overflow <= '0';
				end if;
				
				
			-- Unsigned sub operation
			when "010" =>
				total <= STD_LOGIC_VECTOR(('0' & unsigned(A)) - (('0' & unsigned(B))));
				overflow <= not total(NUMBITS);
			
			-- Signed sub operation
			when "011" =>
				total <= STD_LOGIC_VECTOR((A(NUMBITS-1) & signed(A)) - (B(NUMBITS-1) & signed(B)));
				if ((A(NUMBITS-1) = '0' and B(NUMBITS-1) = '1' and total(NUMBITS-1) = '1') or (A(NUMBITS-1) = '1' and B(NUMBITS-1) = '0' and total(NUMBITS-1) = '0'))
					then overflow <= '1';
				else
					overflow <= '0';
				end if;
			
			when "100" =>
				total <= STD_LOGIC_VECTOR('0' & (A and B));
				overflow <= '0';
			
			when "101" =>
				total <= STD_LOGIC_VECTOR('0' & (A or B));
				overflow <= '0';

			when "110" =>
				total <= STD_LOGIC_VECTOR('0' & (A xor B));
				overflow <= '0';

			when "111" =>
				total <= STD_LOGIC_VECTOR("00" & A(NUMBITS - 1 downto 1));
				overflow <= '0';
				
			when OTHERS =>

		end case;
		carryout <= total(NUMBITS);
		result <= total(NUMBITS-1 downto 0);
		if (total = 0)
			then zero <= '1';
		else
			zero <= '0';
		end if;
		
	end process;
	
end Behavioral;

