----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2022 03:16:08 PM
-- Design Name: 
-- Module Name: ALU_cmd - Behavioral
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

entity ALU_cmp is
  Port ( rd1 : in std_logic_vector (15 downto 0);
         rd2 : in std_logic_vector (15 downto 0);
         Ext_Imm: in std_logic_vector(15 downto 0); 
         sa: in std_logic;
         func : in std_logic_vector (2 downto 0);
         ALUSrc : in std_logic;
         ALUOp: in std_logic_vector(1 downto 0);
         Zero: out std_logic;
         ALURes: out std_logic_vector(15 downto 0));
      
end ALU_cmp;

architecture Behavioral of ALU_cmp is
signal mux: std_logic_vector(15 downto 0); 
signal aux: std_logic_vector(15 downto 0):=x"0000"; 
signal  ALUCtrl: std_logic_vector(2 downto 0);
begin

process(ALUOp)
begin
    case ALUOp is
        when "00" => ALUCtrl <= func;
        when "01" => ALUCtrl <= "001";
        when "11" => ALUCtrl <= "111";
        when "10" => ALUCtrl <= "000";
    end case;
end process;

process(ALUCtrl)
begin
    case ALUCtrl is
        when "000" => aux <= RD1 - mux;
        when "001" => aux <= RD1 + mux;
        when "111" => aux <= RD1 or mux;
        when "100" => aux <= RD1 and mux;
        when "010" => case sa is 
                      when '1' => aux <= mux(15) & mux(15 downto 1);
                      when '0' => aux <= mux; -- sra
                      end case;
        when "101" | "011" => case sa is 
                      when '1' => aux <= mux(14 downto 0) & '0';
                      when '0' => aux <= mux; -- sla & sll
                      end case;
        when "110"  => case sa is 
                      when '1' => aux <= '0' & mux(15 downto 1);
                      when '0' => aux <= mux; -- srl
                      end case;
    end case;
end process;
ALURes <= aux;
mux <= rd2 when ALUSrc = '0' else Ext_Imm;
Zero <= '1' when aux = x"0000" else '0';

end Behavioral;
