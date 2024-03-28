# **ITEB Breast Cancer Research Working Group - SEER Data Analysis**

## **Data Source**
This analysis is based on data sourced from the National Cancer Institute. This data is part of the Surveillance, Epidemiology, and End Results (SEER) Program Populations from 1975-2020. The data was officially released in May 2023 and it was drawn from the National Cancer Institute, DCCPS, Surveillance Research Program's February 2022S edition. For further details, please click [here](https://www.seer.cancer.gov/popdata).

## **Morphology**

### **Ductal Carcinoma In Situ (DCIS)**
The Morphology codes for DCIS include:
- 8201/2: Cribriform carcinoma in situ
- 8500/2: Intraductal carcinoma, noninfiltrating, NOS
- 8501/2: Comedocarcinoma, noninfiltrating
- 8503/2: Noninfiltrating intraductal papillary adenocarcinoma
- 8507/2: Intraductal micropapillary carcinoma
- 8523/2: Intraductal with other types of carcinoma in situ

ER Status Recode for Breast Cancer (1990+): 'Positive', 'Negative', 'Borderline/Unknown', 'Recode not available'

### **Infiltrating Ductal Carcinoma (IDC)**
The Morphology codes for IDC include:
- 8500/3: Infiltrating duct carcinoma, NOS
- 8523/3: Infiltrating duct mixed with other types of carcinoma

ER Status Recode for Breast Cancer (1990+): 'Positive', 'Negative', 'Borderline/Unknown', 'Recode not available'

## **Dataset Availability**

### **Incidence Data**

#### *SEER8 Research Plus*
IDC and DCIS data segregated by age, year, and ER status, (spanning from 1979 to 2020), is available for:
- [DCIS](https://raw.githubusercontent.com/filhoalm/Breast_cancer/main/dataCheck/dcis.csv)
- [IDC](https://raw.githubusercontent.com/filhoalm/Breast_cancer/main/dataCheck/idc.csv)

#### *SEER13 Research Plus*
Data on malignant breast cancer classified by race and ethnicity, year, age, ER status, and HER status (from 1992 to 2018) is available [here](https://github.com/filhoalm/Breast_cancer/blob/main/forecasting/data/breast_er_her_11072023.csv).

Malignant breast cancer data segmented by year, age, ER status, HER status, and PR

# **Results**

## **Ismail's Comment on DCIS vs IDC**
For detailed results and discussion on DCIS vs IDC as per Ismail's comment, refer to this [github page](https://filhoalm.github.io/Breast_cancer/SEER8/gitfiles/breast_idc_dcis.html).

## **Incidence Analysis of SEER22**
The comprehensive analysis of SEER22 incidence data is available in [Quarto version](https://filhoalm.github.io/Breast_cancer/Incidence/seer22/Incidence_seer22.html).

## **Simple Imputation**
You can find the conducted [Simple imputation here](https://filhoalm.github.io/Breast_cancer/Incidence/imputation/imputation.html)

## **Survival Analysis: Kaplan-Meier, Cox Model, and Hazard Function
- [Overview](https://filhoalm.github.io/Breast_cancer/Survival_snapshot/breast_seer12.html)

## **Relative Survival Analysis**
Links to detailed Relative Survival Analyses:
- [Overview](https://filhoalm.github.io/Breast_cancer/Survival_snapshot/survival.html)
- [SEER12 Specific](https://filhoalm.github.io/Breast_cancer/Survival_snapshot/seer12_survival.html)

## **Live Interactive WerR Version**
Experience the interactive WerR version with live data [here](https://filhoalm.github.io/Breast_cancer/test.html).
