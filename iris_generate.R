iris2 <- iris[1:150,]
data <- as.matrix(iris2[,-5])
labels <- as.integer(iris2[,5])

f <- gzfile("devel/benchmark_data/iris.data.gz", open="w")
write.table(data, f, col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
close(f)
f <- gzfile("devel/benchmark_data/iris.labels.gz", open="w")
write.table(labels, f, col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
close(f)

iris2 <- iris[46:150,]
data <- as.matrix(iris2[,-5])
labels <- as.integer(iris2[,5])

f <- gzfile("devel/benchmark_data/iris5.data.gz", open="w")
write.table(data, f, col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
close(f)
f <- gzfile("devel/benchmark_data/iris5.labels.gz", open="w")
write.table(labels, f, col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
close(f)
