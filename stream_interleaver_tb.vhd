----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/04/2020 02:46:08 AM
-- Design Name: 
-- Module Name: stream_interleaver_tb - Behavioral
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

entity stream_interleaver_tb is
--  Port ( );
end stream_interleaver_tb;

architecture Behavioral of stream_interleaver_tb is

component stream_interleaver is
    Port ( p0 : in STD_LOGIC_VECTOR (7 downto 0);
           p1 : in STD_LOGIC_VECTOR (7 downto 0);
           alpha : in STD_LOGIC_VECTOR (7 downto 0);
           pf : out STD_LOGIC_VECTOR (16 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC);
end component stream_interleaver;

signal clk_tb, rst_tb: std_logic;
signal p0_tb, p1_tb, alpha_tb: std_logic_vector(7 downto 0);
signal pf_tb: std_logic_vector(16 downto 0);

signal count: integer:=0;
signal alpha_int: integer;
constant cp: time:= 10ns;

--signal r_reg: unsigned (7 downto 0);
--signal r_next: unsigned (7 downto 0);

begin

uut: Stream_Interleaver port map(p0=> p0_tb,p1=> p1_tb,alpha=> alpha_tb,pf=> pf_tb,clk=> clk_tb, rst=>rst_tb);


process
begin
clk_tb<='1';
wait for cp/2;
clk_tb<='0';
wait for cp/2;
end process;

process
begin
rst_tb<='1';
wait for cp;
rst_tb<='0';
wait;
end process;

--alpha
process
begin
alpha_tb <= std_logic_vector(to_signed(0,8));
wait for 50*cp;
    for i in 1 to 127 loop
        alpha_tb <= std_logic_vector(to_signed(i,8));
        wait for cp;
    end loop;
wait;
end process;



din_steadyP0 :process
begin
wait for cp;
P0_tb <= std_logic_vector(to_signed(0, 8));
wait for cp;
P0_tb <= std_logic_vector(to_signed(76, 8));
wait for cp;
P0_tb <= std_logic_vector(to_signed(120, 8));
wait for cp;
P0_tb <= std_logic_vector(to_signed(120, 8));
wait for cp;
P0_tb <= std_logic_vector(to_signed(74, 8));
wait for cp;
P0_tb <= std_logic_vector(to_signed(0, 8));
wait for cp;
P0_tb <= std_logic_vector(to_signed(-74, 8));
wait for cp;
P0_tb <= std_logic_vector(to_signed(-120, 8));
wait for cp;
P0_tb <= std_logic_vector(to_signed(-120, 8));
wait for cp;
P0_tb <= std_logic_vector(to_signed(-74, 8));
end process;



din_steadyP1 :process
begin
wait for cp;
P1_tb <= std_logic_vector(to_signed(0, 8));
wait for cp;
P1_tb <= std_logic_vector(to_signed(37, 8));
wait for cp;
P1_tb <= std_logic_vector(to_signed(60, 8));
wait for cp;
P1_tb <= std_logic_vector(to_signed(60, 8));
wait for cp;
P1_tb <= std_logic_vector(to_signed(37, 8));
wait for cp;
P1_tb <= std_logic_vector(to_signed(0, 8));
wait for cp;
P1_tb <= std_logic_vector(to_signed(-37, 8));
wait for cp;
P1_tb <= std_logic_vector(to_signed(-60, 8));
wait for cp;
P1_tb <= std_logic_vector(to_signed(-60, 8));
wait for cp;
P1_tb <= std_logic_vector(to_signed(-37, 8));
end process;



--alpha_int <= to_integer(unsigned(Alpha_tb));
--process(clk_tb, rst_tb)
--    begin
--        if(rst_tb='1') then
--            Alpha_tb<=(others=>'0');
        
--        elsif(rising_edge(clk_tb)) then
--            if (count = 10) then
--                count <= 0;
----                alpha_int <= 127;
--                Alpha_tb<="01111111";
--            elsif (count = 0) then
----                alpha_int <= 0;
--                Alpha_tb<="00000000";
--                count <= count + 1;
--            elsif (count = 1) then
--                Alpha_tb<="00001101";
----                alpha_int <= 13;
--                count <= count + 1;
--            elsif (count = 2) then
----                alpha_int <= 25;
--                Alpha_tb<="00011001";
--                count <= count + 1;
--            elsif (count = 3) then
----                alpha_int <= 38;
--                Alpha_tb<="00100110";
--                count <= count + 1;
--            elsif (count = 4) then
----                alpha_int <= 51;
--                Alpha_tb<="00110011";
--                count <= count + 1;
--            elsif (count = 5) then
----                alpha_int <= 64;
--                Alpha_tb<="01000000";
--                count <= count + 1;
--            elsif (count = 6) then
----                alpha_int <= 76;
--                Alpha_tb<="01001100";
--                count <= count + 1;
--            elsif (count = 7) then
----                alpha_int <= 89;
--                Alpha_tb<="01011001";
--                count <= count + 1;
--            elsif (count = 8) then
----                alpha_int <= 102;
--                Alpha_tb<="01100110";
--                count <= count + 1;
--            elsif (count = 9) then
--                count <= count + 1;
----                alpha_int <= 114;
--                Alpha_tb<="01110010";
--            end if;
--        end if;
--end process;


--process
--begin
----Alpha_tb<="01111111";
----wait for 20 ns;
--Alpha_tb<="00000000";
--wait for 20 ns;
--Alpha_tb<="00001101";
--wait for 20 ns;
--Alpha_tb<="00011001";
--wait for 20 ns;
--Alpha_tb<="00100110";
--wait for 20 ns;
--Alpha_tb<="00110011";
--wait for 20 ns;
--Alpha_tb<="01000000";
--wait for 20 ns;
--Alpha_tb<="01001100";
--wait for 20 ns;
--Alpha_tb<="01011001";
--wait for 20 ns;
--Alpha_tb<="01100110";
--wait for 20 ns;
--Alpha_tb<="01110010";
--wait for 20 ns;
--end process;


--process(clk_tb)
--    begin
--    Alpha_tb<="00000000";
--       if(rising_edge(clk_tb))then 
           
--          Alpha_tb<=std_logic_vector(unsigned(Alpha_tb)+1);
       
--       end if;
--end process;


--process(clk_tb,rst_tb)
--begin
--    if (rst_tb='1') then
--        r_reg<=(others=>'0');
--    elsif (rising_edge(clk_tb)) then
--        r_reg <= r_next;
--    end if;
--end process;


--r_next<= (r_reg) + (0.1);
         

----output logic
--Alpha_tb <= std_logic_vector(r_reg);




end Behavioral;