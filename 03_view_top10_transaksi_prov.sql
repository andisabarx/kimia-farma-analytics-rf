CREATE OR REPLACE VIEW `kimiafarma-bigdata.kimia_farma.v_top10_transaksi_prov` AS
SELECT
  provinsi,
  COUNT(DISTINCT transaction_id) AS total_transaksi
FROM `kimiafarma-bigdata.kimia_farma.t_analisa_kf_2020_2023`
GROUP BY provinsi
ORDER BY total_transaksi DESC
LIMIT 10;
