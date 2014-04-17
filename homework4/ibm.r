require(tm)        # corpus
require(SnowballC) # stemming

setwd("/Users/jg/Documents/DataVis/msan622/homework4/")

ibm_source <- DirSource(
    # indicate directory
    directory = file.path("ibm"),
    encoding = "UTF-8",     # encoding
    pattern = "*.txt",      # filename pattern
    recursive = FALSE,      # visit subdirectories?
    ignore.case = FALSE)    # ignore case in pattern?

ibm_corpus <- Corpus(
    ibm_source, 
    readerControl = list(
        reader = readPlain, # read as plain text
        language = "en"))   # language is english

# Inspect Corpus #####
# print(ibm_corpus)
# summary(ibm_corpus)
# inspect(ibm_corpus)
# ibm_corpus[["ibm.txt"]]

# Transform Corpus #####
# getTransformations()
# sotu_corpus[[1]][3]

ibm_corpus <- tm_map(ibm_corpus, tolower)

ibm_corpus <- tm_map(
    ibm_corpus, 
    removePunctuation,
    preserve_intra_word_dashes = TRUE)

ibm_corpus <- tm_map(
    ibm_corpus,
    removeWords, 
    stopwords("english"))

# getStemLanguages()
ibm_corpus <- tm_map(
    ibm_corpus,
    stemDocument,
    lang = "porter") # try porter or english

ibm_corpus <- tm_map(
    ibm_corpus, 
    stripWhitespace)

# Remove specific words
ibm_corpus <- tm_map(
    ibm_corpus, 
    removeWords, 
    c("will", "can", "get", "that", "year", "let"))

# print(ibm_corpus[["ibm.adam.txt"]][3])

# Calculate Frequencies
ibm_tdm <- TermDocumentMatrix(ibm_corpus)

# Inspect Frequencies
# print(ibm_tdm)
# inspect(ibm_tdm[40:44,])
# findFreqTerms(ibm_tdm, 20)
# inspect(ibm_tdm[findFreqTerms(ibm_tdm, 20),])

# Convert to term/frequency format
ibm_matrix <- as.matrix(ibm_tdm)
ibm_df <- data.frame(
    word = rownames(ibm_matrix), 
    # necessary to call rowSums if have more than 1 document
    freq = rowSums(ibm_matrix),
    stringsAsFactors = FALSE) 

# Sort by frequency
ibm_df <- ibm_df[with(
    ibm_df, 
    order(freq, decreasing = TRUE)), ]

# Do not need the row names anymore
rownames(ibm_df) <- NULL

# Check out final data frame
# View(ibm_df)