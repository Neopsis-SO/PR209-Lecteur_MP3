----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 10.03.2021 14:26:49
-- Design Name: 
-- Module Name: lecteur_echantillon - Behavioral
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

entity lecteur_echantillon is
    Port (  CLK100MHZ    : in    std_logic;
            reset       : in    std_logic;
            AUD_PWM     : out   std_logic
            );
end lecteur_echantillon;

architecture Behavioral of lecteur_echantillon is
    component gestion_freq_audio
        Port (  clk             : in    std_logic;
                reset           : in    std_logic;
                cePWM           : out   std_logic  -- Frequence de 44100Hz
                );
    end component;
    
    component cpt_0_44099
        Port (  clk     : in    std_logic;
                reset   : in    std_logic;
                ce      : in    std_logic;
                addr    : out   std_logic_vector(15 downto 0)
                );
    end component;
    
    component wav_rom
        PORT (    CLOCK          : IN  STD_LOGIC;
                  ADDR_R         : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
                  DATA_OUT       : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
                  );
    end component;
    
    component PWM
        Port (  clk     : in    std_logic;
                reset   : in    std_logic;
                ce      : in    std_logic;
                idata_n : in    std_logic_vector(10 downto 0);
                odata   : out   std_logic
                );
    end component;
    
    signal RESET_BARRE  : std_logic;
    signal CE44100      : std_logic;
    signal ADDRESS      : std_logic_vector(15 downto 0);
    signal ROM_VALUE    : std_logic_vector(10 downto 0);
    
begin

    RESET_BARRE <= not(reset);
    
    BASE_DE_TEMPS_44100Hz : gestion_freq_audio
        PORT MAP (  CLK100MHZ,
                    RESET_BARRE,
                    CE44100
                    );
    
    COMPTEUR_D_ADRESSE : cpt_0_44099
        PORT MAP (  CLK100MHZ,
                    RESET_BARRE,
                    CE44100,
                    ADDRESS
                    );
        
    ROM : wav_rom
        PORT MAP (  CLK100MHZ,
                    ADDRESS,
                    ROM_VALUE
                    );
        
    Module_PWM : PWM
        PORT MAP (  CLK100MHZ,
                    RESET_BARRE,
                    CE44100,
                    ROM_VALUE,
                    AUD_PWM
                    );
                    
end Behavioral;
