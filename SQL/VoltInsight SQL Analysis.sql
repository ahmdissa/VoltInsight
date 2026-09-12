CREATE DATABASE VoltInsight;
USE VoltInsight;

-- ============================================================
-- 1. Which region/plan generates the most net revenue?
-- ============================================================
SELECT
tariff_region,
tariff_plan_type,
COUNT(*) AS bill_count,
ROUND(SUM(monthly_bill), 2) AS total_bill,
ROUND(SUM(subsidy_amount), 2) AS total_subsidy,
ROUND(SUM(monthly_bill - subsidy_amount), 2) AS net_revenue,
ROUND(AVG(monthly_bill), 2) AS avg_bill
FROM Billing
GROUP BY tariff_region, tariff_plan_type
ORDER BY net_revenue DESC;

-- ============================================================
-- 2. Feeder lines combining high load variation with low reserve margin
--    (the two conditions together indicate high outage risk)
-- ============================================================
WITH FeederRisk AS (
SELECT
feeder_line,
distribution_zone,
ROUND(AVG(load_variation), 2) AS avg_load_variation,
ROUND(AVG(reserve_margin), 2) AS avg_reserve_margin
FROM GridData
GROUP BY feeder_line, distribution_zone
),
FeederRanked AS (
SELECT *,
RANK() OVER (ORDER BY avg_load_variation DESC) AS variation_rank,
RANK() OVER (ORDER BY avg_reserve_margin ASC) AS low_margin_rank
FROM FeederRisk
)
SELECT *,
(variation_rank + low_margin_rank) AS combined_risk_score
FROM FeederRanked
ORDER BY combined_risk_score;

-- ============================================================
-- 3. How many households fall into each consumption category?
-- ============================================================
SELECT bill_flag, COUNT(*) AS household_count
FROM (
SELECT household_id,
CASE
WHEN monthly_bill > 2 * AVG(monthly_bill) OVER (PARTITION BY tariff_region) THEN 'High Outlier'
WHEN monthly_bill < 0.3 * AVG(monthly_bill) OVER (PARTITION BY tariff_region) THEN 'Low Outlier'
ELSE 'Normal'
END AS bill_flag
FROM Billing
) AS flagged
GROUP BY bill_flag
ORDER BY household_count DESC;

-- ============================================================
-- 4. Which device category/brand combos most often rank as
--    a household's single best-performing device?
-- ============================================================
SELECT
dm.device_category,
dm.device_brand,
COUNT(*) AS times_ranked_best,
ROUND(AVG(dm.efficiency_ratio), 3) AS avg_efficiency
FROM DeviceMetrics AS dm
INNER JOIN (
SELECT household_id, MAX(efficiency_ratio) AS max_eff
FROM DeviceMetrics
GROUP BY household_id
) AS best ON best.household_id = dm.household_id
AND best.max_eff = dm.efficiency_ratio
GROUP BY dm.device_category, dm.device_brand
ORDER BY times_ranked_best DESC;

-- ============================================================
-- 5. Which device category/brand combos most often rank as
--    a household's single worst-performing device?
-- ============================================================
SELECT
dm.device_category,
dm.device_brand,
COUNT(*) AS times_ranked_worst,
ROUND(AVG(dm.efficiency_ratio), 3) AS avg_efficiency
FROM DeviceMetrics AS dm
INNER JOIN (
SELECT household_id, MIN(efficiency_ratio) AS min_eff
FROM DeviceMetrics
GROUP BY household_id
) AS worst ON worst.household_id = dm.household_id
AND worst.min_eff = dm.efficiency_ratio
GROUP BY dm.device_category, dm.device_brand
ORDER BY times_ranked_worst DESC;

-- ============================================================
-- 6. Provider comparison — rate and late-fee ranking
-- ============================================================
WITH ProviderStats AS (
SELECT
utility_provider,
ROUND(AVG(unit_rate), 2) AS avg_unit_rate,
ROUND(AVG(late_fee), 2) AS avg_late_fee,
ROUND(SUM(monthly_bill), 2) AS total_bill
FROM Billing
GROUP BY utility_provider
)
SELECT *,
RANK() OVER (ORDER BY avg_unit_rate DESC) AS rate_rank,
RANK() OVER (ORDER BY avg_late_fee DESC) AS late_fee_rank
FROM ProviderStats
ORDER BY avg_unit_rate DESC;

-- ============================================================
-- 7. Grid operator comparison — loss and margin ranking
-- ============================================================
WITH OperatorStats AS (
SELECT
grid_operator,
ROUND(AVG(line_loss_percent), 2) AS avg_line_loss,
ROUND(AVG(reserve_margin), 2) AS avg_reserve_margin,
ROUND(AVG(transformer_load), 2) AS avg_transformer_load
FROM GridData
GROUP BY grid_operator
)
SELECT *,
RANK() OVER (ORDER BY avg_line_loss DESC) AS loss_rank,
RANK() OVER (ORDER BY avg_reserve_margin ASC) AS margin_rank
FROM OperatorStats
ORDER BY avg_line_loss DESC;