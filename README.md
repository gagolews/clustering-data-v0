# Clustering Benchmark Data [DEPRECATED]

## Important Note

This list has been superseded by
[Benchmark Suite for Clustering Algorithms - Version 1](https://github.com/gagolews/clustering_benchmarks_v1)!

## General Remarks

If used in publications (as a whole), please cite this dataset battery as: Gagolewski M., Bartoszuk M., Cena A., Genie: A new, fast, and outlier-resistant hierarchical clustering algorithm, *Information Sciences* **363**, 2016, pp. 8-23, doi:[10.1016/j.ins.2016.05.003](https://dx.doi.org/10.1016/j.ins.2016.05.003).

In each case, there is a data text file, storing an n * d matrix (n observations in a d dimensional space), and the corresponding labels file which consists of n labels being integers from the set 1,…,k, where k is the number of underlying clusters.

## Datasets

## MNIST Handwritten Digits (images)

Download files:

* digits70k_pixels.data.gz (15 MB), digits70k_pixels.labels.gz (37 kB), n=70000, d=784, k=10,
* digits2k_pixels.data.gz (440 kB), digits2k_pixels.labels.gz (1 kB), n=2000, d=784, k=10.

This data come from [The MNIST database](http://yann.lecun.com/exdb/mnist/)
of handwritten digits by Yann LeCun, Corinna Cortes,
and Christopher J.C. Burges. The dataset was originally released
in form of binary files.

`digits70k_pixels` consists of 70000 of 28x28 pixel images from the MNIST database, in order of appearance: 30000 SD-3 training patterns, 30000 SD-1 training patterns, 5000 SD-3 test patterns, and 5000 SD-1 test patterns. Moreover, `digits2k_pixels` gives first 2000 objects from `digits70k_pixels`.

To import the dataset in Python, execute:

```python
import numpy as np
data = np.loadtxt("digits2k_pixels.data.gz", ndmin=2)/255.0
data.shape = (data.shape[0], int(np.sqrt(data.shape[1])), int(np.sqrt(data.shape[1])))
labels = np.loadtxt("digits2k_pixels.labels.gz", dtype='int')
# display:
import matplotlib.pyplot as plt
i = 122
print(labels[i])
plt.imshow(data[i,:,:], cmap=plt.get_cmap("gray"))
plt.show()
```

To do the same in R, write:

```r
data <- as.matrix(read.table(gzfile("digits2k_pixels.data.gz")))/255
dim(data) <- c(nrow(data), 28, 28)
labels <- scan(gzfile("digits2k_pixels.labels.gz"), quiet=TRUE)
# draw:
i <- 123
par(mar=rep(0,4))
image(data[i,,], asp=1, col=gray.colors(256), ylim=c(1,0), axes=FALSE)
```

Distribution of labels:

```
##                     0    1    2    3    4    5    6    7    8    9
## digits2k_pixels   191  220  198  191  214  180  200  224  172  210
## digits70k_pixels 6903 7877 6990 7141 6824 6313 6876 7293 6825 6958
```

### MNIST Handwritten Digits (point sets)

Download files:


* digits70k_points.data.gz (18 MB), digits70k_points.labels.gz (37 kB), n=70000, d=2, k=10,
* digits2k_points.data.gz (555 kB), digits2k_points.labels.gz (1 kB), n=2000, d=2, k=10.

Based on the aforementioned dataset, we can represent each digit as a set of
points in R². Brightness cutoff of 0.75 was used to generate the data.
Each digit was shifted and scaled.

Warning. The dataset consists of 3 columns. The 1st column indicates to
which digit (one of 70000 or 2000) a point with x and y coordinates given
by the 2nd and the 3rd column, respectively, belongs to. Therefore, the dataset must be preprocessed before use.

To do so in R, execute:

```r
data <- as.matrix(read.table(gzfile("digits2k_points.data.gz")))
data <- lapply(split(data[,-1], data[,1]), function(digit) matrix(digit, ncol=2))
# now data is a list of 2-column matrices
labels <- scan(gzfile("digits2k_points.labels.gz"), quiet=TRUE)
# draw:
i <- 123
par(mar=rep(0,4))
plot(data[[i]][,1], data[[i]][,2], asp=1, axes=FALSE, ann=FALSE, pch=16)
```

Equivalent Python code:

```python
import numpy as np
data = np.loadtxt("digits2k_points.data.gz", ndmin=2)
labels = np.loadtxt("digits2k_pixels.labels.gz", dtype='int')
brk, = np.nonzero(np.diff(data[:,0]))
data = np.array_split(data[:,1:], brk+1, 0)
# draw:
import matplotlib.pyplot as plt
i = 122
fig = plt.figure()
fig.add_subplot(111, aspect='equal')
plt.scatter(data[i][:,0], data[i][:,1])
plt.show()
```


Label distribution:


```
##                     0    1    2    3    4    5    6    7    8    9
## digits2k_points   191  220  198  191  214  180  200  224  172  210
## digits70k_points 6903 7877 6990 7141 6824 6313 6876 7293 6825 6958
```

In this case, try playing with the Hausdorff (e.g., Euclidean-based)
distance, see `hausdorff.cpp` for a few auxiliary Rcpp routines.


### Iris(es)


Download files:

* iris.data.gz (681 B), iris.labels.gz (31 B), n=150, d=4, k=3,
* iris5.data.gz (520 B), iris5.labels.gz (30 B), n=105, d=4, k=3.


This is the famous Fisher’s *iris* dataset, available in the R `datasets`
package. `iris5` is an imbalanced version in which we take
only 5 last observations from the 1st group (*iris setosa*).


Distribution of labels:

```
##        1  2  3
## iris  50 50 50
## iris5  5 50 50
```

### SIPU Benchmark Data

Speech and Image Processing Unit, School of Computing, University of
Eastern Finland prepared a list of exemplary benchmarks which is available
[here](http://cs.joensuu.fi/sipu/datasets/). As some of the datasets
come with no labels, we make them available here in a concise format.
We chose only the datasets of sizes <= 10000 and such that some of the
hierarchical clustering algorithms had problems with correctly guessing the
proper labels.


#### S-sets

Download files:

* s1.data.gz (34 kB), s1.labels.gz (83 B), n=5000, d=2, k=15
* s2.data.gz (35 kB), s2.labels.gz (83 B), n=5000, d=2, k=15
* s3.data.gz (35 kB), s3.labels.gz (83 B), n=5000, d=2, k=15
* s4.data.gz (35 kB), s4.labels.gz (83 B), n=5000, d=2, k=15


Source: P. Fränti, O. Virmajoki, Iterative shrinking method for clustering problems, *Pattern Recognition*, **39**(5), 2006, pp. 761-765.

Distribution of labels:

```
##      1   2   3   4   5   6   7   8   9  10  11  12  13  14  15
## s1 300 316 314 318 325 326 334 338 341 342 347 349 350 350 350
## s2 300 317 315 320 321 329 334 333 340 345 346 350 350 350 350
## s3 300 321 316 323 322 331 333 337 334 337 346 350 350 350 350
## s4 300 316 327 320 323 324 327 336 337 344 347 350 349 350 350
```

#### A-sets

Download files:

* a1.data.gz (17 kB), a1.labels.gz (82 B), n=3000, d=2, k=20
* a2.data.gz (29 kB), a2.labels.gz (112 B), n=5250, d=2, k=35
* a3.data.gz (41 kB), a3.labels.gz (144 B), n=7500, d=2, k=50


Source: I. Kärkkäinen, P. Fränti, *Dynamic local search algorithm for the clustering problem*, Research Report A-2002-6.

Distribution of labels: Classes are fully balanced.


#### G2-sets

Download files:

* g2-2-100.data.gz (7 kB), g2-2-100.labels.gz (43 B), n=2048, d=2, k=2
* g2-16-100.data.gz (52 kB), g2-16-100.labels.gz (43 B), n=2048, d=16, k=2
* g2-64-100.data.gz (200 kB), g2-64-100.labels.gz (43 B), n=2048, d=64, k=2

Gaussian clusters of varying dimensions, high variance.

Distribution of labels: Classes are fully balanced.


#### Other

Download files:

* unbalance.data.gz (37 kB), unbalance.labels.gz (65 B), n=6500, d=2, k=8
* Aggregation.data.gz (3 kB), Aggregation.labels.gz (48 B), n=788, d=2, k=7
* Compound.data.gz (1 kB), Compound.labels.gz (43 B), n=399, d=2, k=6
* pathbased.data.gz (1 kB), pathbased.labels.gz (36 B), n=300, d=2, k=3
* spiral.data.gz (1 kB), spiral.labels.gz (31 B), n=312, d=2, k=3
* D31.data.gz (20 kB), D31.labels.gz (97 B), n=3100, d=2, k=31
* R15.data.gz (3 kB), R15.labels.gz (63 B), n=600, d=2, k=15
* flame.data.gz (878 B), flame.labels.gz (35 B), n=240, d=2, k=2
* jain.data.gz (1 kB), jain.labels.gz (31 B), n=373, d=2, k=2


Sources:

* A. Gionis, H. Mannila, P. Tsaparas, Clustering aggregation, *ACM
    Transactions on Knowledge Discovery from Data (TKDD)*, 2007, pp. 1-30.
* C.T. Zahn, Graph-theoretical methods for detecting and describing gestalt
    clusters, *IEEE Transactions on Computers* **C-20**(1), 1971, pp. 68-86.
* H. Chang, D.Y. Yeung, Robust path-based spectral clustering, *Pattern
    Recognition* **41**(1), 2008, pp. 191-203.
* C.J. Veenman, M.J.T. Reinders, E. Backer, A maximum variance cluster
    algorithm, *IEEE Transactions on Pattern Analysis and Machine
    Intelligence* **24**(9), 2002, pp. 1273-1280.
* A. Jain, M. Law, Data clustering: A user’s dilemma, *Lecture Notes
    in Computer Science* **3776**, 2005, pp. 1-10.
* L. Fu, E. Medico, FLAME, a novel fuzzy clustering method for the analysis
    of DNA microarray data, *BMC bioinformatics* **8**, 2007, p. 3.

Label distributions:

```
##                     1    2    3   4   5   6   7   8
## unbalance        2000 2000 2000 100 100 100 100 100
##
##                   1   2   3   4  5   6  7
## Aggregation      45 170 102 273 34 130 34
##
##                   1  2  3  4   5  6
## Compound         50 92 38 45 158 16
##
##                    1  2  3
## pathbased        110 97 93
##
##                    1   2   3
## spiral           101 105 106
##
## D31              balanced
##
## R15              balanced
##
##                   1   2
## flame            87 153
##
##                    1  2
## jain             276 97
```


### Character Strings

#### ACTG Sequences

Download files:


* actg1.data.gz (77 kB), actg1.labels.gz (2 kB), n=2500, mean d=99.9, k=20
* actg2.data.gz (149 kB), actg2.labels.gz (1 kB), n=2500, mean d=199.9, k=5
* actg3.data.gz (187 kB), actg3.labels.gz (1 kB), n=2500, mean d=250.2, k=10


The datasets consist of character strings (of varying lengths) over the
{a,c,t,g} alphabet. First, *k* random strings (of identical lengths)
were generated for the purpose of being cluster centres. Each string in
the dataset was created by selecting a random cluster centre and then
performing many Levenshtein edit operations (character insertions,
deletions, substitutions) at randomly chosen positions.

Preferably for use with the Levenshtein distance.

```r
library("stringi")
data <- readLines(gzfile("actg1.data.gz"))
labels <- scan(gzfile("actg1.labels.gz"), quiet=TRUE)
# five observations in the 1st group:
cat(data[labels==1][1:5], sep='\n')
## ctttctgtgctcgcgagctaaacgtgtgtaggcccttgtactacaaccaactgctagaatagtgacgcccctttgcctggcgcgccgctacttttagcgggcatgacg
## ctttgatgtgctgaataatctcagggctgtgtactacatcaagtccaccactactagttggcgaccgctttcctagagacagcgcaagcattcacatacg
## ccaccttatgctgcatgaacgggcggattggatctacaaccgcaattgctagaattcgcctcctttggacaattacgtgctacttaaagcgcctcg
## cacttcatgaacggataccgatgtggggcatttgtactactccgaacactagcgattcgaccgcgttttctggacaacgccaagactgttttaacgtcaga
## cctagtgcacgtgacacactggtgtggctgggtaacgtcccacaacacctgctagaatcgacccgcacttaggaacagcaagtactgttaagcgcattct
```


Label distributions:

```
##                    1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19  20
## actg1            137 121 133 132 123 124 131 111 118 120 122 139 142 123 124 116 122 124 124 114
##
##                   1   2   3   4   5
## actg2            50 246 571 783 850
##
##                   1   2   3   4   5   6   7   8  9 10
## actg3            50 181 390 487 501 384 267 132 65 43
```


#### Binary Sequences


Download files:

* binstr1.data.gz (44 kB), binstr1.labels.gz (2 kB), n=2500, d=100, k=25
* binstr2.data.gz (85 kB), binstr2.labels.gz (1 kB), n=2500, d=200, k=5
* binstr3.data.gz (105 kB), binstr3.labels.gz (1 kB), n=2500, d=250, k=10

Datasets consist of character strings (each of the same length *d*) over the
{0,1} alphabet. First, *k* random strings were generated for the purpose
of being cluster centres. Each string in the dataset was created by selecting
a random cluster centre and then modifying digits at randomly chosen positions.

Preferably for use with the Hamming distance.

```r
library("stringi")
data <- readLines(gzfile("binstr1.data.gz"))
labels <- scan(gzfile("binstr1.labels.gz"), quiet=TRUE)
# 1st cluster median (w.r.t. the Hamming distance)
mode <- function(x) { t <- table(x); names(t)[which.max(t)] }
cat(stri_flatten(apply(do.call(rbind, stri_split_boundaries(data[labels==1],
type="character")), 2, mode)))
## 0101101110101101000111111111001111001000000000000100101001101000101110111000010001010011100101001001
# five observations in the 1st group:
cat("\n", data[labels==1][1:5], sep='\n')
## 0101001000111001001011111110001111101100100000101100101000100000111110111011000001111010000101101011
## 0011101010111001000011100001101111010000000111001100100001111001110110101000000000010001110001001100
## 0010100100100101000111001110011111001000110001000110011001101011100110111100010001110111100101001001
## 0101001001000001000011001001001111000011000010010101111100101110101110111010000001000011000101001001
## 1101001001001100010111011111011001111000001100000100001001101000000010111000110001010011110110000001
```

Label distributions:

```
##                   1   2   3   4   5  6   7  8   9  10 11 12  13  14 15  16  17  18 19 20 21  22 23  24  25
## binstr1          97 112 112 101 104 91 106 88 105 104 86 95 113 107 76 101 110 105 98 90 76 108 91 111 113
##
##                   1   2   3   4   5
## binstr2          51 267 540 756 886
##
##                   1  2   3   4   5   6   7   8   9  10
## binstr3          12 90 220 332 467 446 381 277 175 100
```


## Other

For more benchmark data, see:

* [Benchmark Suite for Clustering Algorithms - Version 1](https://github.com/gagolews/clustering_benchmarks_v1)

* [The Fundamental Clustering Problems Suite (FCPS)](https://www.uni-marburg.de/fb12/arbeitsgruppen/datenbionik/data?language_sync=1)

* [CLUTO Datasets](http://glaros.dtc.umn.edu/gkhome/cluto/cluto/download)

* Graves D., Pedrycz W., Kernel-based fuzzy clustering and fuzzy clustering:
    A comparative experimental study, *Fuzzy Sets and Systems* **161**(4), 2010, pp. 522-543.
