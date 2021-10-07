set.seed(123)


k <- 25
d <- 100
n <- 2500
s <- as.integer(2*d/3)
scenario <- "binstr1"
centers <- stringi::stri_rand_strings(k, d, '[01]')
data <- character(n)
labels <- integer(n)
for (i in 1:n) {
   j <- sample(1:k, 1)
   labels[i] <- j
   data[i] <- centers[j]
   for (u in seq_len(s))
      stringi::stri_sub(data[i], sample(1:d, 1), length=1) <- stringi::stri_rand_strings(1, 1, '[01]')
}

writeLines(data, gzfile(sprintf("devel/benchmark_data/%s.data.gz", scenario)))
write.table(labels, gzfile(sprintf("devel/benchmark_data/%s.labels.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)


k <- 5
d <- 200
n <- 2500
s <- as.integer(7*d/8)
p <- pbinom(0:(k-1), k-1, 0.5); p <- p/sum(p)
scenario <- "binstr2"
centers <- stringi::stri_rand_strings(k, d, '[01]')
data <- character(n)
labels <- integer(n)
for (i in 1:n) {
   j <- sample(1:k, 1, prob=p)
   labels[i] <- j
   data[i] <- centers[j]
   for (u in seq_len(s))
      stringi::stri_sub(data[i], sample(1:d, 1), length=1) <- stringi::stri_rand_strings(1, 1, '[01]')
}

writeLines(data, gzfile(sprintf("devel/benchmark_data/%s.data.gz", scenario)))
write.table(labels, gzfile(sprintf("devel/benchmark_data/%s.labels.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)



k <- 10
d <- 250
n <- 2500
s <- d
p <- dpois(0:(k-1), k/2); p <- p/sum(p); p*n
scenario <- "binstr3"
centers <- stringi::stri_rand_strings(k, d, '[001]')
data <- character(n)
labels <- integer(n)
for (i in 1:n) {
   j <- sample(1:k, 1, prob=p)
   labels[i] <- j
   data[i] <- centers[j]
   for (u in seq_len(s))
      stringi::stri_sub(data[i], sample(1:d, 1), length=1) <- stringi::stri_rand_strings(1, 1, '[011]')
}

writeLines(data, gzfile(sprintf("devel/benchmark_data/%s.data.gz", scenario)))
write.table(labels, gzfile(sprintf("devel/benchmark_data/%s.labels.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)

