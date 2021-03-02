----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 02.03.2021 14:25:45
-- Design Name: 
-- Module Name: fsm_MP3 - Behavioral
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

entity fsm_MP3 is
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
end fsm_MP3;

architecture Behavioral of fsm_MP3 is
    type Etat is (Etat_Init, Etat_Play_Fwd, Etat_Play_Bwd, Etat_Pause, Etat_Stop);
    signal pr_state, nx_state : Etat := Etat_Init;
begin
    state_update : process (clk, reset)
    begin
        if(reset = '1') then
            pr_state <= Etat_Init;
        elsif(clk'event and clk='1') then
            pr_state <= nx_state;
        end if;
    end process;


    compute_nx_state : process (pr_state, b_center, b_left, b_right)
    begin
        case pr_state is
            when Etat_Init => 
                if (b_center = '1') then
                    nx_state <= Etat_Play_Fwd;
                else
                    nx_state <= Etat_Init;
                end if;
            
            when Etat_Play_Fwd => 
                if (b_center = '1') then
                    nx_state <= Etat_Pause;
                else
                    nx_state <= Etat_Play_Fwd;
                end if;
                
            when Etat_Play_Bwd => 
                if (b_center = '1') then
                    nx_state <= Etat_Pause;
                else
                    nx_state <= Etat_Play_Bwd;
                end if;
                
            when Etat_Pause => 
                if (b_right = '1') then
                    nx_state <= Etat_Play_Fwd;
                elsif (b_left = '1') then
                    nx_state <= Etat_Play_Bwd;
                elsif (b_center = '1') then
                    nx_state <= Etat_Stop;
                else
                    nx_state <= Etat_Pause;
                end if;
            
            when Etat_Stop => 
                if (b_center = '1') then
                    nx_state <= Etat_Pause;
                else
                    nx_state <= Etat_Stop;
                end if;
                
        end case;
    end process;
    
    compute_output : process (pr_state, b_up, b_down)
    begin
        case pr_state is
            when Etat_Init => 
                play_pause  <= '0';
                restart     <= '1';
                forward     <= '0';
                volume_up   <= '0';
                volume_down <= '0';
                
            when Etat_Play_Fwd => 
                play_pause  <= '1';
                restart     <= '0';
                forward     <= '1';
                volume_up   <= b_up;
                volume_down <= b_down;
                
            when Etat_Play_Bwd => 
                play_pause  <= '1';
                restart     <= '0';
                forward     <= '0';
                volume_up   <= b_up;
                volume_down <= b_down;
                
            when Etat_Pause => 
                play_pause  <= '0';
                restart     <= '0';
                forward     <= '0';
                volume_up   <= '0';
                volume_down <= '0';
                
            when Etat_Stop => 
                play_pause  <= '0';
                restart     <= '1';
                forward     <= '0';
                volume_up   <= '0';
                volume_down <= '0';
                
         end case;
    end process;

end Behavioral;
