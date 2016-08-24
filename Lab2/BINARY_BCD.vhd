----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:09:15 01/20/2016 
-- Design Name: 
-- Module Name:    BINARY_BCD - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BINARY_BCD is
		generic( NUMBITS : integer := 32);
    Port ( BINARY : in  STD_LOGIC_VECTOR (NUMBITS-1 downto 0);
           BCD : out  STD_LOGIC_VECTOR (NUMBITS-1 downto 0));
end BINARY_BCD;

architecture Behavioral of BINARY_BCD is
begin
		PROCESS(BINARY)
		variable digit : STD_LOGIC_VECTOR(NUMBITS-1 downto 0) := (others => '0');
		variable temp : STD_LOGIC_VECTOR (NUMBITS-1 downto 0) := (others => '0');
		begin
				for i in 0 to (NUMBITS/4)-1 loop
					digit := BINARY mod 10;
					temp := temp + digit((i*4)+3 downto (i*4));
					data := data / 10;
				end loop;
				BCD <= STD_LOGIC_VECTOR (to_unsigned(temp, NUMBITS));
		end process;
end Behavioral;

