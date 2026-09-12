# VoltInsight

An end-to-end energy & utility analytics project — from raw data to dashboards. Covers grid load, energy usage, billing/tariffs, weather, and device metrics, analyzed with SQL and Python, and visualized in Power BI, Tableau, and Excel.

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

Interactive dashboards built in three tools, with screenshots in `Images/`:
- **Power BI** — `PowerBI/VoltInsight PowerBI.pbix`
- **Tableau** — `Tableau/VoltInsight Tableau.twbx`
- **Excel** — `Excel/VoltInsight Excel (Dashboard).xlsx`

## Schema

See `Images/Galaxy Schema.png` for the data model.

## Large Files

This repo uses [Git LFS](https://git-lfs.github.com/) for large binary files (`.pbix`, `.twbx`, `.xlsx`, and large `.csv` files). Run `git lfs install` before cloning/pulling to fetch them properly.
