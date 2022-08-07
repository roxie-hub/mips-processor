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

entity test_env is
     Port (btn : in std_logic_vector(4 downto 0);
        sw : in std_logic_vector(15 downto 0);
        clk : in std_logic;
        an : out std_logic_vector(3 downto 0);
        cat : out std_logic_vector(6 downto 0);
        led : out std_logic_vector(15 downto 0)); 
end test_env;

architecture Behavioral of test_env is

signal Branch: std_logic;
signal BGEZ: std_logic;
signal MemWrite: std_logic;
signal MemData: std_logic_vector(15 downto 0);
signal ALUSrc : std_logic;
signal ALUOp: std_logic_vector(1 downto 0);
signal Zero: std_logic;
signal ALURes: std_logic_vector(15 downto 0);
signal RegWrite: std_logic;
signal RegDst: std_logic;
signal ExtOp: std_logic;
signal RD1: std_logic_vector(15 downto 0):=x"0000";
signal RD2: std_logic_vector(15 downto 0):=x"0000";
signal Ext_Imm: std_logic_vector(15 downto 0):=x"0000";
signal func:  std_logic_vector(2 downto 0):="000";
signal sa: std_logic;
signal wd: std_logic_vector(15 downto 0):=x"0000";
signal JAdr: std_logic_vector(15 downto 0):=x"0000";
signal BAdr: std_logic_vector(15 downto 0):=x"0000";
signal PCSrc:std_logic;
signal PCSrc1:std_logic;
signal Jump:std_logic;
signal RST:std_logic;
signal EN:std_logic;
signal pc_1:std_logic_vector(15 downto 0);
signal Instr:std_logic_vector(15 downto 0);
signal enable : std_logic:='0';
signal enable1 : std_logic:='0';
signal cnt : std_logic_vector(15 downto 0);
signal sum: std_logic_vector(15 downto 0);
signal MemtoReg: std_logic;

signal testNr: std_logic_vector(15 downto 0):= x"0000";
signal cntTest: std_logic_vector(2 downto 0):= "000";
signal enTest: std_logic;

component MPG port(clk : in std_logic;
                       btn : in  std_logic;
                       enable : out std_logic);
    end component;
    
   component IF_cmp is
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
        BGEZ: in std_logic
        ); 
end component;
    
component SSD_test_env port(an: out STD_LOGIC_VECTOR (3 downto 0);
                    cat:  out   STD_LOGIC_VECTOR (6 downto 0);
                    clk : in STD_LOGIC;
                    semnal: in  STD_LOGIC_VECTOR (15 downto 0));
    end component;

component ID is
  Port (  EN : in std_logic;
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
end component;

component ALU_cmp is
  Port ( rd1 : in std_logic_vector (15 downto 0);
         rd2 : in std_logic_vector (15 downto 0);
         Ext_Imm: in std_logic_vector(15 downto 0); 
         sa: in std_logic;
         func : in std_logic_vector (2 downto 0);
         ALUSrc : in std_logic;
         ALUOp: in std_logic_vector(1 downto 0);
         Zero: out std_logic;
         ALURes: out std_logic_vector(15 downto 0));
      
end component;

component RAM_cmp is
  Port (   EN : in std_logic;
        MemWrite: in std_logic;
         MemData: out std_logic_vector(15 downto 0);
         ALURes: in std_logic_vector(15 downto 0);
         RD2 : in std_logic_vector(15 downto 0);
         Clk : in std_logic
         );
end component;

component UC is
  Port ( Instr: in std_logic_vector(2 downto 0);
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
end component;

begin
    M: MPG port map(clk,btn(0),enable);
    M1: MPG port map(clk,btn(1),enable1);
    IF_c: IF_cmp port map(clk, EN, RST, JAdr, BAdr, PCSrc, Jump, pc_1, Instr, PCSrc1);
    ID_c: ID port map(EN,clk,RegWrite,RegDst,ExtOp,Instr,WD,RD1,RD2,Ext_Imm,func,sa);
    ALU_C: ALU_cmp port map(RD1,RD2,Ext_Imm,sa,func,ALUSrc,ALUOp,Zero,ALURes);
    RAM_c: RAM_cmp port map(EN,MemWrite,MemData,ALURes,RD2,Clk);
    UC_c: UC port map(Instr(15 downto 13),RegDst,ExtOp,ALUSrc,Branch,Jump,BGEZ,MemWrite,MemtoReg,ALUOp,RegWrite);
EN <= enable;
RST <= enable1;

PCSrc <= Branch and zero;
PCSrc1 <= Bgez and (not RD1(15));
BAdr <= Ext_Imm + pc_1;
JAdr <= "000" & Instr(12 downto 0);
WD <= ALURes when MemtoReg = '0' else MemData;

-- testinog of processor
   with sw(2 downto 0) Select
   testNr <= Instr when "000",  
            pc_1 when "001",  
            RD1 when "010",   
            RD2 when "011",  
            Ext_Imm when "100", 
            ALURes when "101",  
            MemData when "110", 
            WD when "111"; 
            
S: SSD_test_env port map(an,cat,clk, testNr);

end Behavioral;
