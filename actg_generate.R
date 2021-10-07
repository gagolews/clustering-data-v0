library(stringi)
set.seed(123)

levenshtein_jitter <- compiler::cmpfun(function(x, s, probEdit=NULL) {
   # x - string
   # s - number of edits

   y <- x
   for (i in 1:s) {
      t <- sample(1:3, 1, prob=probEdit)
      if (t == 1) {
         # deletion
         j <- sample(1:nchar(y), 1)
         stri_sub(y, j, length=1) <- ""
      }
      else if (t == 2) {
         # insertion
         j <- sample(0:nchar(y), 1)
         stri_sub(y, j, length=1) <- stri_paste(stri_sub(y, j, length=1), stri_rand_strings(1,1,"[actg]"))
      }
      else {
         # substitution
         j <- sample(1:nchar(y), 1)
         stri_sub(y, j, length=1) <- stri_rand_strings(1,1,"[actg]")
      }
   }
   y
})


k <- 20
d <- 100
n <- 2500
s <- 50
scenario <- "actg1"
centers <- stringi::stri_rand_strings(k, d, '[actg]')
data <- character(n)
labels <- integer(n)
for (i in 1:n) {
   j <- sample(1:k, 1)
   labels[i] <- j
   data[i] <- levenshtein_jitter(centers[j], s)
}

writeLines(data, gzfile(sprintf("devel/benchmark_data/%s.data.gz", scenario)))
write.table(labels, gzfile(sprintf("devel/benchmark_data/%s.labels.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)


k <- 5
d <- 200
n <- 2500
s <- 100
p <- pbinom(0:(k-1), k-1, 0.5); p <- p/sum(p)
scenario <- "actg2"
centers <- stringi::stri_rand_strings(k, d, '[actg]')
data <- character(n)
labels <- integer(n)
for (i in 1:n) {
   j <- sample(1:k, 1, prob=p)
   labels[i] <- j
   data[i] <- levenshtein_jitter(centers[j], s)
}

writeLines(data, gzfile(sprintf("devel/benchmark_data/%s.data.gz", scenario)))
write.table(labels, gzfile(sprintf("devel/benchmark_data/%s.labels.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)


k <- 10
d <- 250
n <- 2500
s <- 150
p <- dpois(0:(k-1), k/2-1); p <- p/sum(p); p*n
scenario <- "actg3"
centers <- stringi::stri_rand_strings(k, d, '[actg]')
data <- character(n)
labels <- integer(n)
for (i in 1:n) {
   j <- sample(1:k, 1, prob=p)
   labels[i] <- j
   data[i] <- levenshtein_jitter(centers[j], s)
}

writeLines(data, gzfile(sprintf("devel/benchmark_data/%s.data.gz", scenario)))
write.table(labels, gzfile(sprintf("devel/benchmark_data/%s.labels.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
