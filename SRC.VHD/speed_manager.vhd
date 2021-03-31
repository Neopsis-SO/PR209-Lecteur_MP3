----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 24.03.2021 10:37:45
-- Design Name: 
-- Module Name: speed_manager - Behavioral
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

entity speed_manager is
    Port (  multiplicateur  : in    std_logic_vector(1 downto 0);
            idata           : in    std_logic_vector(10 downto 0);
            odata           : out   std_logic_vector(11 downto 0)
            );
end speed_manager;

architecture Behavioral of speed_manager is
    signal      SIG_operateur        : std_logic;    --SIG = 1 -> VITESSE REDUITE / SIG = 0 -> VITESSE AUGMENTER
    signal      SIG_multiplicateur   : std_logic;
    
begin
    SIG_operateur       <= multiplicateur(1);
    SIG_multiplicateur  <= multiplicateur(0);

    process (SIG_operateur, SIG_multiplicateur, idata)
    begin
        if (SIG_operateur = '0') then
            if (SIG_multiplicateur = '1') then
                odata <= idata(10)& idata(10)& idata(10 downto 1);
            else                
                odata <= idata(10)& idata(10 downto 0);
            end if;
        else
            if (SIG_multiplicateur = '1') then
                odata <= idata(10 downto 0)& idata(10);
            else
                odata <= idata(10)& idata(10 downto 0);
            end if;
        end if;  
    end process;

end Behavioral;
