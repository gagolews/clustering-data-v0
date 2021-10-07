# http://yann.lecun.com/exdb/mnist/
#
# THE MNIST DATABASE
# of handwritten digits
# Yann LeCun, Courant Institute, NYU
# Corinna Cortes, Google Labs, New York
# Christopher J.C. Burges, Microsoft Research, Redmond
#
#  The original black and white (bilevel) images from NIST were size normalized
#  to fit in a 20x20 pixel box while preserving their aspect ratio.
#  The resulting images contain grey levels as a result of the
#  anti-aliasing technique used by the normalization algorithm.
#  The images were centered in a 28x28 image by computing the center of mass
#  of the pixels, and translating the image so as to position
#  this point at the center of the 28x28 field.
#  The original black and white (bilevel) images from NIST were size
#  normalized to fit in a 20x20 pixel box while preserving their aspect
#  ratio. The resulting images contain grey levels as a result of the
#  anti-aliasing technique used by the normalization algorithm. the
#  images were centered in a 28x28 image by computing the center of
#  mass of the pixels, and translating the image so as to position
#  this point at the center of the 28x28 field.  The original black
#  and white (bilevel) images from NIST were size normalized to fit
#  in a 20x20 pixel box while preserving their aspect ratio. The
#  resulting images contain grey levels as a result of the
#  anti-aliasing technique used by the normalization algorithm.
#  The images were centered in a 28x28 image by computing the center
#  of mass of the pixels, and translating the image so as to position
#  this point at the center of the 28x28 field.


# Code Copyright (C) 2015, Marek Gagolewski

f <- file('devel/data/t10k-labels-idx1-ubyte', 'rb')
stopifnot(readBin(f, 'integer', 1L, endian='big') == 2049)
n <- readBin(f, 'integer', 1L, endian='big')
labels10 <- as.integer(readBin(f, 'raw', n, endian='big'))
close(f)

f <- file('devel/data/t10k-images-idx3-ubyte', 'rb')
stopifnot(readBin(f, 'integer', 1L, endian='big') == 2051)
stopifnot(readBin(f, 'integer', 1L, endian='big') == n)
nr <- readBin(f, 'integer', 1L, endian='big')
nc <- readBin(f, 'integer', 1L, endian='big')
images10 <- matrix(as.integer(readBin(f, 'raw', n*nr*nc, endian='big')), ncol=nr*nc, byrow=TRUE)
close(f)

f <- file('devel/data/train-labels-idx1-ubyte', 'rb')
stopifnot(readBin(f, 'integer', 1L, endian='big') == 2049)
n <- readBin(f, 'integer', 1L, endian='big')
labels60 <- as.integer(readBin(f, 'raw', n, endian='big'))
close(f)

f <- file('devel/data/train-images-idx3-ubyte', 'rb')
stopifnot(readBin(f, 'integer', 1L, endian='big') == 2051)
stopifnot(readBin(f, 'integer', 1L, endian='big') == n)
nr <- readBin(f, 'integer', 1L, endian='big')
nc <- readBin(f, 'integer', 1L, endian='big')
images60 <- matrix(as.integer(readBin(f, 'raw', n*nr*nc, endian='big')), ncol=nr*nc, byrow=TRUE)
close(f)

images <- rbind(images60, images10)
rm(images60)
rm(images10)

labels <- c(labels60, labels10)
rm(labels60)
rm(labels10)

f <- gzfile("devel/benchmark_data/digits70k_pixels.data.gz", open="w")
write.table(images, f, col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
close(f)
f <- gzfile("devel/benchmark_data/digits70k_pixels.labels.gz", open="w")
write.table(labels, f, col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
close(f)

f <- gzfile("devel/benchmark_data/digits2k_pixels.data.gz", open="w")
write.table(images[1:2000,], f, col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
close(f)
f <- gzfile("devel/benchmark_data/digits2k_pixels.labels.gz", open="w")
write.table(labels[1:2000], f, col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
close(f)

###############################################################################

n <- length(labels)

rot <- function(t) {
   matrix(c(cos(t), sin(t), -sin(t), cos(t)), nrow=2)
}
points <- vector('list', n)
coords <- cbind(rep(1:nr, times=nc), rep(nc:1, each=nr))


for (i in 1:n) {
   out <- cbind(coords, images[i,]/255)
   out <- out[out[,3] > 0.75,1:2]
   out[,1] <- out[,1]-mean(out[,1])
   out[,2] <- out[,2]-mean(out[,2])

   # plot(out[,1], out[,2], asp=1, pch=16)

   # p <- prcomp(out, center=FALSE, scale=FALSE)
   # D <- unclass(p$rotation)  %*% matrix(c(0,1,1,0),ncol=2)
   # if (D[1,1] < 0) D <- D %*% matrix(c(1,0,0,-1),ncol=2)
   # if (D[2,1] < 0) D <- D %*% matrix(c(-1,0,0,1),ncol=2)

   # TO DO: allow for only rotations -pi*c..pi*c
#    T <- seq(-pi/5, 0, len=25)
#    t <- T[which.max(sapply(T, function(t) { A <- rot(t); out2 <- out %*% A; var(out2[,2]) }))]
#    D <- rot(t)

   D <- diag(2)

   out <- out %*% D
   # out[,2] <- out[,2] / diff(range(out[,2]))
   # out[,1] <- out[,1] / diff(range(out[,1]))
   out <- out / diff(range(out[,2]))
   if (labels[i] != 1)
      out[,1] <- out[,1] / diff(range(out[,1])) * 0.5
   out[,1] <- out[,1] - min(out[,1]) - diff(range(out[,1]))/2
   out[,2] <- out[,2] - min(out[,2]) - diff(range(out[,2]))/2
   # plot(out[,1], out[,2], asp=1, pch=16)
   points[[i]] <- out
}

all_points70k <- do.call(rbind, lapply(seq_along(points), function(i) cbind(i, points[[i]])))

f <- gzfile("devel/benchmark_data/digits70k_points.data.gz", open="w")
write.table(all_points70k, f, col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
close(f)
f <- gzfile("devel/benchmark_data/digits70k_points.labels.gz", open="w")
write.table(labels, f, col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
close(f)

all_points2k <- do.call(rbind, lapply(1:2000, function(i) cbind(i, points[[i]])))

f <- gzfile("devel/benchmark_data/digits2k_points.data.gz", open="w")
write.table(all_points2k, f, col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
close(f)
f <- gzfile("devel/benchmark_data/digits2k_points.labels.gz", open="w")
write.table(labels[1:2000], f, col.names=FALSE, row.names=FALSE, sep=" ", quote=FALSE)
close(f)

