library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seg is
port( 
    num : in integer;
    ledlight1, ledlight2 : out std_logic_vector(0 to 6)
);
end seg;

architecture light of seg is
begin
    process(num)
    begin
        if (num = 0) then 
            ledlight1 <= "0000001"; 
            ledlight2 <= "0000001";
        elsif (num = 1) then 
            ledlight1 <= "1001111"; 
            ledlight2 <= "0000001";
        elsif (num = 2) then 
            ledlight1 <= "0010010"; 
            ledlight2 <= "0000001";
        elsif (num = 3) then 
            ledlight1 <= "0000110"; 
            ledlight2 <= "0000001";
        elsif (num = 4) then 
            ledlight1 <= "1001100"; 
            ledlight2 <= "0000001";
        elsif (num = 5) then 
            ledlight1 <= "0100100"; 
            ledlight2 <= "0000001";
        elsif (num = 6) then 
            ledlight1 <= "0100000"; 
            ledlight2 <= "0000001";
        elsif (num = 7) then 
            ledlight1 <= "0001111"; 
            ledlight2 <= "0000001";
        elsif (num = 8) then 
            ledlight1 <= "0000000"; 
            ledlight2 <= "0000001";
        elsif (num = 9) then 
            ledlight1 <= "0000100"; 
            ledlight2 <= "0000001";
        else 
            ledlight1 <= "0000001"; 
            ledlight2 <= "1001111";
        end if;
    end process;
end light;
