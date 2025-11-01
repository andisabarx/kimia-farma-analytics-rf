CREATE OR REPLACE VIEW `kimiafarma-bigdata.kimia_farma.v_top5_branch_hi_low` AS
WITH agg AS (
  SELECT
    branch_id,
    branch_name,
    provinsi,
    AVG(rating_cabang)    AS avg_rating_cabang,
    AVG(rating_transaksi) AS avg_rating_transaksi
  FROM `kimiafarma-bigdata.kimia_farma.t_analisa_kf_2020_2023`
  GROUP BY 1,2,3
),
rnk AS (
  SELECT
    *,
    RANK() OVER (ORDER BY avg_rating_cabang DESC)  AS rnk_cabang_desc,
    RANK() OVER (ORDER BY avg_rating_transaksi ASC) AS rnk_trans_asc
  FROM agg
)
SELECT
  branch_id, branch_name, provinsi,
  avg_rating_cabang, avg_rating_transaksi,
  (rnk_cabang_desc + rnk_trans_asc) AS skor_gabungan
FROM rnk
ORDER BY skor_gabungan ASC, avg_rating_cabang DESC, avg_rating_transaksi ASC
LIMIT 5;
