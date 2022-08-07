----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2022 09:07:00 AM
-- Design Name: 
-- Module Name: IF - Behavioral
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

entity IF_cmp is
     Port (
        clk : in std_logic;
        EN : in std_logic;
        RST : in std_logic;
        JAdr: in std_logic_vector(15 downto 0);
        BAdr: std_logic_vector(15 downto 0);
        PCSrc: in std_logic;
        Jump: in std_logic;
        pc_1: out std_logic_vector(15 downto 0);
        Instr: out std_logic_vector(15 downto 0);
        Bgez : in std_logic
        ); 
end IF_cmp;

architecture Behavioral of IF_cmp is
signal mux1: std_logic_vector(15 downto 0);
signal mux2: std_logic_vector(15 downto 0);
signal mux3: std_logic_vector(15 downto 0);
signal cnt : std_logic_vector(15 downto 0);
signal sum: std_logic_vector(15 downto 0);
type rom_array is array (0 to 255) of std_logic_vector (15 downto 0);
signal rom: rom_array:= (
b"001_000_110_0000001",
b"010_000_010_0001010",
b"000_001_001_001_0_000",
b"000_011_011_011_0_000",
b"000_100_100_100_0_000",
b"010_001_100_0000000",
b"000_100_110_111_0_100",
b"111_000_111_0000001",
b"000_011_100_011_0_001",
b"001_001_001_0000010",
b"111_010_001_0000001",
b"100_0000000000100",
b"101_000_011_0001011",
others => x"0000");
begin

process(clk,EN,RST)
begin 
    if rising_edge(clk) then
        if RST = '1' then
            cnt<=x"0000";
        end if;
        if EN = '1' then
           cnt <= mux2;
        end if;
     end if;
end process;

Instr <= rom(conv_integer(cnt));
sum <= cnt + x"0001";
mux1 <= sum when PCSrc = '0' else BAdr;
mux2 <= mux1 when Jump = '0' else JAdr;
mux3 <= mux1 when Bgez = '0' else BAdr;

pc_1 <= sum;

end Behavioral;
