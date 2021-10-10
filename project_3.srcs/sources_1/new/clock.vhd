library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock is
    Port ( bcd_A : in STD_LOGIC_VECTOR (3 downto 0);
           bcd_B: in STD_LOGIC_VECTOR (3 downto 0);
           op : in STD_LOGIC;
           clk : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           dp : out STD_LOGIC;
           overflow : out STD_LOGIC);
end clock;
    
architecture Behavioral of clock is
    component bcd7seg 
        Port ( bcd : in STD_LOGIC_VECTOR (3 downto 0);
               seg : out STD_LOGIC_VECTOR (6 downto 0);
               dp : out STD_LOGIC);
        end component;
        
    component adder_subtractor
        Port ( op : in STD_LOGIC;
               A : in STD_LOGIC_VECTOR (3 downto 0);
               B : in STD_LOGIC_VECTOR (3 downto 0);
               R : out STD_LOGIC_VECTOR (3 downto 0);
               overflow : out STD_LOGIC);
    end component;
    
    signal clk_dividido: STD_LOGIC := '0';
    signal counter: integer range 1 to 100_000 := 1; 
    signal seletor_display: integer range 1 to 4 := 1;
    signal bcd_now: STD_LOGIC_VECTOR (3 downto 0);
    signal s_an: STD_LOGIC_VECTOR (3 downto 0) := "1111";
    signal result: STD_LOGIC_VECTOR (3 downto 0);
begin

    add: adder_subtractor port map(op=>op, A=>bcd_A, B=>bcd_B, R=>result, overflow=>overflow);

    
    ----------------------------------
    -------- divisor de clock --------
    ----------------------------------
    
    divisor_clock: process (clk)
    begin
        if rising_edge (clk) then
            if counter = 100_000 then
                counter <= 1;
                clk_dividido <= not clk_dividido;
            else
            counter <= counter + 1;
            end if;
        end if;   
    end process;
    
    -----------------------------------
    -------------  mux  ---------------
    -----------------------------------
    
    
    seletor: process(clk_dividido)
    begin
        if rising_edge(clk_dividido) then
        case seletor_display is
            when 1 => s_an <= "1110"; bcd_now <= result;
            when 2 => s_an <= "1111";
            when 3 => s_an <= "1011"; bcd_now <= bcd_B;
            when 4 => s_an <= "0111"; bcd_now <= bcd_A;
            when others => null;
        end case;
        seletor_display <= seletor_display + 1;
        end if;
    end process;
    
    an <= s_an;
    dr_bcd: bcd7seg port map(bcd=>bcd_now, seg=>seg, dp=>dp);
    
end Behavioral;
