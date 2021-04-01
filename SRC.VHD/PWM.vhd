----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 09.03.2021 16:00:08
-- Design Name: 
-- Module Name: PWM - Behavioral
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

entity PWM is
    Port (  clk             : in    std_logic;
            reset           : in    std_logic;
            ce              : in    std_logic;
            idata_n         : in    std_logic_vector(11 downto 0);
            multiplicateur  : in    std_logic_vector(1 downto 0);
            nbPeriode       : in    std_logic_vector(12 downto 0);
            odata           : out   std_logic;
            enable          : out   std_logic
            );
end PWM;

architecture Behavioral of PWM is
    constant    CONST_1024          : signed(11 downto 0) := to_signed(1024, 12);
    signal      SIG_operateur       : std_logic;    --SIG = 1 -> VITESSE REDUITE / SIG = 0 -> VITESSE AUGMENTER
    signal      SIG_multiplicateur  : std_logic;
    signal      SIG_CORRECTION      : signed(12 downto 0) := '0' & CONST_1024;
    signal      sig_data    : unsigned(12 downto 0);
    signal      val_data    : unsigned(12 downto 0);
    signal      counter     : unsigned(12 downto 0);
    
begin
    enable      <= '1'; -- Permet d'activer la sortie audio
    SIG_operateur       <= multiplicateur(1);
    SIG_multiplicateur  <= multiplicateur(0);
    
    correction : process (SIG_operateur, SIG_multiplicateur)
    begin
        if (SIG_operateur = '0') then
            if (SIG_multiplicateur = '1') then
                SIG_CORRECTION <= '0' & '0' & CONST_1024(11 downto 1);
            else                
                SIG_CORRECTION <= '0' & CONST_1024;
            end if;
        else
            if (SIG_multiplicateur = '1') then
                SIG_CORRECTION <= CONST_1024 & '0';
            else
                SIG_CORRECTION <= '0' & CONST_1024;
            end if;
        end if;  
    end process;
    
    sig_data    <= unsigned(signed(idata_n) + SIG_CORRECTION);
    
    compteur : process(clk, reset)
    begin
        if (reset = '1') then
            counter <= (OTHERS => '0');
        elsif (clk'event and clk = '1') then
            if (counter = unsigned(nbPeriode)) then
                counter <= (OTHERS => '0');
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    
    registre : process(clk, reset)
    begin
        if (reset = '1') then
            val_data <= to_unsigned(0, 13);
        elsif (clk'event and clk = '1') then
            if (ce = '1') then
                val_data <= sig_data;
            end if;
        end if;
    end process;
    
    
    modulateur : process(counter, val_data)
    begin
        if (counter < val_data) then    -- Pas besoin de vérifier que counter = 2266 car il ce remet à cette valeur dans un autre process
            odata   <= '1';
        else
            odata   <= '0';
        end if;
    end process;
end Behavioral;
