CREATE OR REPLACE VIEW `kimiafarma-bigdata.kimia_farma.v_top10_nett_sales_prov` AS
SELECT
  provinsi,
  SUM(nett_sales) AS revenue
FROM `kimiafarma-bigdata.kimia_farma.t_analisa_kf_2020_2023`
GROUP BY provinsi
ORDER BY revenue DESC
LIMIT 10;
