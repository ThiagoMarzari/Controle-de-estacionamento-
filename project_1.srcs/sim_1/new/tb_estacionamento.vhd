LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_Estacionamento IS
END ENTITY;

ARCHITECTURE sim OF tb_Estacionamento IS
  SIGNAL clk, reset : STD_LOGIC := '0';
  SIGNAL sensor_entrada, sensor_saida : STD_LOGIC := '0';
  SIGNAL vagas_disponiveis : INTEGER RANGE 0 TO 10;
  SIGNAL lotado : STD_LOGIC;
  CONSTANT CLK_PERIOD : TIME := 10 ns;
BEGIN
  uut : ENTITY work.Estacionamento
    PORT MAP(
      clk => clk,
      reset => reset,
      sensor_entrada => sensor_entrada,
      sensor_saida => sensor_saida,
      vagas_disponiveis => vagas_disponiveis,
      lotado => lotado
    );

  -- Geração de clock
  clk_process : PROCESS
  BEGIN
    WHILE true LOOP
      clk <= '0';
      WAIT FOR CLK_PERIOD / 2;
      clk <= '1';
      WAIT FOR CLK_PERIOD / 2;
    END LOOP;
  END PROCESS;

  -- Estímulos
  stim_proc : PROCESS
  BEGIN
    reset <= '1';
    WAIT FOR 20 ns;
    reset <= '0';

    -- 3 carros entram
    WAIT FOR 20 ns;
    sensor_entrada <= '1';
    WAIT FOR 10 ns;
    sensor_entrada <= '0';

    WAIT FOR 20 ns;
    sensor_entrada <= '1';
    WAIT FOR 10 ns;
    sensor_entrada <= '0';

    WAIT FOR 20 ns;
    sensor_entrada <= '1';
    WAIT FOR 10 ns;
    sensor_entrada <= '0';

    -- 1 carro sai
    WAIT FOR 30 ns;
    sensor_saida <= '1';
    WAIT FOR 10 ns;
    sensor_saida <= '0';

    -- Enche o estacionamento
    FOR i IN 1 TO 7 LOOP
      WAIT FOR 20 ns;
      sensor_entrada <= '1';
      WAIT FOR 10 ns;
      sensor_entrada <= '0';
    END LOOP;

    -- Tenta entrar mais um (lotado)
    WAIT FOR 20 ns;
    sensor_entrada <= '1';
    WAIT FOR 10 ns;
    sensor_entrada <= '0';

    WAIT FOR 100 ns;
    WAIT;
  END PROCESS;
END ARCHITECTURE;