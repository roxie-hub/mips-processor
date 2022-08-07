----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2022 06:43:00 PM
-- Design Name: 
-- Module Name: RAM_cmp - Behavioral
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

entity RAM_cmp is
  Port (  EN : in std_logic;
         MemWrite: in std_logic;
         MemData: out std_logic_vector(15 downto 0);
         ALURes: in std_logic_vector(15 downto 0);
         RD2 : in std_logic_vector(15 downto 0);
         Clk : in std_logic
         );
end RAM_cmp;

architecture Behavioral of RAM_cmp is
    type ram_type is array (0 to 255) of std_logic_vector (15 downto 0);
    signal RAM: ram_type :=(
    x"000F", -- vec
    x"0002",
    x"0003",
    x"0006",
    x"000B",
    x"000C",
    x"000E",
    x"0007",
    x"0016",
    x"0013",
    x"000A", -- nr
    x"0000", -- sum
    others => x"0000");
begin
    MemData <= RAM(conv_integer(ALURes));
    process(Clk,MemWrite,EN)
    begin
        if rising_edge(Clk) then
            if MemWrite = '1' then
                if EN = '1' then
                    RAM(conv_integer(ALURes)) <= RD2;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
