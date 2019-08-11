# Adult Decompensation (In progress!)

> This project aims to initialize machine learning models for predicting adult inpatients' decompensation (ICU admission, mortality, RRT events, etc). The ultimate goal is to reduce patients' deterioration and standardize response protocols.

## Table of contents

* [Architecture](#architecture)
* [Getting Started](#getting-started)
* [Data](#data)
* [Model Training](#model-training)
* [Visualizations](#visualizations)
* [Status](#status)
* [Liscence](#liscence)
* [Contact](#contact)
* [Acknowledgement](#acknowledgement)

## Architecture

<pre><code>
.
│&ndash;&ndash;&ndash;Code
|   |───DataPrep
|   |   |───cohort
|   |   |
|   |   |───features
|   |   |
|   |   |───outcome
|   |   |
|   |   |───adt_transfer.py
|   |   |
|   |   &boxur;&ndash;&ndash;&ndash;adt_transfer.sql
|   |
|   |───db    //codes for creating project database file(s) and importing data to database(s)
|   |
|   |───Model
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

## Getting Started

## Data

## Model Training

## Visualizations

## Status

## Liscence

## Contact

## Acknowledgement