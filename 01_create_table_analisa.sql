CREATE OR REPLACE TABLE `kimiafarma-bigdata.kimia_farma.t_analisa_kf_2020_2023` AS
WITH src AS (
  SELECT
    t.transaction_id,
    t.date,
    t.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,
    t.customer_name,
    t.product_id,
    p.product_name,

    -- pastikan harga numerik (kalau di sumber bertipe STRING)
    SAFE_CAST(t.price AS NUMERIC) AS actual_price_raw,

    -- normalisasi diskon: kalau >1 anggap persen (0–100), ubah ke 0–1
    CASE
      WHEN COALESCE(t.discount_percentage,0) > 1
        THEN COALESCE(t.discount_percentage,0) / 100
      ELSE COALESCE(t.discount_percentage,0)
    END AS discount_norm,

    -- rating transaksi
    t.rating AS rating_transaksi
  FROM `kimiafarma-bigdata.kimia_farma.kf_final_transaction` t
  LEFT JOIN `kimiafarma-bigdata.kimia_farma.kf_kantor_cabang` kc
    ON t.branch_id = kc.branch_id
  LEFT JOIN `kimiafarma-bigdata.kimia_farma.kf_product` p
    ON t.product_id = p.product_id
),
base AS (
  SELECT
    transaction_id,
    date,
    branch_id,
    branch_name,
    kota,
    provinsi,
    rating_cabang,
    customer_name,
    product_id,
    product_name,

    -- harga jual aktual (aman)
    actual_price_raw AS actual_price,

    -- persentase gross laba berdasarkan actual_price
    CASE
      WHEN actual_price_raw <=  50000 THEN 0.10
      WHEN actual_price_raw <= 100000 THEN 0.15
      WHEN actual_price_raw <= 300000 THEN 0.20
      WHEN actual_price_raw <= 500000 THEN 0.25
      ELSE 0.30
    END AS persentase_gross_laba,

    -- nett_sales: harga setelah diskon
    actual_price_raw * (1 - discount_norm) AS nett_sales,

    -- nett_profit: nett_sales * persentase gross laba
    (actual_price_raw * (1 - discount_norm)) *
      CASE
        WHEN actual_price_raw <=  50000 THEN 0.10
        WHEN actual_price_raw <= 100000 THEN 0.15
        WHEN actual_price_raw <= 300000 THEN 0.20
        WHEN actual_price_raw <= 500000 THEN 0.25
        ELSE 0.30
      END AS nett_profit,

    rating_transaksi
  FROM src
)
SELECT *
FROM base
WHERE EXTRACT(YEAR FROM date) BETWEEN 2020 AND 2023;
