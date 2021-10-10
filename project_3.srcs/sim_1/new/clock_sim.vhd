library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_sim is
--  Port ( );
end clock_sim;

architecture Behavioral of clock_sim is

component clock
    Port ( bcd_A : in STD_LOGIC_VECTOR (3 downto 0);
           bcd_B: in STD_LOGIC_VECTOR (3 downto 0);
           op : in STD_LOGIC;
           clk : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           dp : out STD_LOGIC;
           overflow : out STD_LOGIC);
    end component;
    
    signal s_A, s_B, s_an : std_logic_vector (3 downto 0);
    signal s_seg : std_logic_vector (6 downto 0);
    signal s_op, s_clk, s_dp, s_overflow : std_logic;
begin

    uut: clock port map(bcd_A=>s_A, bcd_B=>s_B, op=>s_op, clk=>s_clk, seg=>s_seg, an=>s_an, dp=>s_dp, overflow=>s_overflow);
    
    stimulus: process
    begin
        s_A<="0110"; s_B<="0101"; s_op<='0';
        wait for 1sec;
        
        s_A<="0101"; s_B<="1110"; s_op<='0';
        wait for 1sec;
        
        s_A<="1011"; s_B<="0011"; s_op<='0';
        wait for 1sec;
        
        s_A<="1011"; s_B<="1010"; s_op<='0';
        wait for 1sec;
        
        s_A<="0101"; s_B<="0011"; s_op<='1';
        wait for 1sec;
        
        s_A<="0101"; s_B<="1110"; s_op<='1';
        wait for 1sec;
        
        s_A<="1010"; s_B<="0111"; s_op<='1';
        wait for 1sec;
    
        wait;
    end process;


end Behavioral;
