# beheim2014strategic

# this script executes the project from https://github.com/babeheim/go-firstmove  

unlink("./evidence/", recursive = TRUE)
dir.create("./evidence/")

library(rethinking)

# source project script 

source("run_project.r")

# if it gets stuck compiling manuscript
# error "--latex-engine has been removed. Use --pdf-engine instead"
# use: system("pandoc ./markdown/manuscript.md --pdf-engine=xelatex --template=./assets/go-template.tex -o ./tex/manuscript.tex")
# and the rest is project folder cleanup



# extract results for report
# all code is from original author (beheim)'s R scripts in materials folder

load("materials/4_fit_models/output/horizon24.RData")
d <- read.csv("materials/4_fit_models/inputs/fourfour_final.csv", stringsAsFactors = FALSE)



# Result 1: Table 1
# beta versus gamma fourfour use rate

post <- extract.samples(horizon24)
fixed_eff <- post[c("beta_b_44", "beta_pop_44")]

r1 <- cbind(lapply(fixed_eff, mean), 
            lapply(fixed_eff, sd))

save(r1, file = "evidence/beheim2014strategic1.robj")

# Result 2: Figure 5, panel left
# this code is taken directly from materials r scripts

library(RColorBrewer)
p <- extract.samples(horizon24)

tiff("evidence/beheim2014strategic2.png", 
     height = 1200, 
     width = 1200, 
     res = 250)

par(mar = c(5.1, 4.1, 0, 2.1))
par(family = "Times")

my_cols <- brewer.pal(6, "Spectral")

set.seed(1000)
thin <- sample(1:3000, 1000)

plot(c(-4, 10), c(-10, 16), col = "white", pch = 20,
     xlab = "reliance on individual information",
     ylab = "reliance on social information", las = 1)

target_id_list <- integer(0)
target_name_list <- character(0)

target <- "Peng Quan"
target_col <- my_cols[1]
target_id <- unique(d$PB_id[d$PB == target])
i <- as.numeric(target_id)
target_name_list <- c(target_name_list, target)
target_id_list <- c(target_id_list, target_id)
points(p$vary_PB_id[thin, i, 2] + mean(p$beta_b_44[thin]),
       p$vary_PB_id[thin, i, 3] + mean(p$beta_pop_44[thin]),
       col = col.alpha(target_col, 0.3), pch = 20)

target <- "Kato Atsushi"
target_col <- my_cols[2]
target_id <- unique(d$PB_id[d$PB == target])
i <- target_id
target_name_list <- c(target_name_list, target)
target_id_list <- c(target_id_list, target_id)
points(p$vary_PB_id[thin, i, 2] +
         mean(p$beta_b_44[thin]), p$vary_PB_id[thin, i, 3] +
         mean(p$beta_pop_44[thin]), col = col.alpha(target_col, 0.3), pch = 20)

target <- "Takemiya Masaki"
target_col <- my_cols[3]
target_id <- unique(d$PB_id[d$PB == target])
i <- target_id
target_name_list <- c(target_name_list, target)
target_id_list <- c(target_id_list, target_id)
points(p$vary_PB_id[thin, i, 2] +
         mean(p$beta_b_44[thin]), p$vary_PB_id[thin, i, 3] +
         mean(p$beta_pop_44[thin]), col = col.alpha(target_col, 0.3), pch = 20)

target <- "Hashimoto Shoji"
target_col <- my_cols[4]
target_id <- unique(d$PB_id[d$PB == target])
i <- target_id
target_name_list <- c(target_name_list, target)
target_id_list <- c(target_id_list, target_id)
points(p$vary_PB_id[thin, i, 2] +
         mean(p$beta_b_44[thin]), p$vary_PB_id[thin, i, 3] +
         mean(p$beta_pop_44[thin]), col = col.alpha(target_col, 0.3), pch = 20)

target <- "Yi Se-tol"
target_col <- my_cols[5]
target_id <- unique(d$PB_id[d$PB == target])
i <- target_id
target_name_list <- c(target_name_list, target)
target_id_list <- c(target_id_list, target_id)
points(p$vary_PB_id[thin, i, 2] +
         mean(p$beta_b_44[thin]), p$vary_PB_id[thin, i, 3] +
         mean(p$beta_pop_44[thin]), col = col.alpha(target_col, 0.3), pch = 20)

target <- "Cho Hun-hyeon"
target_col <- my_cols[6]
target_id <- unique(d$PB_id[d$PB == target])
i <- target_id
target_name_list <- c(target_name_list, target)
target_id_list <- c(target_id_list, target_id)
points(p$vary_PB_id[thin, i, 2] +
         mean(p$beta_b_44[thin]), p$vary_PB_id[thin, i, 3] +
         mean(p$beta_pop_44[thin]), col = col.alpha(target_col, 0.3), pch = 20)

target_name_list[target_name_list == "Takemiya Masaki"] <- "Takemiya\nMasaki"
target_name_list[target_name_list == "Yi Se-tol"] <- "Lee\nSedol"
target_name_list[target_name_list == "Cho Hun-hyeon"] <- "   Cho\n    Hunhyun"
target_name_list[target_name_list == "Hashimoto Shoji"] <- "   Hashimoto\n Shoji"
target_name_list[target_name_list == "Kato Atsushi"] <- "Kato\nAtsushi"
target_name_list[target_name_list == "Peng Quan"] <- "Peng\nQuan"

points(p$beta_b_44[thin], p$beta_pop_44[thin], pch = 20,
       col = col.alpha("black", 0.3))

