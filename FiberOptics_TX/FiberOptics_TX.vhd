------------------------------------------------------------------------------------------------------------------
-- Program Name : FiberOptics_TX.vhd			    			    							       			--
-- Programmer   : Nick Oudyk																					--
-- Date         : 11/21/12																						--
--																												--
-- Purpose      :The purpose of this program is to set up the TDM TX/RX for the Fiber Optics project.   		--
--																												--
-- HARDWARE ASSIGNMENT-INPUT - clk - 																			--
--					  -INPUT - TX - PIN_L22 (Switch 0)																		--
--					  -INPUT - Sensor1 - 																		--
--						  Sensor1(0) - PIN_																		--
--						  Sensor1(1) - PIN_																		--
--						  Sensor1(2) - PIN_																		--
--						  Sensor1(3) - PIN_																		--
--						  Sensor1(4) - PIN_																		--
--						  Sensor1(5) - PIN_																		--
--						  Sensor1(6) - PIN_																		--
--						  Sensor1(7) - PIN_																		--
--					  -INPUT - Sensor2 - 																		--
--						  Sensor2(0) - PIN_																		--
--						  Sensor2(1) - PIN_																		--
--						  Sensor2(2) - PIN_																		--
--						  Sensor2(3) - PIN_																		--
--						  Sensor2(4) - PIN_																		--
--						  Sensor2(5) - PIN_																		--
--						  Sensor2(6) - PIN_																		--
--						  Sensor2(7) - PIN_																		--
--					  -OUTPUT - serial - PIN_																	--
------------------------------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FiberOptics_TX IS	
	PORT (clk, TX: IN STD_LOGIC;
		  Sensor1, Sensor2: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		  serial, clockOut: OUT STD_LOGIC);
END FiberOptics_TX;

ARCHITECTURE behaviour OF FiberOptics_TX IS

	CONSTANT HIGH : STD_LOGIC := '1';
	CONSTANT LOW  : STD_LOGIC := '0';
	CONSTANT SYNC  : STD_LOGIC_VECTOR := "111111111";
		
	BEGIN				
		PROCESS(clk)
			VARIABLE bitSend : INTEGER RANGE 0 TO 35 := 0;
			VARIABLE outBuffer : STD_LOGIC_VECTOR (35 DOWNTO 0);
			
			BEGIN
				IF (TX = HIGH) THEN
					clockOut <= clk;
					IF (rising_edge(clk)) THEN
						IF (bitSend = 0) THEN
							outBuffer(8 DOWNTO 0) := SYNC;
							outBuffer(16 DOWNTO 9) := Sensor1;
							outBuffer(17) := LOW;
							outBuffer(25 DOWNTO 18) := Sensor1;--Sensor2; Sensor 1 for test purposes
							outBuffer(26) := LOW;
							outBuffer(34 DOWNTO 27) := outBuffer(16 DOWNTO 9) XOR outBuffer(25 DOWNTO 18);
							outBuffer(35) := LOW;							
						END IF;
						serial <= outBuffer(bitSend);
						bitSend := (bitSend + 1) MOD 36;
					END IF;
				ELSE
					bitSend := 0;
					serial <= LOW;
					clockOut <= LOW;
				END IF;
			END PROCESS;		
	END;