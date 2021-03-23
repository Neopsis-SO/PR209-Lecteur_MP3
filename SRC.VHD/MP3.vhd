----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 17.03.2021 14:17:33
-- Design Name: 
-- Module Name: MP3 - Behavioral
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

entity MP3 is
    Port (  CLK100MHZ       : in    std_logic;
            reset           : in    std_logic;
            BTNU            : in    std_logic;  --Bouton haut
            BTND            : in    std_logic;  --Bouton bas
            BTNL            : in    std_logic;  --Bouton gauche
            BTNR            : in    std_logic;  --Bouton droite
            BTNC            : in    std_logic;  --Bouton centre
            UART_TXD_IN     : in    std_logic;
            Sevenseg        : out   std_logic_vector(7 downto 0);
            AN              : out   std_logic_vector(7 downto 0);
            AUD_PWM         : out   std_logic;
            AUD_SD          : out   std_logic
            );
end MP3;

architecture Behavioral of MP3 is
    component gestion_MP3
        Port (  CLK100MHZ   : in    std_logic;
                reset       : in    std_logic;
                BTNU        : in    std_logic;  --Bouton haut
                BTND        : in    std_logic;  --Bouton bas
                BTNL        : in    std_logic;  --Bouton gauche
                BTNR        : in    std_logic;  --Bouton droite
                BTNC        : in    std_logic;  --Bouton centre
                Sevenseg    : out   std_logic_vector(7 downto 0);
                AN          : out   std_logic_vector(7 downto 0);
                Sound_level : out   std_logic_vector(3 downto 0);
                Init_add    : out   std_logic;
                Start_add   : out   std_logic;
                Forward_add : out   std_logic
                );
    end component;
    
    component gestion_echantillon
        Port (  CLK100MHZ       : in    std_logic;
                reset           : in    std_logic;
                r_w             : in    std_logic;  --Ecriture a 1 / Lecture a 0 dans la memoire
                init            : in    std_logic;
                start           : in    std_logic;
                forward         : in    std_logic;
                sound_level     : in    std_logic_vector(3 downto 0);
                addr_from_uart  : in    std_logic_vector(17 downto 0);
                data_from_uart  : in    std_logic_vector(15 downto 0);
                AUD_PWM         : out   std_logic;
                AUD_SD          : out   std_logic
                );
    end component;
    
    component full_uart_recv
        PORT (  clk_100MHz  : in  STD_LOGIC;
                reset       : in  STD_LOGIC;
                rx          : in  STD_LOGIC;
        
                memory_addr : out STD_LOGIC_VECTOR (17 downto 0);
                data_value  : out STD_LOGIC_VECTOR (15 downto 0);
                memory_wen  : out STD_LOGIC
                );  
    end component;
    
    signal RESET_BARRE  : std_logic; --signal a n'utiliser que sur les full_uart_recv
    signal RW           : std_logic;
    signal INIT         : std_logic;
    signal START        : std_logic;
    signal FORWARD      : std_logic;
    signal DATA_TO_SAVE : std_logic_vector (15 downto 0);
    signal ADDR_TO_SAVE : std_logic_vector (17 downto 0);
    signal SOUND_LEVEL  : std_logic_vector (3 downto 0);
    
begin
    RESET_BARRE <= not(reset); 
    
    GESTION : gestion_MP3
        Port Map (  CLK100MHZ,
                    reset,
                    BTNU,
                    BTND,
                    BTNL,
                    BTNR,
                    BTNC,
                    Sevenseg,
                    AN,
                    SOUND_LEVEL,
                    INIT,
                    START,
                    FORWARD
                    );
                    
    ENCHANTILLONS : gestion_echantillon
        Port Map (  CLK100MHZ,
                    reset,
                    RW,
                    INIT,
                    START,
                    FORWARD,
                    SOUND_LEVEL,
                    ADDR_TO_SAVE,
                    DATA_TO_SAVE,
                    AUD_PWM,
                    AUD_SD
                    );

    UART : full_uart_recv
        PORT MAP (
                CLK100MHZ,
                RESET_BARRE,
                UART_TXD_IN,
                ADDR_TO_SAVE,
                DATA_TO_SAVE,
                RW
                );
    
end Behavioral;
