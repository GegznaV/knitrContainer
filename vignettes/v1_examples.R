## ----options1, echo = FALSE, message = FALSE, warning = FALSE------------
knitr::opts_chunk$set(collapse = TRUE,
                      comment = "#>",
                      tidy  = TRUE,
                      fig.align = 'center')
optDEF <- knitr::opts_chunk$get()

## ----Install package, eval=FALSE-----------------------------------------
#  library(devtools)
#  install_github("GegznaV/knitrContainer")

## ---- eval = FALSE-------------------------------------------------------
#  library(knitrContainer)

## ---- eval = FALSE-------------------------------------------------------
#  container <- knitrContainer()
#  container <- add_as_text(container, "Text to be added.")
#  print_all(container)

## ---- eval = FALSE-------------------------------------------------------
#  container %<>% add_as_text("Text added using `%<>%` operator.")

## ---- eval = FALSE-------------------------------------------------------
#  container <- add_as_text(container, "Text added using `<-` operator.")

## ---- eval = FALSE-------------------------------------------------------
#  ?`%<>%`

## ----Load main package, message = FALSE, warning = FALSE-----------------
library(knitrContainer)

library(ggplot2)
library(plotly)

## ------------------------------------------------------------------------
plotly_obj <- plot_ly(CO2, x = ~conc, y = ~uptake,
                       type = "box", showlegend = FALSE)

ggplot_obj <- qplot(mpg, wt, data = mtcars, colour = cyl)

## ------------------------------------------------------------------------
container <- knitrContainer()
class(container)
container

## ------------------------------------------------------------------------
# Section headings
container <- add_as_heading1(container, "Plots")

# Add `plotly` objects as `htmlwidgets`
container <- add_as_heading2(container, "Add `plotly` as `plotly htmlwidget`")
container <- add_as_plotly_widget(container, plotly_obj)

# Add `ggplot` objects as plotly `htmlwidgets`
container <- add_as_heading2(container, "Add `ggplot` as `plotly htmlwidget`")
container <- add_as_plotly_widget(container, ggplot_obj)

# Add `ggplot` objects as `ggplot` objects
container <- add_as_heading2(container, "Add `ggplot` as-is")
container <- add_as_is(container, ggplot_obj)

# If `plotly` objects are aded as-is, they might not be plotted
container <- add_as_heading1(container, "Attention: Not Plotted")
container <- add_as_is(container, plotly_obj)
container <- add_as_text(container, paste("As you noticed, the last",  
      "`plotly` object was not plotted as it was added with ",  
      "`add_as_is()` and not with `add_as_plotly_widget()`"))

# --- Calculations ---
SUMMARY <- summary(mtcars[1:4])

# --- Add `pander` tables ---
container <- add_as_heading1(container, "Print SUMMARY as pander table and as text")

# Add objects, printed as `pander` tables
container <- add_as_heading2(container, "As pander table")
container <- add_as_pander(container, SUMMARY)

# Add as R output text
container <- add_as_heading2(container, "As Code/ Output Text")

container <- add_as_text(container, "Not highlighted")
container <- add_as_code(container, SUMMARY)

container <- add_as_text(container, "Highlighted as R code")
container <- add_as_code_r(container, SUMMARY)

container <- add_as_text(container, "Output with default `knitr` comments")
container <- add_as_output(container, SUMMARY)

container <- add_as_text(container, "Output with custom comments")
container <- add_as_output(container, SUMMARY, comment = "#$#>")

# Add as text = Add as one paragraph
container <- add_as_heading2(container, "As text/paragraph")
container <- add_as_text(container, SUMMARY)

# Add as-is
container <- add_as_heading2(container, "As is")
container <- add_as_is(container, SUMMARY)

## ------------------------------------------------------------------------
print(container)

is.knitrContainer(container) 
is.knitrContainer(ggplot_obj)

as.knitrContainer(ggplot_obj) 

class(container)

## ------------------------------------------------------------------------
Join(container, container)   %>% length()

## ------------------------------------------------------------------------
Join(container, ggplot_obj)   %>% length()

## ------------------------------------------------------------------------
Join(ggplot_obj, plotly_obj)

## ---- results = 'asis'---------------------------------------------------
print_all(container)

## ------------------------------------------------------------------------
container2 <- knitrContainer()
# Add as data and add as code to evaluate 

# Add as data
container2 %<>% add_as_text(
    "Add `mtcars` as data (it will not be printed) and rename it to 'cars_data'.")
container2 %<>% add_as_data(mtcars, give.name = "cars_data")

# Add as code to evaluate
container2 %<>% add_as_text(
    c("Use `add_as_cmd` to add unquoted code which manipulates the dataset ",
      "'cars_data', e.g. prints its variable names or plots it."))
container2 %<>% add_as_cmd(print(names(cars_data[1:3])))
container2 %<>% add_as_cmd(plot(cars_data[1:3]))

## ---- results = 'asis'---------------------------------------------------
print_all(container2)

## ----session info--------------------------------------------------------
devtools::session_info()

