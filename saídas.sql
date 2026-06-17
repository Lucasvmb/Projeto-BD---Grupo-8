-- a) Quantos e quais campeonatos de voleibol, basquete e rugby estão cadastrados e em andamento atualmente?
SELECT
    COUNT(*) AS total_campeonatos
FROM vw_campeonatos_edicoes
WHERE modalidade IN ('Voleibol', 'Basquete', 'Rugby')
  AND temporada = 2026
  AND status = 'Em andamento';
  
SELECT 
    modalidade,
    campeonato,
    categoria,
    genero,
    temporada,
    status
FROM vw_campeonatos_edicoes
WHERE modalidade IN ('Voleibol', 'Basquete', 'Rugby')
  AND temporada = 2026
  AND status = 'Em andamento'
ORDER BY modalidade, campeonato, categoria, genero;

-- b) Quais equipes de futebol possuem o maior número de vitórias em uma única temporada?
SELECT
    equipe,
    temporada,
    total_vitorias
FROM vw_vitorias_futebol_temporada
WHERE total_vitorias = (
    SELECT MAX(total_vitorias)
    FROM vw_vitorias_futebol_temporada
)
ORDER BY temporada DESC, equipe;

-- c) Quais atletas são os maiores artilheiros ou pontuadores dos campeonatos nas últimas 10 temporadas em cada modalidade esportiva cadastrada?
SELECT
    modalidade,
    atleta,
    total_gols,
    total_pontos,
    total_geral
FROM vw_totais_atletas_modalidade
WHERE total_geral = (
    SELECT MAX(v2.total_geral)
    FROM vw_totais_atletas_modalidade v2
    WHERE v2.modalidade = vw_totais_atletas_modalidade.modalidade
)
ORDER BY modalidade, atleta;

-- d) Qual é a classificação geral das equipes de futebol masculino das categorias sub-11, sub-13, sub-15 e sub-17, com base em pontos conquistados no campeonato da temporada passada?
SELECT
    equipe,
    jogos,
    pontos
FROM vw_classificacao_futebol_base_2025
WHERE categoria = 'Sub-11'
ORDER BY pontos DESC, equipe;

SELECT
    equipe,
    jogos,
    pontos
FROM vw_classificacao_futebol_base_2025
WHERE categoria = 'Sub-13'
ORDER BY pontos DESC, equipe;

SELECT
    equipe,
    jogos,
    pontos
FROM vw_classificacao_futebol_base_2025
WHERE categoria = 'Sub-15'
ORDER BY pontos DESC, equipe;

SELECT
    equipe,
    jogos,
    pontos
FROM vw_classificacao_futebol_base_2025
WHERE categoria = 'Sub-17'
ORDER BY pontos DESC, equipe;

-- e) Quais partidas do campeonato de voleibol feminino na categoria adulta tiveram o maior público presente nas últimas 5 temporadas?
SELECT
    p.campeonato,
    p.temporada,
    p.data_partida,
    p.estadio,
    c.equipe_1,
    c.placar_1,
    c.equipe_2,
    c.placar_2,
    p.publico_presente
FROM vw_publico_volei_feminino_adulto p
INNER JOIN vw_confrontos_partidas c
        ON p.id_partida = c.id_partida
ORDER BY p.publico_presente DESC, p.temporada DESC, p.data_partida
LIMIT 10;

-- f) Qual é a média de pontos por partida de cada equipe de basquete masculino em todas as categorias cadastradas na última temporada?
SELECT
    equipe,
    jogos,
    media_pontos_por_partida
FROM vw_media_basquete_masculino_2025
WHERE categoria = 'Sub-11'
ORDER BY media_pontos_por_partida DESC, equipe;

SELECT
    equipe,
    jogos,
    media_pontos_por_partida
FROM vw_media_basquete_masculino_2025
WHERE categoria = 'Sub-13'
ORDER BY media_pontos_por_partida DESC, equipe;

SELECT
    equipe,
    jogos,
    media_pontos_por_partida
FROM vw_media_basquete_masculino_2025
WHERE categoria = 'Sub-15'
ORDER BY media_pontos_por_partida DESC, equipe;

SELECT
    equipe,
    jogos,
    media_pontos_por_partida
FROM vw_media_basquete_masculino_2025
WHERE categoria = 'Sub-17'
ORDER BY media_pontos_por_partida DESC, equipe;

SELECT
    equipe,
    jogos,
    media_pontos_por_partida
FROM vw_media_basquete_masculino_2025
WHERE categoria = 'Adulta'
ORDER BY media_pontos_por_partida DESC, equipe;

-- g) Quais árbitros federados atuaram em mais jogos durante a competição de futebol de salão, tanto masculino quanto feminino, na categoria adulta,na atual temporada?
SELECT
    arbitro,
    federado,
    jogos_apitados
FROM vw_jogos_arbitros_futsal_adulto_2026
ORDER BY jogos_apitados DESC, arbitro
LIMIT 10;

-- h) Quais equipes tiveram a melhor defesa e o melhor ataque no campeonato de futebol amador da cidade na última temporada?
SELECT
    'Melhor ataque' AS criterio,
    equipe,
    gols_marcados AS valor
FROM vw_ataque_defesa_futebol_amador_2025
WHERE gols_marcados = (
    SELECT MAX(gols_marcados)
    FROM vw_ataque_defesa_futebol_amador_2025
)
UNION ALL
SELECT
    'Melhor defesa' AS criterio,
    equipe,
    gols_sofridos AS valor
FROM vw_ataque_defesa_futebol_amador_2025
WHERE gols_sofridos = (
    SELECT MIN(gols_sofridos)
    FROM vw_ataque_defesa_futebol_amador_2025
);

-- i) Quais e quantos atletas do gênero masculino mais receberam penalidades em todas as modalidades cadastradas nas últimas 5 temporadas?
SELECT
    atleta,
    total_penalidades
FROM vw_penalidades_masculinas_ultimas_5_temporadas
ORDER BY total_penalidades DESC, atleta
LIMIT 10;

-- j) Quais estádios ou arenas sediaram a maior quantidade de partidas em cada modalidade cadastrada e em cada categoria na atual temporada?
SELECT
    modalidade,
    categoria,
    estadio,
    total_partidas
FROM vw_partidas_por_estadio_modalidade_categoria_2026
ORDER BY modalidade, categoria, total_partidas DESC, estadio;
