----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 02.03.2021 14:25:45
-- Design Name: 
-- Module Name: gestion_freq - Behavioral
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

entity gestion_freq is
    Port (  clk             : in    std_logic;
            reset           : in    std_logic;
            ceAffichage     : out   std_logic;  -- Frequence de 10Hz
            cePerception    : out   std_logic   -- Frequence de 3kHz
            );
end gestion_freq;

-- Fonctionnement du quartz a 100MHz
-- ceA_couter -> Cpt ceAffichage  = 100 000 000 / 10      = 10 000 000 fronts
-- ceP_couter -> Cpt cePerception = 100 000 000 / 3 000   = 33 334 fronts
architecture Behavioral of gestion_freq is
    signal ceA_couter   : unsigned  (23 DOWNTO 0);  -- 2^24 = 16 767 216
    signal ceP_couter   : unsigned  (15 DOWNTO 0);  -- 2^16 = 65 536 
begin
    process(clk, reset)
    begin
        if (reset = '1') then
            ceA_couter  <= (OTHERS=> '0');
            ceAffichage <= '0';
            ceP_couter      <= (OTHERS=> '0');
            cePerception    <= '0';
        elsif (clk'event and clk = '1') then
            if (ceA_couter = 33333) then    -- (33 334 - 1)
                ceA_couter  <= (OTHERS=> '0');
                ceAffichage <= '1';
            else
                ceA_couter  <= ceA_couter + 1;
                ceAffichage <= '0';
            end if;
                if (ceP_couter = 9999999) then   -- (10 000 000 - 1)
                ceP_couter      <= (OTHERS=> '0');
                cePerception    <= '1';
            else
                ceP_couter      <= ceP_couter + 1;
                cePerception    <= '0';
            end if;
        end if;
    end process;

end Behavioral;
