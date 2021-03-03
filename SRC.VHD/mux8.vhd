----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 02.03.2021 14:25:45
-- Design Name: 
-- Module Name: mux8 - Behavioral
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

entity mux8 is
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
end mux8;

architecture Behavioral of mux8 is

begin
    process(E0, E1, E2, E3, E4, E5, E6, E7, CMD)
    begin
        case CMD is
                when "000"  => S <='1'&E0;
                when "001"  => S <='1'&E1;
                when "010"  => S <='1'&E2;
                when "011"  => S <='0'&E3;
                when "100"  => S <='1'&E4;
                when "101"  => S <='1'&E5;
                when "110"  => S <='1'&E6;
                when "111"  => S <='1'&E7;
                when others => S <= (OTHERS=> '1');
        end case;
    end process;

end Behavioral;
