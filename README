# GeorgeR Package

A personal R package for standardized analysis environment setup. This package provides functions to prepare your R environment for both regular R scripts and R Markdown documents, including automatic chunk options, caching setup, and data loading.

## Installation

### First Time Installation

```r
# Install devtools if you don't have it
if (!require("devtools")) install.packages("devtools")

# Install GeorgeR from GitHub
devtools::install_github("yourusername/GeorgeR")  # UPDATE: Replace with your actual GitHub username
```

### Loading the Package

```r
library(GeorgeR)
```

## Usage

### Basic Usage

The main function is `PrepareEnvironment()`, which sets up your analysis environment:

```r
# For R Markdown documents
PrepareEnvironment(rmarkdown = TRUE)

# For regular R scripts
PrepareEnvironment(rmarkdown = FALSE)

# For R Markdown with custom figure dimensions
PrepareEnvironment(rmarkdown = TRUE, fig.dims = c(10, 6))
```

### What PrepareEnvironment() Does

When you call `PrepareEnvironment()`:

1. **Always**: Sources your `src/load_data.R` file (make sure this exists in your project)
2. **For R Markdown** (`rmarkdown = TRUE`):
   - Sets up chunk options (no echo, caching enabled, custom paths)
   - Configures figure and cache directories based on your file name
   - Sets up meta tags (if meta package available)
   - Suppresses dplyr summarise messages
3. **For Scripts** (`rmarkdown = FALSE`):
   - Just loads your data and environment

### Automatic Updates

To automatically check for and install package updates:

```r
# Check for updates and install if available
PrepareEnvironment(rmarkdown = TRUE, update = TRUE)

# Quiet updates (no messages)
PrepareEnvironment(rmarkdown = TRUE, update = TRUE, quiet = TRUE)
```

**Note**: After an update is installed, you'll need to restart your R session to use the new version.


# Notes to Self

Upating:

Update version in the description, or use

```
usethis::use_version("patch")  # 0.0.0.9000 → 0.0.0.9001
usethis::use_version("minor")  # 0.0.0.9001 → 0.0.1.0000
```

Then,
```
# Update documentation from roxygen comments
devtools::document()

# Check for issues (optional but recommended)
devtools::check()

# Commit your changes
git add .
git commit -m "<message>"

# Push to GitHub
git push
```
