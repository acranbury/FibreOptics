LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FiberOptics_RX IS

	GENERIC ( 	N_CLIENTS : 		INTEGER := 4;
					N_CLIENT_BITS : 	INTEGER := 8 );	
					
	PORT(	clk:		IN		STD_LOGIC;
			d:			IN		INTEGER RANGE 0 TO 1;
			b:			OUT	STD_LOGIC;
			q: 		OUT	STD_LOGIC_VECTOR( (N_CLIENTS*N_CLIENT_BITS)-1 DOWNTO 0) );	
			
END FiberOptics_RX;


ARCHITECTURE decode OF FiberOptics_RX IS

	TYPE ca_int 	IS ARRAY (0 TO N_CLIENTS-1) 	OF INTEGER RANGE 0 TO (2**N_CLIENT_BITS)-1;
	TYPE a_bool 	IS ARRAY (0 TO 1) 				OF BOOLEAN;
	TYPE ca_bool 	IS ARRAY (0 TO N_CLIENTS-1) 	OF a_bool;

	CONSTANT bitCounts : ca_int := (
		N_CLIENT_BITS, 
		N_CLIENT_BITS, 
		N_CLIENT_BITS, 
		N_CLIENT_BITS );
		
	SIGNAL client : INTEGER RANGE 0 TO N_CLIENTS-1;

	BEGIN
	
		WITH client SELECT 
			q <= 	(0=>'1', OTHERS=>'0') WHEN 0,
					(1=>'1', OTHERS=>'0') WHEN 1,
					(2=>'1', OTHERS=>'0') WHEN 2,
					(3=>'1', OTHERS=>'0') WHEN 3;
					
			b <= clk;
			
		PROCESS(clk) IS

			VARIABLE bitCount : 	INTEGER RANGE 0 TO (N_CLIENTS*N_CLIENT_BITS)-1;
			VARIABLE syncCount : INTEGER RANGE 0 TO (N_CLIENTS*N_CLIENT_BITS)-1;
			
			BEGIN
				IF ( FALLING_EDGE(clk) ) THEN
				
					bitCount := bitCount + 1;
					
					-- Count the number of sequential '1's received
					IF ( d = 1 ) THEN
						syncCount := syncCount + 1;
					ELSE
						syncCount := 0;
					END IF;
					
					-- A long string of '1's always indicates the start of a new frame
					IF ( syncCount = bitCounts(0) ) THEN
						client <= 1;
						syncCount := 0;
						bitCount := 0;
					END IF;
					
					-- Read a known number of bits from other clients
					IF ( client /= 0 AND bitCount = bitCounts(client) ) THEN			
						client <= (client+1) MOD N_CLIENTS;
						bitCount := 0;
						syncCount := 0;
					END IF;
				END IF;	
	END PROCESS;
END;