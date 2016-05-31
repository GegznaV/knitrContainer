## ----options1, echo = FALSE, message = FALSE, warning = FALSE------------
knitr::opts_chunk$set(collapse = TRUE,
                      comment = "#>",
                      fig.align = 'center')
optDEF <- knitr::opts_chunk$get()

## ---- eval = FALSE-------------------------------------------------------
#  library(knitrContainer)
#  
#  container <- knitrContainer()
#  container <- add_as_text(container, "Text to be added.")
#  print_objects(container)

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
plotly_obj <- plot_ly(economics, x = date, y = uempmed, type = "scatter",
             showlegend = FALSE)

ggplot_obj <- qplot(mpg, wt, data = mtcars, colour = cyl)

## ------------------------------------------------------------------------
container <- knitrContainer()
class(container)
container

## ------------------------------------------------------------------------
# Section headings
container <- add_as_section(container, "Plots")

# Add `plotly` objects as `htmlwidgets`
container <- add_as_section(container, "Add `plotly`", level = 2)
container <- add_as_plotly_widget(container, plotly_obj)

# Add `ggplot` objects as plotly `htmlwidgets`
container <- add_as_section(container, "Add `ggplot` as `plotly`", level = 2)
container <- add_as_plotly_widget(container, ggplot_obj)

# Add `ggplot` objects as `ggplot` objects
container <- add_as_section(container, "Add `ggplot`", level = 2)
container <- add_as_is(container, ggplot_obj)

# If `plotly` objects are aded as-is, they might not be plotted
container <- add_as_section(container, "Attention: Not Plotted", level = 1)
container <- add_as_is(container, plotly_obj)
container <- add_as_text(container, paste("As you noticed, the last",
      "`plotly` object was not plotted as it was added with ",
      "`add_as_is()` and not with `add_as_plotly_widget()`"))

# --- Add `pander` tables ---
container <- add_as_section(container, "Pander and text", level = 1)

# Add objects, printed as `pander` tables
container <- add_as_section(container, "As pander", level = 2)
container <- add_as_pander(container, summary(mtcars))

# Add as text
container <- add_as_section(container, "As text", level = 2)
container <- add_as_text(container, summary(mtcars))

# Add as-is
container <- add_as_section(container, "As is", level = 2)
container <- add_as_is(container, summary(mtcars))


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
print_objects(container)

## ----session info--------------------------------------------------------
devtools::session_info()

