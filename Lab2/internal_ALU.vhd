----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:16:22 01/20/2016 
-- Design Name: 
-- Module Name:    internal_ALU - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity internal_ALU is
    Port ( A : in  STD_LOGIC_VECTOR (0 downto 0);
           B : in  STD_LOGIC_VECTOR (0 downto 0);
           opcode : in  STD_LOGIC_VECTOR (3 downto 0);
           result : out  STD_LOGIC_VECTOR (0 downto 0);
           overflow : out  STD_LOGIC;
           carry_out : out  STD_LOGIC;
           zero : out  STD_LOGIC);
end internal_ALU;

architecture Behavioral of internal_ALU is

begin


end Behavioral;

