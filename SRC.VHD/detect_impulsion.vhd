----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 02.03.2021 14:25:45
-- Design Name: 
-- Module Name: detect_impulsion - Behavioral
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

entity detect_impulsion is
    Port (  clk         : in    std_logic;
            data_in     : in    std_logic;
            data_out    : out   std_logic
            );
end detect_impulsion;

architecture Behavioral of detect_impulsion is
    signal  prev_state : std_logic := '0';
begin
    process (clk)
    begin
        if (clk'event and clk = '1') then
            if (data_in = not(prev_state)) then
                data_out <= data_in;
            else
                data_out <= '0';
            end if;
            prev_state <= data_in;
        end if;
    end process;

end Behavioral;
