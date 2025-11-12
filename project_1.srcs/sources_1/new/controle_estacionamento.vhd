LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Estacionamento IS
  PORT (
    clk : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    sensor_entrada : IN STD_LOGIC;
    sensor_saida : IN STD_LOGIC;
    vagas_disponiveis : OUT INTEGER RANGE 0 TO 10;
    lotado : OUT STD_LOGIC
  );
END ENTITY;

ARCHITECTURE Behavioral OF Estacionamento IS
  SIGNAL vagas : INTEGER RANGE 0 TO 10 := 10; -- começa com 10 vagas
BEGIN
  PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      vagas <= 10; -- reinicia com 10 vagas
    ELSIF rising_edge(clk) THEN
      IF sensor_entrada = '1' AND vagas > 0 THEN
        vagas <= vagas - 1;
      ELSIF sensor_saida = '1' AND vagas < 10 THEN
        vagas <= vagas + 1;
      END IF;
    END IF;
  END PROCESS;

  vagas_disponiveis <= vagas;
  lotado <= '1' WHEN vagas = 0 ELSE
    '0';
END ARCHITECTURE;