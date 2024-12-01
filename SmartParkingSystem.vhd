library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY SmartParkingSystem IS
	PORT(clk,button,sensor: IN STD_LOGIC;
			pwm: OUT STD_LOGIC;
			ledlight1, ledlight2: out std_logic_vector(0 to 6);
			sensor_enable: out std_logic);
END SmartParkingSystem;

ARCHITECTURE arch OF SmartParkingSystem IS

 constant clk_hz : integer := 50000000;
 constant pulse_hz : integer := 50;
 signal count:integer:=0;
 signal pulse_us : integer:= 1000;--in us to avoid real numbers
 signal motor_ctrl : std_logic := '0'; -- '0' = closed, '1' = open
 signal button_last : std_logic := '0';
 signal sensor_last : std_logic := '0';
 
  BEGIN
		sensor_enable<='1';
		MOTOR_CTRL_PROC : process(clk)
		begin
			 if rising_edge(clk) then
				  if button = '0' and button_last = '1'and count<10 then
				     if motor_ctrl='0' then
					     count<=count+1;
					  end if;
						motor_ctrl <= '1';
				  end if;
				  if sensor = '0' and sensor_last='1' then
						motor_ctrl <= '0'; 
				  end if;
				  button_last <= button; 
				  sensor_last <= sensor;
			 end if;
		end process;
--1500 is not resulting in angle 90 exactly that is why we used a different number
    pulse_us <= 1000 when motor_ctrl = '0' else 2000;
	 
	 
	SERVO : entity work.servo(rtl)
		generic map (
		clk_hz => clk_hz,
		pulse_hz => pulse_hz
	)
	port map (
		clk => clk,
		rst => '0',
		pulse_us => pulse_us,
		pwm => pwm
	);	

	seven_seg:entity work.seg(light)
	port map(
	num => count,
   ledlight1=>ledlight1, 
	ledlight2=>ledlight2
	);
	
END arch;