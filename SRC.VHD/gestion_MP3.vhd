----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 03.03.2021 17:26:04
-- Design Name: 
-- Module Name: gestion_MP3 - Behavioral
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

entity gestion_MP3 is
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
end gestion_MP3;

architecture Behavioral of gestion_MP3 is

    component detect_impulsion
    Port (  clk         : in    std_logic;
            data_in     : in    std_logic;
            data_out    : out   std_logic
            );
    end component;
    
    component fsm_MP3
        Port (  clk         : in    std_logic;
            reset       : in    std_logic;
            b_up        : in    std_logic;
            b_down      : in    std_logic;
            b_center    : in    std_logic;
            b_left      : in    std_logic;
            b_right     : in    std_logic;
            play_pause  : out   std_logic;
            restart     : out   std_logic;
            forward     : out   std_logic;
            volume_up   : out   std_logic;
            volume_down : out   std_logic
            );
    end component;
    
    component gestion_freq
        Port (  clk             : in    std_logic;
            reset           : in    std_logic;
            ceAffichage     : out   std_logic;  -- Frequence de 10Hz
            cePerception    : out   std_logic   -- Frequence de 3kHz
            );
    end component;
    
    component cpt_1_9
        Port (  clk     : in    std_logic;
            reset   : in    std_logic;
            restart : in    std_logic;
            inc     : in    std_logic;
            dec     : in    std_logic;
            value   : out   std_logic_vector(3 downto 0)
            );
    end component;
    
    component cpt_1_599
        Port (  clk     : in    std_logic;
            reset   : in    std_logic;
            ce      : in    std_logic;
            init    : in    std_logic;
            start   : in    std_logic;
            forward : in    std_logic;
            value   : out   std_logic_vector(9 downto 0)
            );
    end component;
    
    component transcodeur
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
    end component;
    
    component mod8
        Port (  clk     : in    std_logic;
            reset   : in    std_logic;
            ce      : in    std_logic;
            an      : out   std_logic_vector(7 downto 0);   --anodes
            sel     : out   std_logic_vector(2 downto 0)    --command to the 7 segments mux (8 7 segments so 2^3 = 8)
            );
    end component;
    
    component mux8
        Port (  CMD : in   std_logic_vector(2 downto 0);
            E0  : in   std_logic_vector(6 downto 0);
            E1  : in   std_logic_vector(6 downto 0);
            E2  : in   std_logic_vector(6 downto 0);
            E3  : in   std_logic_vector(6 downto 0);
            E4  : in   std_logic_vector(6 downto 0);
            E5  : in   std_logic_vector(6 downto 0);
            E6  : in   std_logic_vector(6 downto 0);
            E7  : in   std_logic_vector(6 downto 0);
            S   : out  std_logic_vector(7 downto 0)
            );
    end component;
    
    signal RESET_BARRE      : STD_LOGIC;
    signal SIG_B_UP             : STD_LOGIC;
    signal SIG_B_DOWN           : STD_LOGIC;
    signal SIG_B_LEFT           : STD_LOGIC;
    signal SIG_B_RIGHT          : STD_LOGIC;
    signal SIG_B_CENTER         : STD_LOGIC;
    signal SIG_CE_AFFICHAGE     : STD_LOGIC;
    signal SIG_CE_PERCEPTION    : STD_LOGIC;
    signal SIG_FORWARD          : STD_LOGIC;
    signal SIG_PLAY_PAUSE       : STD_LOGIC;
    signal SIG_RESTART          : STD_LOGIC;
    signal SIG_VOLUME_UP        : STD_LOGIC;
    signal SIG_VOLUME_DOWN      : STD_LOGIC;
    signal SIG_NB_SON           : STD_LOGIC_VECTOR(3 downto 0);
    signal SIG_NB_TIME          : STD_LOGIC_VECTOR(9 downto 0);
    signal SIG_COMMANDE         : STD_LOGIC_VECTOR(2 downto 0);
    signal SIG_E0               : STD_LOGIC_VECTOR(6 downto 0);
    signal SIG_E1               : STD_LOGIC_VECTOR(6 downto 0);
    signal SIG_E2               : STD_LOGIC_VECTOR(6 downto 0);
    signal SIG_E3               : STD_LOGIC_VECTOR(6 downto 0);
    signal SIG_E4               : STD_LOGIC_VECTOR(6 downto 0);
    signal SIG_E5               : STD_LOGIC_VECTOR(6 downto 0);
    signal SIG_E6               : STD_LOGIC_VECTOR(6 downto 0);
    signal SIG_E7               : STD_LOGIC_VECTOR(6 downto 0);
    
