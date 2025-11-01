CREATE OR REPLACE VIEW `kimiafarma-bigdata.kimia_farma.v_yoy_revenue` AS
WITH by_year AS (
  SELECT
    EXTRACT(YEAR FROM date) AS tahun,
    SUM(nett_sales) AS revenue
  FROM `kimiafarma-bigdata.kimia_farma.t_analisa_kf_2020_2023`
  GROUP BY 1
)
SELECT
  tahun,
  revenue,
  SAFE_DIVIDE(
    revenue - LAG(revenue) OVER (ORDER BY tahun),
    LAG(revenue)  OVER (ORDER BY tahun)
  ) AS yoy_growth
FROM by_year
ORDER BY tahun;
