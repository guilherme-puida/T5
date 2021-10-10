library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_subtractor is
    Port ( op : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           R : out STD_LOGIC_VECTOR (3 downto 0);
           overflow : out STD_LOGIC);
end adder_subtractor;

architecture Behavioral of adder_subtractor is

component full_adder
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           sum : out STD_LOGIC;
           Cout : out STD_LOGIC);
end component;

signal c1, c2, c3, c4: STD_LOGIC;
signal temp: STD_LOGIC_VECTOR(3 downto 0);
signal op_vector: STD_LOGIC_VECTOR(3 downto 0);

begin
    --- 1 para subtração, 0 para adição ---
    op_vector <= "1111" when op = '1' else "0000" when op = '0';

    temp <= B xor op_vector;
    
    fa0: full_adder port map(A=>A(0), B=>temp(0), Cin=>op, sum=>R(0), Cout=>c1);
    fa1: full_adder port map(A=>A(1), B=>temp(1), Cin=>c1, sum=>R(1), Cout=>c2);
    fa2: full_adder port map(A=>A(2), B=>temp(2), Cin=>c2, sum=>R(2), Cout=>c3);
    fa3: full_adder port map(A=>A(3), B=>temp(3), Cin=>c3, sum=>R(3), Cout=>c4);
    
    overflow <= c3 xor c4;

end Behavioral;
