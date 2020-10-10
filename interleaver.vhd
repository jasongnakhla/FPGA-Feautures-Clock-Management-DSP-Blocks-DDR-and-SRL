library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity interleaver is
    Port ( s0 : in STD_LOGIC_VECTOR (7 downto 0);
           s1 : in STD_LOGIC_VECTOR (7 downto 0);
           alpha : in STD_LOGIC_VECTOR (7 downto 0);
           pf : out STD_LOGIC_VECTOR (16 downto 0);
           ce_m: in STD_LOGIC;
           ce: in STD_LOGIC;
           sload: in STD_LOGIC;
           sel: in STD_LOGIC;
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


component dsp is
  Port (signal clk         : in std_logic;  -- Clock
signal ce          : in std_logic;  -- clock enable
signal sload       : in  std_logic; -- synchronous load
signal a           : in  STD_LOGIC_VECTOR (7 downto 0);  -- 1st input to MACC
signal b           : in  STD_LOGIC_VECTOR (7 downto 0);  -- 2nd input to MACC
signal accum_out   : out STD_LOGIC_VECTOR (16 downto 0)); -- MACC output );
end component dsp;

signal clk1,clk2: STD_LOGIC;
signal temp0, temp1: signed(15 downto 0):=(others => '0');
signal ones: signed(7 downto 0):="01111111";
signal pf_temp: signed(16 downto 0); 

signal s_out1,alpha_out1: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal add_out1: STD_LOGIC_VECTOR(16 DOWNTO 0);

attribute use_dsp: string;
attribute use_dsp of s_out1, alpha_out1, pf: signal is "yes";


begin


clocks: clk_wiz_0 port map(clk_in1 => clk, clk_out1 => clk1, clk_out2 => clk2);
DSP48: dsp port map(clk => clk2, a => s_out1, b => alpha_out1, accum_out => pf, ce => ce, sload => sload);
-- xbip_dsp48_macro_0 port map(CLK => clk2, A => s_out1, B => alpha_out1, P => pf);-- add_out1);

--so/alpha and s1/1-alpha
process(clk)
begin
    if (ce_m = '1') then
    if(rising_edge(clk)) then
        if(sel = '0') then
            s_out1 <= s0;
            alpha_out1 <= alpha;
        else 
            s_out1 <= s1;          
            alpha_out1 <= std_logic_vector(ones - signed(alpha));   
        end if;
    end if;
    end if;
end process;


end Behavioral;
