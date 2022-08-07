----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2022 09:51:52 AM
-- Design Name: 
-- Module Name: ID - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ID is
  Port ( 
  EN : in std_logic;
  Clk: in std_logic;
  RegWrite : in std_logic;
  RegDst: in std_logic;
  ExtOp: in std_logic;
  Instr: in std_logic_vector(15 downto 0);
  WD: in std_logic_vector(15 downto 0);
  RD1: out std_logic_vector(15 downto 0);
  RD2: out std_logic_vector(15 downto 0);
  Ext_Imm: out std_logic_vector(15 downto 0);
  func: out std_logic_vector(2 downto 0);
  sa: out std_logic
  );
end ID;

architecture Behavioral of ID is
signal mux: std_logic_vector(2 downto 0);
component RF is
     Port (  EN : in std_logic;
        wd : in std_logic_vector (15 downto 0);
        rd1 : out std_logic_vector (15 downto 0);
        rd2 : out std_logic_vector (15 downto 0);
        regWr: in std_logic;
        clk : in std_logic;
        RA1 : in std_logic_vector(2 downto 0);
        RA2: in std_logic_vector(2 downto 0);
        WA: in std_logic_vector(2 downto 0));
       
end component;
begin
    RgF: RF port map(EN,WD, RD1, RD2, RegWrite, Clk, Instr(12 downto 10),Instr(9 downto 7),mux);

mux <= Instr(9 downto 7) when  RegDst= '0' else Instr(6 downto 4);
func <= Instr(2 downto 0);
sa <= Instr(3);
Ext_Imm <="000000000"&Instr(6 downto 0) when ExtOp = '0' else 
"111111111"&Instr(6 downto 0) when Instr(6)='1' else
"000000000"&Instr(6 downto 0);

end Behavioral;
