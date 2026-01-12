# GitHub Copilot Instructions

## General Coding Principles

- Write clear, maintainable, and well-documented code
- Follow language-specific style guides and conventions
- Use descriptive variable and function names
- Add comments for complex logic
- Keep functions focused and modular

## R Programming

### Style Guidelines
- Follow the [tidyverse style guide](https://style.tidyverse.org/)
- Use `snake_case` for variable and function names
- Use `<-` for assignment (not `=`)
- Limit line length to 80 characters
- Place spaces around operators and after commas

### Best Practices
- Use `tidyverse` packages (dplyr, ggplot2, tidyr) for data manipulation and visualization
- Leverage the native pipe `|>` for readable data workflows
- Use `here::here()` for file path management to ensure reproducibility
- Document functions using roxygen2 comments (`#'`)
- Use RMarkdown or Quarto for reproducible reports and analyses
- Handle missing data explicitly with `na.rm`, `na.omit()`, or `tidyr::drop_na()`
- Use vectorized operations instead of loops when possible
- Load required packages at the top of scripts with `library()`

### Code Structure
```r
# Load libraries
library(tidyverse)
library(here)


# Define functions
calculate_summary <- function(data, group_var) {
  # Function documentation here
  data |>
    group_by({{ group_var }}) |>
    summarize(
      mean_value = mean(value, na.rm = TRUE),
      .groups = "drop"
    )
}

# Main analysis code
```

## Python Programming

### Style Guidelines
- Follow [PEP 8](https://peps.python.org/pep-0008/) style guide
- Use `snake_case` for variables and functions, `PascalCase` for classes
- Use 4 spaces for indentation (no tabs)
- Limit line length to 79 characters (88 for Black formatter)
- Use docstrings for functions, classes, and modules

### Best Practices
- Use virtual environments (venv, conda) for dependency management
- Include type hints for function parameters and return values
- Use list/dict comprehensions for concise operations
- Leverage built-in functions and standard library modules
- Handle exceptions explicitly with try-except blocks
- Use `pathlib.Path` for cross-platform file path handling
- Follow the DRY (Don't Repeat Yourself) principle
- Write unit tests using pytest or unittest
- Use `if __name__ == "__main__":` for script entry points

### Code Structure
```python
"""
Module description and purpose.
"""

from pathlib import Path
from typing import List, Dict, Optional

import numpy as np
import pandas as pd

# Constants
DATA_DIR = Path("data")
RANDOM_SEED = 42


def process_data(df: pd.DataFrame, threshold: float = 0.5) -> pd.DataFrame:
    """
    Process the input dataframe according to specified criteria.
    
    Args:
        df: Input dataframe to process
        threshold: Cutoff value for filtering (default: 0.5)
    
    Returns:
        Processed dataframe
    """
    return df[df['value'] > threshold].copy()


if __name__ == "__main__":
    # Main execution code
    pass
```

## SAS Programming

### Style Guidelines
- Use uppercase for SAS keywords (DATA, PROC, RUN, etc.)
- Use lowercase for variable names and dataset names
- Indent code blocks consistently (typically 2-4 spaces)
- End each step with RUN, QUIT, or semicolon as appropriate
- Use meaningful dataset and variable names

### Best Practices
- Include header comments with program name, author, date, and purpose
- Use libname statements to define library references
- Utilize macro variables for repeated values and paths
- Add comments using `/* */` or `*` to explain logic
- Use DATA step for complex data manipulation, PROC steps for standard operations
- Label variables with descriptive labels using LABEL statement
- Format dates, numbers, and other values appropriately
- Validate data after each major transformation
- Use descriptive log messages with PUT statements
- Close datasets explicitly when appropriate

### Code Structure
```sas
/******************************************************************************
* Program: analysis.sas
* Author: [Name]
* Date: 2026-01-11
* Purpose: Perform data analysis on study data
******************************************************************************/

/* Define library references */
LIBNAME indata "/path/to/input/data";
LIBNAME outdata "/path/to/output/data";

/* Define macro variables */
%LET analysis_date = %SYSFUNC(today(), yymmdd10.);
%LET study_id = STUDY001;

/* Import and prepare data */
DATA work.analysis_data;
    SET indata.raw_data;
    
    /* Data transformations */
    age_group = CASE
        WHEN age < 18 THEN '0-17'
        WHEN age < 65 THEN '18-64'
        ELSE '65+'
    END;
    
    /* Apply labels */
    LABEL
        age_group = 'Age Group Category'
        enrollment_date = 'Date of Enrollment';
    
    /* Apply formats */
    FORMAT enrollment_date yymmdd10.;
RUN;

/* Perform analysis */
PROC FREQ DATA=work.analysis_data;
    TABLES age_group * treatment / CHISQ;
    TITLE "Distribution of Treatment by Age Group";
RUN;

/* Clean up */
PROC DATASETS LIBRARY=work NOLIST;
    DELETE analysis_data;
QUIT;
```

## Git Version Control

### Commit Best Practices
- Write clear, descriptive commit messages
- Use imperative mood in commit messages ("Add feature" not "Added feature")
- Keep commits atomic (one logical change per commit)
- Commit message structure:
  ```
  Short summary (50 chars or less)
  
  Detailed explanation if needed (wrapped at 72 chars)
  - Bullet points for multiple changes
  - Explain why, not just what
  ```

### Workflow Guidelines
- Always create a verbose and descriptive commit messages that reflect the changes made
- Pull/fetch regularly to stay up-to-date with remote changes
- Create feature branches for new work (`git checkout -b feature/feature-name`)
- Review changes before committing (`git diff`, `git status`)
- Don't commit sensitive data (credentials, API keys, PHI/PII)
- Use `.gitignore` to exclude temporary files, logs, and data files
- Push commits regularly to backup work
- Write meaningful branch names that describe the purpose

### Common Git Commands
```bash
# Check status
git status

# Stage changes
git add <file>
git add .  # Add all changes

# Commit changes
git commit -m "Descriptive message"

# Push to remote
git push origin <branch-name>

# Pull latest changes
git pull origin main

# Create and switch to new branch
git checkout -b feature/new-feature

# View commit history
git log --oneline

# Discard local changes
git checkout -- <file>
```

### Files to Ignore (add to .gitignore)
```
# R
.Rhistory
.RData
.Rproj.user/
*.Rproj

# Python
__pycache__/
*.pyc
*.pyo
.venv/
venv/
*.egg-info/
.pytest_cache/

# SAS
*.log
*.lst

# Data files (be cautious with data)
*.csv
*.xlsx
*.sas7bdat
data/

# System files
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/
```

## Data Security and Privacy

- **Never commit sensitive data** including:
  - Protected Health Information (PHI)
  - Personally Identifiable Information (PII)
  - Passwords, API keys, tokens
  - Database connection strings with credentials
- Use environment variables or config files (not tracked in Git) for sensitive information
- Review diffs carefully before committing to catch accidental data inclusion
- Use data dictionaries and synthetic/mock data for development

## Documentation

- Maintain a README.md file in each project explaining:
  - Project purpose
  - Setup instructions
  - Dependencies and requirements
  - How to run the code
  - Contact information
- Document data sources and transformations
- Keep documentation up-to-date as code evolves
