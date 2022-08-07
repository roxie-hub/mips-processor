----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2022 12:33:17 PM
-- Design Name: 
-- Module Name: MPG - Behavioral
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

entity MPG is
  Port (clk : in std_logic;
        btn : in std_logic;
        enable : out std_logic );
end MPG;

architecture Behavioral of MPG is
    signal cnt : std_logic_vector(15 downto 0) :=x"0000";
    signal en : std_logic;
    signal q : std_logic;
    signal q1 : std_logic;
    signal q2 : std_logic;
begin
    en <= '1' when cnt = x"FFFF" else '0';
    
    process(clk)
    begin
        if rising_edge(clk) then
            cnt <= cnt + 1;
        end if;
    end process;
    
    process(en,clk)
    begin
        if rising_edge(clk) then
            if en='1' then
                q <= btn;
             end if;
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            q1<=q;
            q2<=q1;
        end if;
    end process;
    enable <= q1 and (not q2);
end Behavioral;
