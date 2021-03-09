----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime Dabrowski
-- 
-- Create Date: 09.03.2021 16:00:08
-- Design Name: 
-- Module Name: PWM - Behavioral
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

entity PWM is
    Port (  clk     : in    std_logic;
            reset   : in    std_logic;
            ce      : in    std_logic;
            idata_n : in    std_logic_vector(10 downto 0);
            odata   : out   std_logic
            );
end PWM;

architecture Behavioral of PWM is
    signal val_data : unsigned(11 downto 0);
    signal counter  : unsigned(11 downto 0);
    
begin

    val_data <= unsigned(signed(idata_n) + to_signed(1024,12));

    process(clk, reset)
    begin
        if (reset = '1') then
            counter <= to_unsigned(0, 12);
            odata   <= '0';
        elsif (clk'event and clk = '1') then
            if (ce = '1') then
                if (counter = 2067) then
                    odata   <= '0';
                    counter <= (OTHERS => '0');
                else
                    if (counter < val_data) then
                        odata   <= '1';
                    else
                        odata   <= '0';
                    end if;
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
