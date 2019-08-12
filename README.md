# Adult Decompensation (In progress!)

> This project aims to initialize machine learning models for predicting adult inpatients' decompensation (ICU admission, mortality, RRT events, etc). The ultimate goal is to reduce patients' deterioration and standardize response protocols.

## Table of contents

* [Architecture](#architecture)
* [Getting Started](#getting-started)
* [Data](#data)
* [Model Training](#model-training)
* [Visualizations](#visualizations)
* [Status](#status)
* [License](#license)
* [Contact](#contact)
* [Acknowledgement](#acknowledgement)

## Architecture

<details><summary>Code</summary><blockquote>
<details><summary>DataPrep</summary>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cohort&nbsp;&nbsp;&nbsp;&nbsp;//codes for cohort generation<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;features<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;outcome<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;adt_transfer.py<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;adt_transfer.sql
</details>
&nbsp;&nbsp;&nbsp;&nbsp;db
<details><summary>Model</summary>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;design_matrix<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;News&nbsp;&nbsp;&nbsp;&nbsp;//python package for implementing News(National Early Warning Score)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;visualization&nbsp;&nbsp;&nbsp;&nbsp;//model visualization<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;model_utils.py&nbsp;&nbsp;&nbsp;&nbsp;//model utils python package<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;run_ann.ipynb<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;run_logistic_regression.py<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;run_news.py<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;run_random_forest.ipynb<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;run_xgboost.py
</details>
&nbsp;&nbsp;&nbsp;&nbsp;utils&nbsp;&nbsp;&nbsp;&nbsp;//utils python package (db utils, dataframe utils, etc)
</blockquote></details>

<details><summary>Data</summary><blockquote>
&nbsp;&nbsp;&nbsp;&nbsp;db&nbsp;&nbsp;&nbsp;&nbsp;//project database file(s)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;metadata
<details><summary>Modeling</summary>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;design_matrix&nbsp;&nbsp;&nbsp;&nbsp;//design matrix file(s)<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Output&nbsp;&nbsp;&nbsp;&nbsp;//model output data
</details>
<details><summary>Processed</summary>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cohort<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;features<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;outcome<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;adult_decomp_adt_transfer.csv
</details>
</blockquote></details>

<details><summary>Docs</summary><blockquote>
<details><summary>Project</summary>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;code_map_v1.xlsx&nbsp;&nbsp;&nbsp;&nbsp;
//outlines the code and associated data files for "start-to-finish" process of data curation<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;literature_review.pdf<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Perspectives Piece.docx
</details>
&nbsp;&nbsp;&nbsp;&nbsp;Slides&nbsp;&nbsp;&nbsp;&nbsp;//presentation slides for project milestones
</blockquote></details>

<details><summary>Output&nbsp;&nbsp;&nbsp;&nbsp;//project output files, figures, etc</summary><blockquote>
&nbsp;&nbsp;&nbsp;&nbsp;Figures&nbsp;&nbsp;&nbsp;&nbsp;//data visualization figures<br/>
&nbsp;&nbsp;&nbsp;&nbsp;*.csv
</blockquote></details>
.gitignore<br/>
README.md

<!--
<pre><code>
.
│───Code
|   |───DataPrep
|   |   |───cohort    //codes for cohort generation
|   |   |
|   |   |───features
|   |   |
|   |   |───outcome
|   |   |
|   |   |───adt_transfer.py
|   |   |
|   |   └───adt_transfer.sql
|   |
|   |───db    //codes for creating project database file(s) and importing data to database(s)
|   |
|   |───Model
|   |   |───design_matrix
|   |   |
|   |   |───News    //python package for implementing News(National Early Warning Score)
|   |   |
|   |   |───visualization    //model visualization
|   |   |
|   |   |───model_utils.py    //model utils python package
|   |   |
|   |   |───run_ann.ipynb
|   |   |
|   |   |───run_logistic_regression.py
|   |   |
|   |   |───run_news.py
|   |   |
|   |   |───run_random_forest.ipynb
|   |   |
|   |   └───run_xgboost.py
|   |
|   └───utils    //utils python package (db utils, dataframe utils, etc)
|
|───Data
|   |───db    //project database file(s)
|   |
|   |───metadata
|   |
|   |───Modeling
|   |   |───design_matrix   //design matrix file(s)
|   |   |
|   |   └───Output    //model output data
|   |
|   └───Processed
|       |───cohort
|       |
|       |───features
|       |
|       |───outcome
|       |
|       └───adult_decomp_adt_transfer.csv
|
|───Docs
|   |───Project
|   |   |───code_map_v1.xlsx    //outlines the code and associated data files for "start-to-finish" process of data curation
|   |   |
|   |   |───literature_review.pdf
|   |   |
|   |   └───Perspectives Piece.docx
|   |
|   └───Slides    //presentation slides for project milestones
|
|───Output    //project output files, figures, etc
|   |───Figures    //data visualization figures
|   |
|   └───*.csv
|   
|───.gitignore
|
└───README.md
</code></pre>
-->

## Getting Started

Instructions on setting up the project locally.

### Prerequisites

<details><summary>List of dependencies required for the project:</summary>
<ul>
<li>Python 3.7.3</li>
<li>SQLite3 2.6.0</li>
<li>Git 2.14.1</li>
<li>GNU Awk 4.1.4</li>
</ul>
</details>

<details><summary>Additional python packages required:</summary>
<ul>
<li>numpy 1.16.2</li>
<li>pandas 0.24.2</li>
<li>TensorFlow 1.14.0</li>
<li>Keras 2.2.4</li>
<li>scikit-learn 0.21.2</li>
<li>xgboost 0.90</li>
<li>imbalanced-learn 0.5.0</li>
<li>matplotlib 3.1.0</li>
<li>seaborn 0.9.0</li>
</ul>
</details>

### Setup

1. Get access to Duke EHR (Electrical Health Record) data from DIHI project folder (dihi_qi) via PACE machine [https://pace.ori.duke.edu/](https://pace.ori.duke.edu/)
2. Clone the repo
```
git clone http://pacegitlab.dhe.duke.edu/dihi/2019_rfa/adult_decompensation.git
```
3. Follow the code map under ./Docs/Project to run the project from start to end

## Data

## Model Training

## Visualizations

## Status

Project is: in progress; continuation is pending;

To-do list:
* Update LU_hospital_units table in P:/dihi_qi/data_pipeline/db/data_pipeline.db
* 100% unit conversion for vital, analyte, medication data etc is pending

## License

## Contact

Ziyuan Shen - ziyuan.shen@duke.edu

Mengxuan Cui - mengxuan.cui@duke.edu

## Acknowledgement

This work is funded by [Woo Center for Big Data and Precision Health](http://healthdata.pratt.duke.edu/), in collaboration with [DIHI](https://dihi.org/) (Duke Institute for Health Innovation). The authors thank Professor [Xiling Shen](http://healthdata.pratt.duke.edu/people/xiling-shen) for consistently supporting the project and DIHI team (Will Ratliff and Mark Sendak for hospital data resource and modeling support, Michael Gao and Marshall Nichols for technical support) for guidance and assistance with project specifics.

