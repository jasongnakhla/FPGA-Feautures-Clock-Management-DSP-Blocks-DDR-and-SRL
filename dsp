----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/09/2020 05:37:28 PM
-- Design Name: 
-- Module Name: dsp - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dsp is
  Port (signal clk         : in std_logic;  -- Clock
signal ce          : in std_logic;  -- clock enable
signal sload       : in  std_logic; -- synchronous load
signal a           : in  STD_LOGIC_VECTOR (7 downto 0);  -- 1st input to MACC
signal b           : in  STD_LOGIC_VECTOR (7 downto 0);  -- 2nd input to MACC
signal accum_out   : out STD_LOGIC_VECTOR (16 downto 0)); -- MACC output );
end dsp;

architecture Behavioral of dsp is


--  Multiply-accumulate unit
--  The following code implements a parameterizable Multiply-accumulate unit
--  with synchronous load to reset the accumulator without losing a clock cycle
--  Size of inputs/output should be less than/equal to what is supported by the architecture else extra logic/dsps will be inferred
--  Below libraries need to be used
--  library ieee;
--  use ieee.std_logic_1164.all;
--  use ieee.numeric_std.all;




-- Insert the below before begin keyword in architecture

-- Declare registers for intermediate values
signal a_reg, b_reg           : signed (7 downto 0):=(others => '0');
--signal <sload_reg>                : std_logic;
signal mult_reg                 : signed (15 downto 0);--:=(others => '0');
signal adder_out, old_result  : signed (16 downto 0):=(others => '0');

-- Insert the below after begin keyword in architecture

begin

process (clk,adder_out)
 begin
  if rising_edge(clk) then

    if ce = '1' then
        mult_reg  <= a_reg * b_reg;
--        <sload_reg> <= <sload>;
        -- Store accumulation result into a register
        if sload = '1' then
        old_result <= adder_out;
        adder_out <= old_result + mult_reg;
        end if;
--    else
--        mult_reg <= (others => '0');
--        adder_out <= (others => '0');
    end if;
        a_reg     <= signed(a);
        b_reg     <= signed(b);
  end if;
end process;

 -- Output accumulation result
  accum_out <= std_logic_vector(adder_out);
				

end Behavioral;
