----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 02.03.2021 14:25:45
-- Design Name: 
-- Module Name: transcodeur - Behavioral
-- Project Name: PR209-Lecteur_MP3
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity transcodeur is
    Port (  play_pause  : in    std_logic;
            restart     : in    std_logic;
            forward     : in    std_logic;
            nbCpt1_9    : in    std_logic_vector(3 downto 0);
            nbCpt1_599  : in    std_logic_vector(9 downto 0);
            S_ms        : out   std_logic_vector(6 downto 0);
            S_s         : out   std_logic_vector(6 downto 0);
            S_ds        : out   std_logic_vector(6 downto 0);
            S_vol       : out   std_logic_vector(6 downto 0);
            S_fsm_0     : out   std_logic_vector(6 downto 0);
            S_fsm_1     : out   std_logic_vector(6 downto 0);
            S_fsm_2     : out   std_logic_vector(6 downto 0);
            S_fsm_3     : out   std_logic_vector(6 downto 0)
            );
end transcodeur;

architecture Behavioral of transcodeur is
    -- Cathodes des 7 segments "GFEDCBA" (activation a l etat bas)
    constant hyphen       : std_logic_vector(6 downto 0) := "0111111";    --"-"
    constant arrow_left   : std_logic_vector(6 downto 0) := "1000110";    --"["
    constant arrow_right  : std_logic_vector(6 downto 0) := "1110000";    --"]"
    constant digit0       : std_logic_vector(6 downto 0) := "1000000";    -- "0" 
    constant digit1       : std_logic_vector(6 downto 0) := "1111001";    -- "1"
    constant digit2       : std_logic_vector(6 downto 0) := "0100100";    -- "2"
    constant digit3       : std_logic_vector(6 downto 0) := "0110000";    -- "3"
    constant digit4       : std_logic_vector(6 downto 0) := "0011001";    -- "4"
    constant digit5       : std_logic_vector(6 downto 0) := "0010010";    -- "5"
    constant digit6       : std_logic_vector(6 downto 0) := "0000010";    -- "6"
    constant digit7       : std_logic_vector(6 downto 0) := "1111000";    -- "7"
    constant digit8       : std_logic_vector(6 downto 0) := "0000000";    -- "8"
    constant digit9       : std_logic_vector(6 downto 0) := "0010000";    -- "9"
    
    signal couter_tempC : unsigned (9 downto 0) := (OTHERS=> '0');
    signal couter_tempD : unsigned (9 downto 0) := (OTHERS=> '0');
    signal unit         : unsigned (3 downto 0) := (OTHERS=> '0');
    signal dizaine      : unsigned (3 downto 0) := (OTHERS=> '0');
    signal centaine     : unsigned (3 downto 0) := (OTHERS=> '0');
    
begin
    Aff_fsm_state : process(play_pause, restart, forward)
    begin
        if (restart = '1') then
            S_fsm_0 <= arrow_right;
            S_fsm_1 <= hyphen;
            S_fsm_2 <= hyphen;
            S_fsm_3 <= arrow_left;
        elsif (play_pause = '1') then
            if (forward = '1') then
                S_fsm_0 <= arrow_right;
                S_fsm_1 <= hyphen;    
                S_fsm_2 <= hyphen;    
                S_fsm_3 <= hyphen;
            else
                S_fsm_0 <= hyphen;
                S_fsm_1 <= hyphen;    
                S_fsm_2 <= hyphen;    
                S_fsm_3 <= arrow_left;
            end if;
        else
            S_fsm_0 <= hyphen;
            S_fsm_1 <= hyphen;    
            S_fsm_2 <= hyphen;    
            S_fsm_3 <= hyphen;
        end if;
    end process;