begin

    RESET_BARRE <= not(reset);
    Sound_level <= SIG_NB_SON;
    Init_add    <= SIG_RESTART;
    Start_add   <= SIG_PLAY_PAUSE;
    Forward_add <= SIG_FORWARD;
            
    REG_B_CENTER : detect_impulsion 
        PORT MAP (  CLK100MHZ,
                    BTNC,
                    SIG_B_CENTER
                    );

    REG_B_DOWN : detect_impulsion 
        PORT MAP (  CLK100MHZ,
                    BTND,
                    SIG_B_DOWN
                    );
                    
    REG_B_LEFT : detect_impulsion 
        PORT MAP (  CLK100MHZ,
                    BTNL,
                    SIG_B_LEFT
                    );
                    
    REG_B_RIGHT : detect_impulsion 
        PORT MAP (  CLK100MHZ,
                    BTNR,
                    SIG_B_RIGHT
                    );
                    
    REG_B_UP : detect_impulsion 
        PORT MAP (  CLK100MHZ,
                    BTNU,
                    SIG_B_UP
                    );

    FSM : fsm_MP3
        PORT MAP (  CLK100MHZ,
                    RESET_BARRE,
                    SIG_B_UP,
                    SIG_B_DOWN,
                    SIG_B_CENTER,
                    SIG_B_LEFT,
                    SIG_B_RIGHT,
                    SIG_PLAY_PAUSE,
                    SIG_RESTART,
                    SIG_FORWARD,
                    SIG_VOLUME_UP,
                    SIG_VOLUME_DOWN
                    );
                    
    GESTION_F : gestion_freq
        PORT MAP (  CLK100MHZ,
                    RESET_BARRE,
                    SIG_CE_AFFICHAGE,
                    SIG_CE_PERCEPTION
                    );

    GESTION_SON : cpt_1_9
        PORT MAP (  CLK100MHZ,
                    RESET_BARRE,
                    SIG_RESTART,
                    SIG_VOLUME_UP,
                    SIG_VOLUME_DOWN,
                    SIG_NB_SON
                    );

    GESTION_TEMP : cpt_1_599
        PORT MAP (  CLK100MHZ,
                    RESET_BARRE,
                    SIG_CE_AFFICHAGE,
                    SIG_RESTART,
                    SIG_PLAY_PAUSE,
                    SIG_FORWARD,
                    SIG_NB_TIME
                    );
                    
    TRANSCOD : transcodeur
        PORT MAP (  SIG_PLAY_PAUSE,
                    SIG_RESTART,
                    SIG_FORWARD,
                    SIG_NB_SON,
                    SIG_NB_TIME,
                    SIG_E0,
                    SIG_E1,
                    SIG_E2,
                    SIG_E3,
                    SIG_E4,
                    SIG_E5,
                    SIG_E6,
                    SIG_E7
                    );

    SELECT_7_SEGMENT : mod8
        PORT MAP (  CLK100MHZ,
                    RESET_BARRE,
                    SIG_CE_PERCEPTION,
                    AN,
                    SIG_COMMANDE
                    );

    MULTIPLEX : mux8
        PORT MAP (  SIG_COMMANDE,
                    SIG_E0,
                    SIG_E1,
                    SIG_E2,
                    SIG_E3,
                    SIG_E4,
                    SIG_E5,
                    SIG_E6,
                    SIG_E7,
                    Sevenseg
                    );
                    
end Behavioral;
