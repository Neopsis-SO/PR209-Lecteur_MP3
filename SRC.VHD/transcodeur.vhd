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
--use IEEE.NUMERIC_STD.ALL;

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
            S_dz        : out   std_logic_vector(6 downto 0);
            S_vol       : out   std_logic_vector(6 downto 0);
            S_fsm_0     : out   std_logic_vector(6 downto 0);
            S_fsm_1     : out   std_logic_vector(6 downto 0);
            S_fsm_2     : out   std_logic_vector(6 downto 0);
            S_fsm_3     : out   std_logic_vector(6 downto 0)
            );
end transcodeur;

architecture Behavioral of transcodeur is
    -- Cathodes des 7 segments "GFEDCBA" (activation a l etat bas)
    signal hyphen       : std_logic_vector(6 downto 0) := "0111111";    --"-"
    signal arrow_left   : std_logic_vector(6 downto 0) := "1000110";    --"["
    signal arrow_right  : std_logic_vector(6 downto 0) := "1110000";    --"]"
    signal digit0       : std_logic_vector(6 downto 0) := "1000000";    -- "0" 
    signal digit1       : std_logic_vector(6 downto 0) := "1111001";    -- "1"
    signal digit2       : std_logic_vector(6 downto 0) := "0100100";    -- "2"
    signal digit3       : std_logic_vector(6 downto 0) := "0110000";    -- "3"
    signal digit4       : std_logic_vector(6 downto 0) := "0011001";    -- "4"
    signal digit5       : std_logic_vector(6 downto 0) := "0010010";    -- "5"
    signal digit6       : std_logic_vector(6 downto 0) := "0000010";    -- "6"
    signal digit7       : std_logic_vector(6 downto 0) := "1111000";    -- "7"
    signal digit8       : std_logic_vector(6 downto 0) := "0000000";    -- "8"
    signal digit9       : std_logic_vector(6 downto 0) := "0010000";    -- "9"
    
    signal mseconde     : std_logic_vector(3 downto 0) := (OTHERS=> '0');
    signal seconde      : std_logic_vector(3 downto 0) := (OTHERS=> '0');
    signal dizaine      : std_logic_vector(3 downto 0) := (OTHERS=> '0');
    
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

    Separation_cpt_1_599 : process(nbCpt1_599)
    begin
    
    end process;

--------------------------------------------------------------------

    Aff_cpt_1_599 : process(mseconde, seconde, dizaine)
    begin
        case mseconde is
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
            when OTHERS => S_ms <= digit0;
        end case;
        
        case seconde is
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
            when OTHERS => S_s <= digit0;
        end case;
        
        case dizaine is
            when "0000" => S_dz <= digit0;
            when "0001" => S_dz <= digit1;
            when "0010" => S_dz <= digit2;
            when "0011" => S_dz <= digit3;
            when "0100" => S_dz <= digit4;
            when "0101" => S_dz <= digit5;
            when "0110" => S_dz <= digit6;
            when "0111" => S_dz <= digit7;
            when "1000" => S_dz <= digit8;
            when "1001" => S_dz <= digit9;
            when OTHERS => S_dz <= digit0;
        end case;
    end process;
    
end Behavioral;
