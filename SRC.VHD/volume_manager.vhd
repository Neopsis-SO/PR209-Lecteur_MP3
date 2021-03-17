----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 17.03.2021 15:49:02
-- Design Name: 
-- Module Name: volume_manager - Behavioral
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

entity volume_manager is
    Port (  clk     : in    std_logic;
            reset   : in    std_logic;
            ce      : in    std_logic;
            switch  : in    std_logic_vector(3 downto 0);
            idata   : in    std_logic_vector(10 downto 0);
            odata   : out   std_logic_vector(10 downto 0)
            );
end volume_manager;

architecture Behavioral of volume_manager is

begin

    compteur_adresse : process(clk, reset)
    begin
        if (reset = '1') then
            odata  <= (OTHERS => '0');
        elsif (clk'event and clk = '1') then
            if (ce = '1') then
                case switch is
                    when "0000" => odata <= idata(10 downto 9)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10);
                    when "0001" => odata <= idata(10 downto 8)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10);
                    when "0010" => odata <= idata(10 downto 7)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10);
                    when "0011" => odata <= idata(10 downto 6)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10);
                    when "0100" => odata <= idata(10 downto 5)&idata(10)&idata(10)&idata(10)&idata(10)&idata(10);
                    when "0101" => odata <= idata(10 downto 4)&idata(10)&idata(10)&idata(10)&idata(10);
                    when "0110" => odata <= idata(10 downto 3)&idata(10)&idata(10)&idata(10);
                    when "0111" => odata <= idata(10 downto 2)&idata(10)&idata(10);
                    when "1000" => odata <= idata(10 downto 1)&idata(10);
                    when "1001" => odata <= idata;
                    when OTHERS => odata <= idata(10 downto 4)&idata(10)&idata(10)&idata(10)&idata(10);
                end case;
            end if;
        end if;
    end process;

end Behavioral;
