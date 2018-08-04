#' Reads a Fatality Analysis Reporting System dataset
#'
#' Reads a dataset from the US National Highway Traffic Safety Administration's Fatality Analysis Reporting System,
#' which is a nationwide census providing the American public yearly data regarding fatal injuries suffered in motor vehicle traffic crashes.
#'
#' @usage fars_read(filename)
#'
#' @param filename character string corresponding to the path of the file
#'
#' @return data frame tbl
#'
#'
#' @importFrom readr read_csv
#' @importFrom dplyr tbl_df
#'
#' @note stop the execution and print an error message if the file does not exists
#'
#' @examples
#' \dontrun{
#' data2013 <- fars_read("fars_data/data/accident_2013.csv.bz2")
#' }
#'
#' @export
fars_read <- function(filename) {
        if(!file.exists(filename))
                stop("file '", filename, "' does not exist")
        data <- suppressMessages({
                readr::read_csv(filename, progress = FALSE)
        })
        dplyr::tbl_df(data)
}

#' Build accident files names
#'
#' Create a charactor string from the year matching the Fatality Analysis Reporting System naming convention
#'
#' @usage make_filename(year,path)
#'
#' @param year year selected for the dataset, can be numeric, integer or charactor
#' @param path directory containing the Fars data set to "data" by default
#'
#' @return character string corresponding to a formatted file name
#'
#' @note
#' \itemize{
#' \item user should enter a valid 4 digit value either as numeric or character
#' \item using a boolean for year would produce "accident_0.csv.bz2" or "accident_1.csv.bz2"
#' \item using alphabetical character would produce an error
#' }
#'
#' @examples
#' filename <- make_filename(2013)
#' filename <- make_filename(2013L)
#' filename <- make_filename("2013")
#' filepath <- file.path("data",make_filename(2013))
#'
#' @export
make_filename <- function(year,path="data") {
        year <- as.integer(year)
        file.path(path,sprintf("accident_%d.csv.bz2", year))
}


#' Read years from a list of Fatality Analysis Reporting System
#'
#' This function generates lists of a projection of the data along the column month and year.
#' filtered by the year as written in the file name.
#'
#' @usage fars_read_years(years,path)
#'
#' @param years a list of values corresponding to year
#' @param path directory containing the Fars data set to "data" by default
#'
#' @return a list of dat frame tbl with MONTH and year columns
#'
#' @importMethodsFrom dplyr mutate select
#' @importFrom magrittr %>%
#'
#' @note
#' \itemize{
#' \item file names are generated with the \code{make_filename} function
#' \item require to be run from the directory containing the data
#' \item each list element may contain duplicated month year tuple
#' }
#'
#' @examples
#' \dontrun{
#' # need to be in the same directory as the data
#' setwd("data")
#' # with one year
#' fars_read_years(2013)
#' # with multiple years
#' fars_read_years(2013:2015)
#' # with characters
#' fars_read_years(c("2013","2015"))
#' }
#'
#' @seealso fars_read
#' @seealso make_filename
#'
#' @export
fars_read_years <- function(years,path="data") {
        lapply(years, function(year) {
                file <- make_filename(year,path)
                tryCatch({
                        dat <- fars_read(file)
                        dplyr::mutate(dat, year = year) %>%
                                dplyr::select('MONTH', year)
                }, error = function(e) {
                        warning("invalid year: ", year)
                        return(NULL)
                })
        })
}

#' Count the number of accidents per month
#'
#' Using a list of years as input, this function reads the collect the available data in the
#' Fatality Analysis Reporting System dataset. It then counts the number of accident per month.
#'
#' @usage fars_summarize_years(years, path)
#'
#' @param years a list of values corresponding to year
#' @param path directory containing the Fars data set to "data" by default
#' @return a data frame table with columns
#' \itemize{
#' \item \code{month} : month number
#' \item \code{year} : four digit year
#' \item \code{n} : the number of corresponding rows in the dataset interpreted as the number of accidents
#' }
#'
#'
#' @details Uses \code{fars_read_years} then transforms the list into a data.frame.
#' The data is aggregated by the MONTH and year columns and summerize with the count \code{n()} function.
#'
#' @importMethodsFrom dplyr bind group_by summarize n
#' @importFrom tidyr spread
#' @importFrom magrittr %>%
#' @note
#' \itemize{
#' \item only years present in the dataset will be represented
#' \item this function require to run from the directory contianing the datasets
#' }
#'
#' @examples
#' \dontrun{
#' # need to be in the same directory as the data
#' setwd("data")
#' # with one year
#' fars_summarize_years(2013)
#' # with multiple years
#' fars_summarize_years(2013:2015)
#' # with characters
#' fars_summarize_years(c("2013","2015"))
#' }
#'
#' @seealso fars_read_years
#'
#' @export
fars_summarize_years <- function(years,path="data") {
        dat_list <- fars_read_years(years,path)
        dplyr::bind_rows(dat_list) %>%
            dplyr::group_by(year, MONTH) %>%
            dplyr::summarize(n = dplyr::n()) %>%
            tidyr::spread('year', 'n')
}

#' Map the accident for a specific year accross a state
#'
#' Match a state number and year to the Fatality Analysis Reporting System dataset.
#' And produce a scatter plot of incident within a map af the state
#'
#' @usage fars_map_state(state.num, year,path)
#'
#' @param state.num number identifying a statse in US character, integer or  numeric
#' @param year 4 digit year character, integer or  numeric
#' @param path directory containing the Fars data set to "data" by default
#'
#' @return a map object
#'
#' @importFrom dplyr filter
#' @importFrom maps map
#' @importFrom graphics points
#'
#' @note
#' \itemize{
#' \item both arguments should only include digits otherwise the program will stop with an error
#' \item if the state number is absent from the file an error is produced
#' }
#'
#' @examples
#' \dontrun{
#' # need to be in the same directory as the data
#' setwd("data")
#' my_map <- fars_map_state(1,2013)
#' }
#'
#' @seealso make_filename
#' @seealso fars_read
#'
#' @export
fars_map_state <- function(state.num, year,path=path) {
        filename <- make_filename(year,path)
        data <- fars_read(filename)
        state.num <- as.integer(state.num)

        if(!(state.num %in% unique(data$STATE)))
                stop("invalid STATE number: ", state.num)
        data.sub <- dplyr::filter(data, 'STATE' == state.num)
        if(nrow(data.sub) == 0L) {
                message("no accidents to plot")
                return(invisible(NULL))
        }
        is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
        is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
        with(data.sub, {
                maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
                          xlim = range(LONGITUD, na.rm = TRUE))
                graphics::points(LONGITUD, LATITUDE, pch = 46)
        })
}
