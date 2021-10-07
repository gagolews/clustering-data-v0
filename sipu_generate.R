# https://cs.joensuu.fi/sipu/datasets/

fname <- c('s1', 's2', 's3', 's4')
for (scenario in fname) {
   data <- suppressMessages(scan(paste0('devel/data/', scenario, '.txt'), quiet=TRUE))
   data <- matrix(data, nrow=5000, byrow=TRUE)
   labels <- suppressMessages(scan(paste0('devel/data/', scenario, '-label.pa'), skip=5, quiet=TRUE))
   write.table(data, gzfile(sprintf("devel/benchmark_data/%s.data.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
   write.table(labels, gzfile(sprintf("devel/benchmark_data/%s.labels.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
}

fname <- c('a1', 'a2', 'a3')
for (scenario in fname) {
   data <- suppressMessages(scan(paste0('devel/data/', scenario, '.txt'), quiet=TRUE))
   n <- length(data)/2
   data <- matrix(data, nrow=n, byrow=TRUE)
   labels <- rep(1:(n/150), each=150)
   write.table(data, gzfile(sprintf("devel/benchmark_data/%s.data.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
   write.table(labels, gzfile(sprintf("devel/benchmark_data/%s.labels.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
}

# fname <- c('dim032', 'dim064', 'dim1024')
# for (scenario in fname) {
#    data <- suppressMessages(scan(paste0('devel/data/', scenario, '.txt'), quiet=TRUE))
#    data <- matrix(data, nrow=1024, byrow=TRUE)
#    labels <- rep(1:16, each=1024/16)
#    write.table(data, gzfile(sprintf("devel/benchmark_data/%s.data.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
#    write.table(labels, gzfile(sprintf("devel/benchmark_data/%s.labels.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
# }

fname <- c("g2-2-100", "g2-4-100", "g2-8-100", "g2-16-100", "g2-32-100", "g2-64-100")
for (scenario in fname) {
   data <- suppressMessages(scan(paste0('devel/data/', scenario, '.txt'), quiet=TRUE))
   data <- matrix(data, ncol=length(data)/2048, byrow=TRUE)
   labels <- rep(1:2, each=2048/2)
   write.table(data, gzfile(sprintf("devel/benchmark_data/%s.data.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
   write.table(labels, gzfile(sprintf("devel/benchmark_data/%s.labels.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
}

fname <- c('Aggregation',
        'Compound',
        'pathbased',
        'spiral',
        'D31',
        'R15',
        'flame',
        'jain')

for (scenario in fname) {
   data <- read.delim(paste0('devel/data/', scenario, '.txt'), header=FALSE)
   labels <- as.integer(data[,3])
   data <- data[,-3]
   write.table(data, gzfile(sprintf("devel/benchmark_data/%s.data.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
   write.table(labels, gzfile(sprintf("devel/benchmark_data/%s.labels.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
}


scenario <- "unbalance"
data <- read.delim("devel/data/unbalance.txt", sep=" ", header=FALSE)
labels <- c(rep(1, 2000), rep(2, 2000), rep(3, 2000), rep(4, 100), rep(5, 100), rep(6, 100), rep(7, 100), rep(8, 100))
write.table(data, gzfile(sprintf("devel/benchmark_data/%s.data.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
   write.table(labels, gzfile(sprintf("devel/benchmark_data/%s.labels.gz", scenario)), col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)

