# read from ESL-CN repo
spam = read.table("../ESL-CN/data/Spam/spam.data.txt")
flag.esl.trainset = read.table("../ESL-CN/data/Spam/spam.traintest.txt")$V1
## the 54th is char_freq_#, disable it as a comment character
name = read.table("../ESL-CN/data/Spam/spam.data.names.txt", comment.char = "")$V1
colnames(spam) = name
usethis::use_data(spam, overwrite = T)
usethis::use_data(flag.esl.trainset, overwrite = T)
