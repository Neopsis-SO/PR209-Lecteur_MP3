----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 23.03.2021 17:17:23
-- Design Name: 
-- Module Name: coder - Behavioral
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

entity coder is
    Port (  switchs : in    std_logic_vector(2 downto 0);
            code    : out   std_logic_vector(4 downto 0)
            );
end coder;

architecture Behavioral of coder is

begin
    with switchs select
    code <= 
        "00010" when "001",
        "00100" when "010",
        "10010" when "101",
        "10100" when "110",
        "00001" when OTHERS;
    
end Behavioral;
