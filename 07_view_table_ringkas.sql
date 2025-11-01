CREATE OR REPLACE VIEW `kimiafarma-bigdata.kimia_farma.v_table_ringkas` AS
SELECT
  branch_name,
  provinsi,
  AVG(rating_cabang)     AS avg_rating_cabang,
  AVG(rating_transaksi)  AS avg_rating_transaksi,
  COUNT(DISTINCT transaction_id) AS total_transaksi
FROM `kimiafarma-bigdata.kimia_farma.t_analisa_kf_2020_2023`
GROUP BY branch_name, provinsi;
