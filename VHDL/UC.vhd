----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2022 05:19:41 PM
-- Design Name: 
-- Module Name: UC - Behavioral
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

entity UC is
  Port (Instr: in std_logic_vector(2 downto 0);
        RegDst: out std_logic;
        ExtOp: out std_logic;
        ALUSrc: out std_logic;
        Branch: out std_logic;
        Jump: out std_logic;
        BGEZ: out std_logic;
        MemWrite: out std_logic;
        MemtoReg: out std_logic;
        ALUOp: out std_logic_vector(1 downto 0);
        RegWrite: out std_logic
        );
end UC;

architecture Behavioral of UC is

begin
  
process(Instr)

begin
  RegDst <= '0';
        ExtOp <= '0';
        ALUSrc <= '0';
        Branch <= '0';
        Jump <= '0';
        BGEZ <= '0';
        MemWrite <= '0';
        MemtoReg <= '0';
        RegWrite <= '0';
        
    case Instr is
        when "000" => RegDst <= '1'; RegWrite <= '1'; ALUOp <= "00";
        when "001" => RegWrite <= '1'; ExtOp <= '1'; ALUSrc <= '1'; ALUOp <= "01";
        when "011" => RegWrite <= '1'; ALUSrc <= '1'; ALUOp <= "11";
        when "101" => MemWrite <= '1'; ALUSrc <= '1'; ALUOp <= "01";
        when "010" => RegWrite <= '1'; ALUSrc <= '1'; MemtoReg <= '1'; ALUOp <= "01";
        when "111" => ExtOp <= '1'; Branch <= '1'; ALUOp <= "10";
        when "110" => ExtOp <= '1'; BGEZ <= '1'; ALUOp <= "10";
        when "100" => Jump <= '1'; ALUOp <= "10";
    end case;
end process;
end Behavioral;
