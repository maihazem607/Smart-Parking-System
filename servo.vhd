library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity servo is
  generic (
    clk_hz : integer := 50000000; 
    pulse_hz : integer := 50      
  );
  port (
    clk : in std_logic;
    rst : in std_logic;
    pulse_us : in integer;        
    pwm : out std_logic            
  );
end servo;

architecture rtl of servo is

  constant counter_max : integer := (clk_hz / pulse_hz) - 1;
  signal pulse_count : integer :=(clk_hz / 1000000) * pulse_us;
  signal counter : integer range 0 to counter_max := 0;


begin
 
  COUNTER_PROC : process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        counter <= 0;
      else
        if counter < counter_max then
          counter <= counter + 1;
        else
          counter <= 0;
        end if;
      end if;
    end if;
  end process;

  PWM_PROC : process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        pwm <= '0'; 
      else
        if counter < pulse_count then
          pwm <= '1';  
        else
          pwm <= '0'; 
        end if;
      end if;
    end if;
  end process;

end rtl;
