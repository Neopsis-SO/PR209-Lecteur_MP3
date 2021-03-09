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
            cePWM           : out   std_logic  -- Frequence de 44100Hz
            );
end gestion_freq_audio;

architecture Behavioral of gestion_freq_audio is
    signal ceP_couter   : unsigned  (11 DOWNTO 0);  -- 2^12 = 4 096
    
begin
    process(clk, reset)
    begin
        if (reset = '1') then

            ceP_couter  <= (OTHERS=> '0');
            cePWM       <= '0';
        elsif (clk'event and clk = '1') then
                if (ceP_couter = 2767) then   -- (2 768 - 1)
                ceP_couter  <= (OTHERS=> '0');
                cePWM       <= '1';
            else
                ceP_couter  <= ceP_couter + 1;
                cePWM       <= '0';
            end if;
        end if;
    end process;
end Behavioral;
