----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:53:58 01/20/2016 
-- Design Name: 
-- Module Name:    BCD_BINARY - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BCD_BINARY is
		generic( NUMBITS : integer := 32);
    Port ( BCD : in  STD_LOGIC_VECTOR (NUMBITS-1 downto 0);
           BINARY : out  STD_LOGIC_VECTOR (NUMBITS-1 downto 0));
end BCD_BINARY;

architecture Behavioral of BCD_BINARY is
begin
		PROCESS(BCD)
		variable digit : integer := 0;
		variable temp : integer := 0;
		begin
				for i in 0 to (NUMBITS/4)-1 loop
						digit := conv_integer(data((i*4)+3 downto (i*4)));
						temp := temp + digit * (10**i);
				end loop;
				BINARY <= STD_LOGIC_VECTOR(TO_UNSIGNED(temp, NUMBITS));
		end process;
end Behavioral;

