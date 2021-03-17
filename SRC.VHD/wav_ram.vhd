----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime DABROWSKI
-- 
-- Create Date: 15.03.2021 16:30:13
-- Design Name: 
-- Module Name: wav_ram - Behavioral
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

entity wav_ram is
    Port (  clk         : in    std_logic;
            r_w         : in    std_logic;  --Ecriture a 1 / Lecture a 0
            addr_in_w   : in    std_logic_vector(17 downto 0);  --Adresse de la data devant être ecrite dans la RAM
            data_in_w   : in    std_logic_vector(10 downto 0);  --Data devant être ecrite dans la RAM a l'adresse ci-dessus
            addr_in_r   : in    std_logic_vector(17 downto 0);  --Addresse de la data allant au modulateur
            data_out_r  : out   std_logic_vector(10 downto 0)   --Data allant jusqu au modulateur a partir de l adresse ci-dessus
            );
end wav_ram;

architecture Behavioral of wav_ram is
    TYPE RAM IS ARRAY (0 TO 262143) OF std_logic_vector(10 downto 0);   --2^18-1 = 262 143 espace memoire de donnees sur 11 bits
    signal Mem : RAM;
    
begin
    memory : process(clk)
    begin
        if(clk'event and clk='0') then
            if(r_w = '1') then
                Mem(to_integer(unsigned(addr_in_w))) <= data_in_w;
            end if;
            data_out_r <= Mem(to_integer(unsigned(addr_in_r))); --Ecriture de 2* le if pour ne pas desynchroniser les modules si lecture et ecriture au même CE
        end if;
    end process;

end Behavioral;
