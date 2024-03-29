----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 09.03.2021 17:13:24
-- Design Name: 
-- Module Name: gestion_freq_audio - Behavioral
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

entity gestion_freq_audio is
    Port (  clk             : in    std_logic;
            reset           : in    std_logic;
            multiplicateur  : in    std_logic_vector(1 downto 0);
            cePWM           : out   std_logic;  -- Frequence multiple de 44100Hz
            nbPeriode       : out   std_logic_vector(12 downto 0)
            );
end gestion_freq_audio;

architecture Behavioral of gestion_freq_audio is
    constant    CONST_44100          : unsigned  (11 DOWNTO 0) := to_unsigned(2266,12);
    signal      SIG_cePWM_couter     : unsigned  (12 DOWNTO 0);  -- 2^12 = 4 096 / 2^13 = 8 192 pour (2 266*2)
    signal      SIG_counterMax       : unsigned  (12 DOWNTO 0);
    signal      SIG_operateur        : std_logic;    --SIG = 1 -> VITESSE REDUITE / SIG = 0 -> VITESSE AUGMENTER
    signal      SIG_multiplicateur   : std_logic;

begin

    SIG_operateur       <= multiplicateur(1);
    SIG_multiplicateur  <= multiplicateur(0);
    nbPeriode           <= std_logic_vector(SIG_counterMax);
    
    process (SIG_operateur, SIG_multiplicateur)
    begin
        if (SIG_operateur = '0') then
            if (SIG_multiplicateur = '1') then
                SIG_counterMax <= to_unsigned(0, 2) & CONST_44100(11 downto 1);
            else
                SIG_counterMax <= to_unsigned(0, 1) & CONST_44100(11 downto 0);
            end if;
        else
            if (SIG_multiplicateur = '1') then
                SIG_counterMax <= CONST_44100(11 downto 0) & to_unsigned(0, 1);
            else
                SIG_counterMax <= to_unsigned(0, 1) & CONST_44100(11 downto 0);
            end if;
        end if;  
    end process;
    
    
    process(clk, reset)
    begin
        if (reset = '1') then
            SIG_cePWM_couter  <= (OTHERS=> '0');
            cePWM       <= '0';
        elsif (clk'event and clk = '1') then
                if (SIG_cePWM_couter = SIG_counterMax) then
                SIG_cePWM_couter  <= (OTHERS=> '0');
                cePWM       <= '1';
            else
                SIG_cePWM_couter    <= SIG_cePWM_couter + 1;
                cePWM               <= '0';
            end if;
        end if;
    end process;
end Behavioral;
