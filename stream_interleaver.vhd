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

entity stream_interleaver is
    Port ( p0 : in STD_LOGIC_VECTOR (7 downto 0);
           p1 : in STD_LOGIC_VECTOR (7 downto 0);
           alpha : in STD_LOGIC_VECTOR (7 downto 0);
           pf : out STD_LOGIC_VECTOR (16 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC);
end stream_interleaver;

architecture Behavioral of stream_interleaver is

signal temp0, temp1: signed(15 downto 0):=(others => '0');
signal ones: signed(7 downto 0):="01111111";
signal pf_temp: signed(16 downto 0); 
attribute use_dsp: string;
attribute use_dsp of temp0, temp1, pf_temp: signal is "yes";

begin

process(clk,rst)
    begin
        if(rising_edge(clk)) then
            temp0 <= signed(p0)*signed(alpha);
            temp1 <= signed(p1)*(ones-signed(alpha));
            pf_temp <= (temp0(15)&temp0) + (temp1(15)&temp1)/ones;
            pf <= std_logic_vector(pf_temp);
        end if;
end process;
end Behavioral;
