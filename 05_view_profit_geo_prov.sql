CREATE OR REPLACE VIEW `kimiafarma-bigdata.kimia_farma.v_profit_geo_prov` AS
SELECT
  provinsi,
  SUM(nett_profit) AS total_nett_profit
FROM `kimiafarma-bigdata.kimia_farma.t_analisa_kf_2020_2023`
GROUP BY provinsi;
