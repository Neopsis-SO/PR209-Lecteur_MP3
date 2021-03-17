----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 15.03.2021 17:24:41
-- Design Name: 
-- Module Name: gestion_echantillon - Behavioral
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

entity gestion_echantillon is
    Port (  CLK100MHZ       : in    std_logic;
            reset           : in    std_logic;
            r_w             : in    std_logic;  --Ecriture a 1 / Lecture a 0 dans la memoire
            addr_from_uart  : in    std_logic_vector(17 downto 0);
            data_from_uart  : in    std_logic_vector(15 downto 0);
            AUD_PWM         : out   std_logic;
            AUD_SD          : out   std_logic
            );
end gestion_echantillon;

architecture Behavioral of gestion_echantillon is
    component gestion_freq_audio
        Port (  clk             : in    std_logic;
                reset           : in    std_logic;
                cePWM           : out   std_logic  -- Frequence de 44100Hz
                );
    end component;
    
    component cpt_18bits
        Port (  clk     : in    std_logic;
                reset   : in    std_logic;
                ce      : in    std_logic;
                addr_w  : in    std_logic_vector(17 downto 0);
                addr_r  : out   std_logic_vector(17 downto 0)
                );
    end component;
    
    component wav_ram
        Port (  clk         : in    std_logic;
                r_w         : in    std_logic;  --Ecriture a 1 / Lecture a 0
                addr_in_w   : in    std_logic_vector(17 downto 0);  --Adresse de la data devant être ecrite dans la RAM
                data_in_w   : in    std_logic_vector(10 downto 0);  --Data devant être ecrite dans la RAM a l'adresse ci-dessus
                addr_in_r   : in    std_logic_vector(17 downto 0);  --Addresse de la data allant au modulateur
                data_out_r  : out   std_logic_vector(10 downto 0)   --Data allant jusqu au modulateur a partir de l adresse ci-dessus
                );
    end component;
    
    component PWM
        Port (  clk     : in    std_logic;
                reset   : in    std_logic;
                ce      : in    std_logic;
                idata_n : in    std_logic_vector(10 downto 0);
                odata   : out   std_logic;
                enable  : out   std_logic
                );
    end component;
    
    signal RESET_BARRE  : std_logic;
    signal CE44100      : std_logic;
    signal ADDRESS_R    : std_logic_vector(17 downto 0);
    signal RAM_VALUE    : std_logic_vector(10 downto 0);
    
begin

    RESET_BARRE <= not(reset);
    
    BASE_DE_TEMPS_44100Hz : gestion_freq_audio
        PORT MAP (  CLK100MHZ,
                    RESET_BARRE,
                    CE44100
                    );
    
    COMPTEUR_D_ADRESSE : cpt_18bits
        PORT MAP (  CLK100MHZ,
                    RESET_BARRE,
                    CE44100,
                    addr_from_uart,
                    ADDRESS_R
                    );
        
    RAM : wav_ram
        PORT MAP (  CLK100MHZ,
                    r_w,
                    addr_from_uart,
                    data_from_uart(10 downto 0),
                    ADDRESS_R,
                    RAM_VALUE
                    );
        
    Module_PWM : PWM
        PORT MAP (  CLK100MHZ,
                    RESET_BARRE,
                    CE44100,
                    RAM_VALUE,
                    AUD_PWM,
                    AUD_SD
                    );

end Behavioral;
