reproducibility-example
============

This repository contains an example of the analytical reproducibility protocol from:

> Minocher et al. "Reproducibility of social learning research declines exponentially over 63 years of publication"

We share data and code for this example, with permission from the original authors, from:

> Bret A. Beheim, Calvin Thigpen, Richard McElreath, "Strategic social learning and the population dynamics of human behavior: the game of Go", Volume 35, Issue 5, pp.351-357, DOI: http://dx.doi.org/10.1016/j.evolhumbehav.2014.04.001

The original materials are available at https://github.com/babeheim/go-firstmove.

To view the reproducibility report, clone the repository and visit the html page.

## About this example

This is an **example** of the protocol we applied to 40 studies, a subset of our survey's full sample of 560 studies. This particular study was included in our full sample of 560, but not in our subset of 40. This report was created only to demonstrate our protocol, and is shared with permission from the authors. 

## Walking through our protcol

1. We identified individual, key results from the publication abstract (see .Rmd).

2. We inspected materials available to us, online or through personal data requests. In this case, the materials are available online, at https://github.com/babeheim/go-firstmove, included in the folder "materials".

3. We created an R script to extract identified results (see .R).

4. We compiled extracted results into the .Rmd report. We coded individual results as reproduced or not, listing evidence reproduced and adding notes about failure, if applicable. 

We did this for each study in our subsample. We aggregated the individually coded results for each study into a single dataset for analysis (110 results, for 40 papers). We used a unique key (here, "beheim2014strategic") to track studies.  

## Navigating this repository

- the "materials" folder is identical to https://github.com/babeheim/go-firstmove.

- beheim2014strategic.Rmd is the reproducibility report

- beheim2014strategic.R extracts results for the report

- beheim2014strategic.html is produced by the .Rmd to view a formatted version of the report

- beheim2014strategic.pdf is the original article for this example, for reference