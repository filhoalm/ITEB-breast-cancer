# ITEB Breast Cancer Research Working Group - SEER Data Analysis

## Data Source
National Cancer Institute. Surveillance, Epidemiology, and End Results (SEER) Program Populations (1975-2020). Available at: [www.seer.cancer.gov/popdata](https://www.seer.cancer.gov/popdata). Released May 2023. National Cancer Institute, DCCPS, Surveillance Research Program, February 2022S ed.

## Morphology

### Ductal Carcinoma In Situ (DCIS)
Morphology codes for DCIS:
- '8201/2: Cribriform carcinoma in situ'
- '8500/2: Intraductal carcinoma, noninfiltrating, NOS'
- '8501/2: Comedocarcinoma, noninfiltrating'
- '8503/2: Noninfiltrating intraductal papillary adenocarcinoma'
- '8507/2: Intraductal micropapillary carcinoma'
- '8523/2: Intraductal with other types of carcinoma in situ'

ER Status Recode for Breast Cancer (1990+): 'Positive', 'Negative', 'Borderline/Unknown', 'Recode not available'

### Infiltrating Ductal Carcinoma (IDC)
Morphology codes for IDC:
- '8500/3: Infiltrating duct carcinoma, NOS'
- '8523/3: Infiltrating duct mixed with other types of carcinoma'

ER Status Recode for Breast Cancer (1990+): 'Positive', 'Negative', 'Borderline/Unknown', 'Recode not available'

## Dataset Availability

### Incidence Data

#### SEER8 Research Plus
- IDC and DCIS by age, year, ER status, from 1979 to 2020:
  - DCIS: [dcis.csv](https://raw.githubusercontent.com/filhoalm/Breast_cancer/main/dataCheck/dcis.csv)
  - IDC: [idc.csv](https://raw.githubusercontent.com/filhoalm/Breast_cancer/main/dataCheck/idc.csv)

#### SEER13 Research Plus
- Malignant breast cancer by race and ethnicity, year, age, ER status, HER status from 1992 to 2018: [breast_er_her_11072023.csv](https://github.com/filhoalm/Breast_cancer/blob/main/forecasting/data/breast_er_her_11072023.csv)
- Malignant breast cancer by year, age, ER status, HER status, PR status from 1992 to 2018: [breast_er_her_pr_1182023.csv](https://github.com/filhoalm/Breast_cancer/blob/main/forecasting/data/breast_er_her_pr_1182023.csv)

### SEER Updates - 2022

Starting with the 1975-2019 SEER Research Data (November 2021 submission), Detroit is no longer included in any databases. Illinois and Texas are included in the new 22-registry database. For more information, visit [SEER Registries](https://seer.cancer.gov/registries/terms.html).

#### SEER12 Data
- Malignant breast cancer (ER and HER2) by race and ethnicity, age, and year: [seer12_1102024.csv](https://raw.githubusercontent.com/filhoalm/Breast_cancer/main/forecasting/data/seer12_1102024.csv)
- Malignant breast cancer (ER, HER2, and PR status) by age and year: [seer12_1102024.csv](https://raw.githubusercontent.com/filhoalm/Breast_cancer/main/forecasting/data/seer12_1102024.csv)

### Survival Data

Survival files are available in a .zip file: [Survival.zip](https://github.com/filhoalm/Breast_cancer/blob/main/Survival.zip)

#### Case Listing
- Malignant breast cancer in females by age, race and ethnicity, ER status, PR status, HER2 status, from 1992 to 2020.
  - 1-year censored follow-up: [case_listing_1y.csv](https://github.com/filhoalm/Breast_cancer/blob/main/Survival.zip)
  - 5-year censored follow-up: [case_listing_5y.csv](https://github.com/filhoalm/Breast_cancer/blob/main/Survival.zip)

#### Net Survival - Pohar-Perme Method
- 5-year censored follow-up: [net_survival_5y_er_pr_her_seer12.csv](https://github.com/filhoalm/Breast_cancer/blob/main/Survival.zip)

## Simple imputation
https://filhoalm.github.io/Breast_cancer/Incidence/imputation/imputation.html

# Results

## DCIS vs IDC (Ismail comment)
https://filhoalm.github.io/Breast_cancer/SEER8/gitfiles/breast_idc_dcis.html

## Incidence analysis SEER22
View the Quarto version of the analysis [here](https://filhoalm.github.io/Breast_cancer/Incidence/seer22/Incidence_seer22.html).

## Relative Survival analysis
View the Quarto version of the analysis [here](https://filhoalm.github.io/Breast_cancer/Survival_snapshot/survival.html).
SEER12: https://filhoalm.github.io/Breast_cancer/Survival_snapshot/seer12_survival.html

## WerR Live Version
Access the interactive WerR live version [here](https://filhoalm.github.io/Breast_cancer/test.html).

