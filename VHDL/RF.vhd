----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2022 11:20:45 AM
-- Design Name: 
-- Module Name: RF - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RF is
     Port (  EN : in std_logic;
        wd : in std_logic_vector (15 downto 0);
        rd1 : out std_logic_vector (15 downto 0);
        rd2 : out std_logic_vector (15 downto 0);
        regWr: in std_logic;
        clk : in std_logic;
        RA1 : in std_logic_vector(2 downto 0);
        RA2: in std_logic_vector(2 downto 0);
        WA: in std_logic_vector(2 downto 0));
       
end RF;

architecture Behavioral of RF is

type reg_array is array (0 to 15) of std_logic_vector(15 downto 0);
signal reg_file : reg_array :=(
others => x"0000");

begin

process(clk)
begin

    if rising_edge(clk) then
        if regWr = '1' then
            if EN = '1' then
                reg_file(conv_integer(WA))<=WD;
            end if;
        end if;
    end if;
end process;
  
  rd1 <= reg_file(conv_integer(RA1));
  rd2 <= reg_file(conv_integer(RA2));
  
end Behavioral;
