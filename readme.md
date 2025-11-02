# Kimia Farma Analytics (2020–2023)

**Tujuan**  
Evaluasi kinerja bisnis Kimia Farma 2020–2023 berbasis BigQuery + Looker Studio.

**Arsitektur Data**  
4 tabel sumber → `t_analisa_kf_2020_2023` → views untuk visual:
- `v_yoy_revenue`
- `v_top10_transaksi_prov`
- `v_top10_nett_sales_prov`
- `v_profit_geo_prov`
- `v_top5_branch_hi_low`
- `v_table_ringkas`

**Cara Replikasi**
1. Buat project GCP & dataset: `kimia_farma`.
2. Import CSV: `kf_final_transaction`, `kf_inventory`, `kf_kantor_cabang`, `kf_product`.
3. Ganti semua `project_id` dengan project kamu.
4. Jalankan `01_create_table_analisa.sql`, lalu jalankan view `02…07`.

**Dashboard**  
Link Looker Studio:[ _URL _ ](https://lookerstudio.google.com/reporting/0e37970a-d717-443d-9e29-ba5376bba8d5) 
(Filter: Rentang Tanggal, Tahun, Provinsi, Branch Name. KPI: Total Revenue, Total Profit, #Transaksi, Avg Rating.)

**Insight Singkat**
- Revenue tertinggi tahun **X**; YoY **±Y%**.
- Provinsi kontributor revenue terbesar: **A, B, C**.
- **Top 5 branch** punya **rating cabang tinggi** tapi **rating transaksi rendah** → peluang perbaikan proses transaksi.
- **Profit** terpusat di provinsi **Z** (lihat peta).