abline(h = 0, lty = 2, col = col.alpha("black", 0.6))
abline(v = 0, lty = 2, col = col.alpha("black", 0.6))
abline(0, 1, lty = 1, col = gray(0.3))

for (i in 1:length(target_id_list)) {
  text(mean(p$vary_PB_id[ , target_id_list[i], 2] +
              p$beta_b_44), mean(p$vary_PB_id[ , target_id_list[i], 3] +
                                   p$beta_pop_44), target_name_list[i])
}

dev.off()



# Result 3: Figure 5, panel right

tiff("evidence/beheim2014strategic3.png", 
     height = 1200, 
     width = 1200, 
     res = 250)

n_ages <- length(unique(d$b_age_group))

my_pop_means <- apply(p$vary_b_age_group[ , , 2], 2, mean) + mean(p$beta_pop_44)
my_pop_HPDI <- apply(p$vary_b_age_group[ , , 2], 2, HPDI) + mean(p$beta_pop_44)
plot(my_pop_means, type = "p", ylim = c(-2, 9), xaxt = "n",
     ylab = "reliance on social information", xlab = "age (years)",
     xlim = c(3, 63), las = 1, col = "black", cex = 0.5, pch = 20)
axis(1, at = seq(3, 78, by = 10), labels =  seq(3, 78, by = 10) + 7)
for (i in 1:n_ages) lines(c(i, i), c(my_pop_HPDI[1, i], my_pop_HPDI[2, i]),
                          col = "black")
abline(h = mean(p$beta_pop_44), lty = 2, col = "black")

dev.off()



# Result 4: Table 2

JP_cols <- sort(unique(d$PB_id[d$BN == "Japanese"]))
CH_cols <- sort(unique(d$PB_id[d$BN == "Chinese"]))
SK_cols <- sort(unique(d$PB_id[d$BN == "Korean"]))
TW_cols <- sort(unique(d$PB_id[d$BN == "Taiwanese"]))

japanese_beta_intercepts <- colMeans(p$vary_PB_id[ , JP_cols, 2])
japanese_gamma_intercepts <- colMeans(p$vary_PB_id[ , JP_cols, 3])

chinese_beta_intercepts <- colMeans(p$vary_PB_id[ , CH_cols, 2])
chinese_gamma_intercepts <- colMeans(p$vary_PB_id[ , CH_cols, 3])

korean_beta_intercepts <- colMeans(p$vary_PB_id[ , SK_cols, 2])
korean_gamma_intercepts <- colMeans(p$vary_PB_id[ , SK_cols, 3])

taiwanese_beta_intercepts <- colMeans(p$vary_PB_id[ , TW_cols, 2])
taiwanese_gamma_intercepts <- colMeans(p$vary_PB_id[ , TW_cols, 3])

ja_n <- length(japanese_beta_intercepts)
ja_beta_mean <- sprintf("%.2f", mean(japanese_beta_intercepts), 2)
ja_beta_se <- sprintf("%.2f", sd(japanese_beta_intercepts) / sqrt(ja_n), 2)
ja_gamma_mean <- sprintf("%.2f", mean(japanese_gamma_intercepts), 2)
ja_gamma_se <- sprintf("%.2f", sd(japanese_gamma_intercepts) / sqrt(ja_n), 2)

ch_n <- length(chinese_beta_intercepts)
ch_beta_mean <- sprintf("%.2f", mean(chinese_beta_intercepts), 2)
ch_beta_se <- sprintf("%.2f", sd(chinese_beta_intercepts) / sqrt(ch_n), 2)
ch_gamma_mean <- sprintf("%.2f", mean(chinese_gamma_intercepts), 2)
ch_gamma_se <- sprintf("%.2f", sd(chinese_gamma_intercepts) / sqrt(ch_n), 2)

ko_n <- length(korean_beta_intercepts)
ko_beta_mean <- sprintf("%.2f", mean(korean_beta_intercepts), 2)
ko_beta_se <- sprintf("%.2f", sd(korean_beta_intercepts) / sqrt(ko_n), 2)
ko_gamma_mean <- sprintf("%.2f", mean(korean_gamma_intercepts), 2)
ko_gamma_se <- sprintf("%.2f", sd(korean_gamma_intercepts) / sqrt(ko_n), 2)

ta_n <- length(taiwanese_beta_intercepts)
ta_beta_mean <- sprintf("%.2f", mean(taiwanese_beta_intercepts), 2)
ta_beta_se <- sprintf("%.2f", sd(taiwanese_beta_intercepts) / sqrt(ta_n), 2)
ta_gamma_mean <- sprintf("%.2f", mean(taiwanese_gamma_intercepts), 2)
ta_gamma_se <- sprintf("%.2f", sd(taiwanese_gamma_intercepts) / sqrt(ta_n), 2)

n <- c(ch_n, ja_n, ko_n, ta_n)
beta_mean <- c(ch_beta_mean, ja_beta_mean, ko_beta_mean, ta_beta_mean)
beta_se <- c(ch_beta_se, ja_beta_se, ko_beta_se, ta_beta_se)
gamma_mean <- c(ch_gamma_mean, ja_gamma_mean, ko_gamma_mean, ta_gamma_mean)
gamma_se <- c(ch_gamma_se, ja_gamma_se, ko_gamma_se, ta_gamma_se)
nationality <- c("Chinese", "Japanese", "South Korean", "Taiwanese")

r4 <- cbind(nationality, n, beta_mean, beta_se, gamma_mean, gamma_se)

save(r4, file = "evidence/beheim2014strategic4.robj")
