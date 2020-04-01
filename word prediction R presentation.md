word prediction R presentation
========================================================
author: YU SUE
date: 21 MARCH 2020
autosize: true

Introduction
========================================================

This presentation is created as part of the requirement for the Coursera Data Science Capstone Course.

-The objective of the App is implementing a predictive model that offers hints to one or more words, coherent to the sentence that???s been input by its user.The Capstone dataset used includes twitter, news and blogs from HC Corpora. After performing data cleansing, sampling and sub-setting, we gather all data in R data frames.
- Applying some Text Mining ??? and NLP techniques, is created some set of word combinations (N-grams). These are the main support to Katz Backoff algorithm predicts the next word. Some adaptations and heuristics were specially developed to enhance this Shiny application.


Getting & Cleaning the Data
========================================================

Compressed data sets containing descending frequency sorted n-grams are first loaded.
User input words are cleaned using Quanteda package. Then unigram, bigram, and trigram are generated.
For prediction of the next word, bigram is used (first three words of Quadgram are the last three words of the user provided sentence).


Word Prediction Model
========================================================

After the data is cleaned, bigram is generated. Word prediction is based on most frequent bigrams appearing in the bigram data frame. 
- If single word is input, look up the bigram to predict the next word
- If multipe words are input, look up the bigram to predict the next word for the last input word.

Shiny Application
======================================================
[Shiny App] - [https://yusuezju.shinyapps.io/word_pred_app/]