--------------------------------------------------------------------

    Aff_cpt_1_9 : process(nbCpt1_9)
    begin
        case nbCpt1_9 is
            when "0000" => S_vol <= digit0;
            when "0001" => S_vol <= digit1;
            when "0010" => S_vol <= digit2;
            when "0011" => S_vol <= digit3;
            when "0100" => S_vol <= digit4;
            when "0101" => S_vol <= digit5;
            when "0110" => S_vol <= digit6;
            when "0111" => S_vol <= digit7;
            when "1000" => S_vol <= digit8;
            when "1001" => S_vol <= digit9;
            when OTHERS => S_vol <= digit0;
        end case;
    end process;
    
--------------------------------------------------------------------
    
    Separation_cpt_1_599_centaine : process(nbCpt1_599) -- separer en 2 process celui ci pour calculer centaine, dizaine, unite
    begin
        centaine        <= to_unsigned(0, 4);
        couter_tempC    <= unsigned(nbCpt1_599);
        if (unsigned(nbCpt1_599) < to_unsigned(100, 10)) then
            centaine        <= to_unsigned(0, 4);
            couter_tempC    <= unsigned(nbCpt1_599);
        elsif (unsigned(nbCpt1_599) < to_unsigned(200, 10)) then
            centaine        <= to_unsigned(1, 4);
            couter_tempC    <= unsigned(nbCpt1_599) - to_unsigned(100, 10);
        elsif (unsigned(nbCpt1_599) < to_unsigned(300, 10)) then
            centaine        <= to_unsigned(2, 4);
            couter_tempC    <= unsigned(nbCpt1_599) - to_unsigned(200, 10);
        elsif (unsigned(nbCpt1_599) < to_unsigned(400, 10)) then
            centaine        <= to_unsigned(3, 4);
            couter_tempC    <= unsigned(nbCpt1_599) - to_unsigned(300, 10);
        elsif (unsigned(nbCpt1_599) < to_unsigned(500, 10)) then
            centaine        <= to_unsigned(4, 4);
            couter_tempC    <= unsigned(nbCpt1_599) - to_unsigned(400, 10);
        elsif (unsigned(nbCpt1_599) < to_unsigned(600, 10)) then
            centaine        <= to_unsigned(5, 4);
            couter_tempC    <= unsigned(nbCpt1_599) - to_unsigned(500, 10);
        elsif (unsigned(nbCpt1_599) < to_unsigned(700, 10)) then
            centaine        <= to_unsigned(6, 4);
            couter_tempC    <= unsigned(nbCpt1_599) - to_unsigned(600, 10);
        elsif (unsigned(nbCpt1_599) < to_unsigned(800, 10)) then
            centaine        <= to_unsigned(7, 4);
            couter_tempC    <= unsigned(nbCpt1_599) - to_unsigned(700, 10);
        elsif (unsigned(nbCpt1_599) < to_unsigned(900, 10)) then
            centaine        <= to_unsigned(8, 4);
            couter_tempC    <= unsigned(nbCpt1_599) - to_unsigned(800, 10);
        elsif (unsigned(nbCpt1_599) < to_unsigned(1000, 10)) then
            centaine        <= to_unsigned(9, 4);
            couter_tempC    <= unsigned(nbCpt1_599) - to_unsigned(900, 10);
        end if;
    end process;

