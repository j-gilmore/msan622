# Dante- The Divine Comedy
# Gutenburg Project
# dantehttp://www.gutenberg.org/cache/epub/1004/pg1004.txt

require(tm)        # corpus
require(SnowballC) # stemming


dante_source <- DirSource(
    # indicate directory
    directory = file.path("dante"),
    encoding = "UTF-8",     # encoding
    pattern = "*.txt",      # filename pattern
    recursive = FALSE,      # visit subdirectories?
    ignore.case = FALSE)    # ignore case in pattern?

dante_corpus <- Corpus(
    dante_source, 
    readerControl = list(
        reader = readPlain, # read as plain text
        language = "en"))   # language is english

# Inspect Corpus #####
# print(dantedante_corpus)
# summary(dante_corpus)
# inspect(dante_corpus)
# dante_corpus[["dante.txt"]]

# Transform Corpus #####
# getTransformations()
# sotu_corpus[[1]][3]

dante_corpus <- tm_map(dante_corpus, tolower)

dante_corpus <- tm_map(
    dante_corpus, 
    removePunctuation,
    preserve_intra_word_dashes = TRUE)

dante_corpus <- tm_map(
    dante_corpus,
    removeWords, 
    stopwords("english"))

dante_corpus <- tm_map(
    dante_corpus,
    removeWords, 
    c("thou", "thee", "upon", "now", "said", "come", "unto", "made", "make", "thy", "turn"))

# getStemLanguages()
dante_corpus <- tm_map(
    dante_corpus,
    stemDocument,
    lang = "porter") # try porter or english

dante_corpus <- tm_map(
    dante_corpus, 
    stripWhitespace)

# Remove specific words
dante_corpus <- tm_map(
    dante_corpus, 
    removeWords, 
    c("will", "can", "get", "that", "year", "let"))

# print(dante_corpus[["dante.adam.txt"]][3])

# Calculate Frequencies
dante_tdm <- TermDocumentMatrix(dante_corpus)

# Inspect Frequencies
# print(dante_tdm)
# inspect(dante_tdm[40:44,])
# findFreqTerms(dante_tdm, 20)
# inspect(dante_tdm[findFreqTerms(dante_tdm, 20),])

# Convert to term/frequency format
dante_matrix <- as.matrix(dante_tdm)
dante_df <- data.frame(
    word = rownames(dante_matrix), 
    # necessary to call rowSums if have more than 1 document
    freq = rowSums(dante_matrix),
    stringsAsFactors = FALSE) 

# Sort by frequency
dante_df <- dante_df[with(
    dante_df, 
    order(freq, decreasing = TRUE)), ]

# Do not need the row names anymore
rownames(dante_df) <- NULL

# Check out final data frame
# View(dante_df)