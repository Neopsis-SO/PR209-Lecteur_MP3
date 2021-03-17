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
            UART_RXD_OUT    : in    std_logic;
            Sevenseg        : out   std_logic_vector(7 downto 0);
            AN              : out   std_logic_vector(7 downto 0);
            AUD_PWM         : out   std_logic;
            AUD_SD          : out   std_logic
            );
end MP3;

architecture Behavioral of MP3 is

begin


end Behavioral;