--------------------------------------------------------------------

    Separation_cpt_1_599_dizaine : process(couter_tempC) -- separer en 2 process celui ci pour calculer centaine, dizaine, unite
    begin
        dizaine         <= to_unsigned(0, 4);
        couter_tempD    <= couter_tempC;
        if (couter_tempC < to_unsigned(10, 10)) then
            dizaine         <= to_unsigned(0, 4);
            couter_tempD    <= couter_tempC;
        elsif (couter_tempC < to_unsigned(20, 10)) then
            dizaine         <= to_unsigned(1, 4);
            couter_tempD    <= couter_tempC - to_unsigned(10, 10);
        elsif (couter_tempC < to_unsigned(30, 10)) then
            dizaine         <= to_unsigned(2, 4);
            couter_tempD    <= couter_tempC - to_unsigned(20, 10);
        elsif (couter_tempC < to_unsigned(40, 10)) then
            dizaine         <= to_unsigned(3, 4);
            couter_tempD    <= couter_tempC - to_unsigned(30, 10);
        elsif (couter_tempC < to_unsigned(50, 10)) then
            dizaine         <= to_unsigned(4, 4);
            couter_tempD    <= couter_tempC - to_unsigned(40, 10);
        elsif (couter_tempC < to_unsigned(60, 10)) then
            dizaine         <= to_unsigned(5, 4);
            couter_tempD    <= couter_tempC - to_unsigned(50, 10);
        elsif (couter_tempC < to_unsigned(70, 10)) then
            dizaine         <= to_unsigned(6, 4);
            couter_tempD    <= couter_tempC - to_unsigned(60, 10);
        elsif (couter_tempC < to_unsigned(80, 10)) then
            dizaine         <= to_unsigned(7, 4);
            couter_tempD    <= couter_tempC - to_unsigned(70, 10);
        elsif (couter_tempC < to_unsigned(90, 10)) then
            dizaine         <= to_unsigned(8, 4);
            couter_tempD    <= couter_tempC - to_unsigned(80, 10);
        elsif (couter_tempC < to_unsigned(100, 10)) then
            dizaine         <= to_unsigned(9, 4);
            couter_tempD    <= couter_tempC - to_unsigned(90, 10);
        end if;
    end process;

--------------------------------------------------------------------

    Separation_cpt_1_599_unit : process(couter_tempD) -- separer en 2 process celui ci pour calculer centaine, dizaine, unite
    begin
        case couter_tempD is
            when "0000000000" => unit <= to_unsigned(0, 4);
            when "0000000001" => unit <= to_unsigned(1, 4);
            when "0000000010" => unit <= to_unsigned(2, 4);
            when "0000000011" => unit <= to_unsigned(3, 4);
            when "0000000100" => unit <= to_unsigned(4, 4);
            when "0000000101" => unit <= to_unsigned(5, 4);
            when "0000000110" => unit <= to_unsigned(6, 4);
            when "0000000111" => unit <= to_unsigned(7, 4);
            when "0000001000" => unit <= to_unsigned(8, 4);
            when "0000001001" => unit <= to_unsigned(9, 4);
            when OTHERS => unit <= "1111";  --hyphen
        end case;
    end process;

--------------------------------------------------------------------

    Aff_cpt_1_599 : process(unit, dizaine, centaine)
    begin
        case unit is
            when "0000" => S_ms <= digit0;
            when "0001" => S_ms <= digit1;
            when "0010" => S_ms <= digit2;
            when "0011" => S_ms <= digit3;
            when "0100" => S_ms <= digit4;
            when "0101" => S_ms <= digit5;
            when "0110" => S_ms <= digit6;
            when "0111" => S_ms <= digit7;
            when "1000" => S_ms <= digit8;
            when "1001" => S_ms <= digit9;
            when OTHERS => S_ms <= hyphen;
        end case;
        
        case dizaine is
            when "0000" => S_s <= digit0;
            when "0001" => S_s <= digit1;
            when "0010" => S_s <= digit2;
            when "0011" => S_s <= digit3;
            when "0100" => S_s <= digit4;
            when "0101" => S_s <= digit5;
            when "0110" => S_s <= digit6;
            when "0111" => S_s <= digit7;
            when "1000" => S_s <= digit8;
            when "1001" => S_s <= digit9;
            when OTHERS => S_s <= hyphen;
        end case;
        
        case centaine is
            when "0000" => S_ds <= digit0;
            when "0001" => S_ds <= digit1;
            when "0010" => S_ds <= digit2;
            when "0011" => S_ds <= digit3;
            when "0100" => S_ds <= digit4;
            when "0101" => S_ds <= digit5;
            when "0110" => S_ds <= digit6;
            when "0111" => S_ds <= digit7;
            when "1000" => S_ds <= digit8;
            when "1001" => S_ds <= digit9;
            when OTHERS => S_ds <= hyphen;
        end case;
    end process;
    
end Behavioral;