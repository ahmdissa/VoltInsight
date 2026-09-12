# VoltInsight

An end-to-end energy & utility analytics project — from raw data to dashboards. Covers grid load, energy usage, billing/tariffs, weather, and device metrics, analyzed with SQL and Python, and visualized in Power BI, Tableau, and Excel.

## About This Project

VoltInsight walks through the full analytics workflow for a utility company's energy data, starting from raw, unprocessed records and ending in three separate interactive dashboards.

**Data preparation**: Raw data across five domains — grid load, energy usage, billing, weather, and device metrics — was cleaned and transformed into analysis-ready tables, stored separately as `Raw_Data` and `Cleaned_Data`.

**Analysis**: SQL queries were used to answer core business questions, such as revenue breakdowns by region and tariff plan. Python notebooks were built for deeper exploration of grid load patterns, weather correlations, and tariff metrics.

**Data modeling**: The cleaned datasets were connected in a galaxy schema (see `Images/Galaxy Schema.png`) to support cross-domain analysis — linking usage, billing, weather, and device data together for reporting.

**Dashboards**: The same underlying dataset was visualized three different ways to compare tooling and reach different audiences:
- **Power BI** — an interactive report with filters and drill-downs for internal analysis.
- **Tableau** — a parallel dashboard build showcasing the same key metrics with Tableau's visualization style.
- **Excel** — a lightweight, shareable dashboard for stakeholders without BI tool access.

Together, these pieces form a complete case study: from messy raw data to clean data models to decision-ready dashboards.

## Project Structure

```
VoltInsight/
├── Data/
│   ├── Raw_Data/         # Unprocessed source data (grid load, billing, weather, energy usage, device metrics)
│   └── Cleaned_Data/     # Cleaned/transformed datasets ready for analysis
├── SQL/                  # SQL analysis queries (VoltInsight SQL Analysis.sql)
├── Python/                # Jupyter notebooks
│   ├── grid_load.ipynb
│   ├── weather.ipynb
│   └── tariff_metrics.ipynb
├── PowerBI/               # Power BI dashboard (.pbix)
├── Tableau/                # Tableau workbook (.twbx)
├── Excel/                  # Excel dashboard (.xlsx)
└── Images/                 # Dashboard screenshots (Power BI, Tableau, Excel, schema diagram)
```

## Data

Raw data is cleaned and transformed into the `Cleaned_Data` folder, covering:
- **Grid load** — demand/load readings
- **Energy usage** — consumption data
- **Billing** — tariff plans, subsidies, monthly bills, regions
- **Weather** — conditions relevant to load/usage patterns
- **Device metrics** — connected device-level data

## Analysis

- **SQL** (`SQL/VoltInsight SQL Analysis.sql`) — revenue by region/tariff plan, and other business questions.
- **Python** (`Python/`) — notebooks for grid load, weather, and tariff metrics analysis.

## Dashboards

Interactive dashboards built in three tools:
- **Power BI** — `PowerBI/VoltInsight PowerBI.pbix`
- **Tableau** — `Tableau/VoltInsight Tableau.twbx`
- **Excel** — `Excel/VoltInsight Excel (Dashboard).xlsx`

### Power BI

![Power BI Dashboard 1](Images/PowerBI%20Images/IMG_PBI1.png)
![Power BI Dashboard 2](Images/PowerBI%20Images/IMG_PBI2.png)
![Power BI Dashboard 3](Images/PowerBI%20Images/IMG_PBI3.png)

### Tableau

![Tableau Dashboard 1](Images/Tableau%20Images/IMG_TABLEAU1.png)
![Tableau Dashboard 2](Images/Tableau%20Images/IMG_TABLEAU2.png)

### Excel

![Excel Dashboard 1](Images/Excel%20Images/IMG_EXCEL1.png)
![Excel Dashboard 2](Images/Excel%20Images/IMG_EXCEL2.png)
![Excel Dashboard 3](Images/Excel%20Images/IMG_EXCEL3.png)

## Schema

The datasets are connected in a galaxy schema to support cross-domain analysis:

![Galaxy Schema](Images/Galaxy%20Schema.png)

## Large Files

This repo uses [Git LFS](https://git-lfs.github.com/) for large binary files (`.pbix`, `.twbx`, `.xlsx`, and large `.csv` files). Run `git lfs install` before cloning/pulling to fetch them properly.
