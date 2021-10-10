library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd7seg is
    Port ( bcd : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           dp: out STD_LOGIC );
end bcd7seg;

architecture Behavioral of bcd7seg is

begin
    with bcd select 
        seg <= "0000000" when "1000", -- -8
               "1111000" when "1001", -- -7
               "0000010" when "1010", -- -6
               "0010010" when "1011", -- -5
               "0011001" when "1100", -- -4
               "0110000" when "1101", -- -3
               "0100100" when "1110", -- -2
               "1111001" when "1111", -- -1
               "1000000" when "0000", --  0
               "1111001" when "0001", --  1
               "0100100" when "0010", --  2
               "0110000" when "0011", --  3 
               "0011001" when "0100", --  4
               "0010010" when "0101", --  5
               "0000010" when "0110", --  6
               "1111000" when "0111", --  7
               "0000000" when others;
          
    -- 1 para positivo,  para negativo     
    dp <= not bcd(3);
end Behavioral;
