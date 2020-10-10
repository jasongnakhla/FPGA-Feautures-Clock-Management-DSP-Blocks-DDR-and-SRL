----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/04/2020 02:34:06 AM
-- Design Name: 
-- Module Name: stream_interleaver - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity interleaver is
    Port ( s0 : in STD_LOGIC_VECTOR (7 downto 0);
           s1 : in STD_LOGIC_VECTOR (7 downto 0);
           alpha : in STD_LOGIC_VECTOR (7 downto 0);
           pf : out STD_LOGIC_VECTOR (16 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC);
end interleaver;

architecture Behavioral of interleaver is

component clk_wiz_0
port
 (-- Clock in ports
  -- Clock out ports
  clk_out1          : out    std_logic;
  clk_out2          : out    std_logic;
  clk_in1           : in     std_logic
 );
end component;

component xbip_dsp48_macro_0 IS
  PORT (
    CLK : IN STD_LOGIC;
    A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    P : OUT STD_LOGIC_VECTOR(16 DOWNTO 0)
  );
END component xbip_dsp48_macro_0;

signal clk1,clk2: STD_LOGIC;
signal temp0, temp1: signed(15 downto 0):=(others => '0');
signal ones: signed(7 downto 0):="01111111";
signal pf_temp: signed(16 downto 0); 
--attribute use_dsp: string;
--attribute use_dsp of temp0, temp1, pf_temp: signal is "yes";

signal s_out1,alpha_out1: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal add_out1: STD_LOGIC_VECTOR(16 DOWNTO 0);

--signal acc,acc1:

begin
--pf <= add_out1;

clocks: clk_wiz_0 port map(clk_in1 => clk, clk_out1 => clk1, clk_out2 => clk2);
DSP48: xbip_dsp48_macro_0 port map(CLK => clk2, A => s_out1, B => alpha_out1, P => pf);-- add_out1);

--so/alpha and s1/1-alpha
process(clk)
begin
    if(rising_edge(clk)) then
            s_out1 <= s0;
            alpha_out1 <= alpha;
     end if;
end process;

process(clk)
    begin
        if (falling_edge(clk)) then
            s_out1 <= s1;          
            alpha_out1 <= std_logic_vector(ones - signed(alpha));   
        end if;
end process;


end Behavioral;
