fars_path <- file.path("..","data")

test_that("Missing files raise warning in fars_read_years",{
    expect_warning(fars_read_years(2012:2013))
    expect_warning(fars_read_years(2012:2013,fars_path))
})

test_that("Return values in fars_read_years",{
    years <- 2013:2015
    expect_equal(length(fars_read_years(years,fars_path)),length(years))
    expect(is.null(expect_warning(fars_read_years(2012:2013,fars_path)[[1]])),failure_message = "List element should be null")
    expect(!is.null(expect_warning(fars_read_years(2012:2013,fars_path)[[2]])),failure_message = "List element should not be null")
})

test_that("Columns are years fars_summearize_years",{
    years <- 2013:2015
    expect(all(as.character(years) %in% names(fars_summarize_years(years,fars_path))))
})
