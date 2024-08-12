library(quarto)
library(stringr)

grades <- read.csv("grades.csv")

# Grade reports for each student
n_students <- length(grades$name)
for (i in 1:2) {
  student_name <- str_to_lower(str_replace(grades$name[i], " ", "-"))
  quarto_render("grade-report.qmd",
                output_file = paste0(student_name, "-grade-report.docx"),
                execute_params = list(student = grades$name[i]))
}
