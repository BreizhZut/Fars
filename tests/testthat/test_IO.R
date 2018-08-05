test_that("make_filename return a well formatted filename",{
    expect_warning(make_filename("toto"))
    expect_match(make_filename(1234),"^accident_[0-9]{4}.csv.bz2$")
    expect_match(make_filename("1234"),"^accident_[0-9]{4}.csv.bz2$")
})

fars_path <- file.path("..","data")

test_that("files are present in the package",{
    fars_path <- file.path("..","data")
    files <- c("accident_2013.csv.bz2","accident_2014.csv.bz2","accident_2015.csv.bz2")
    expect(file.exists(fars_path))
    expect_equal(files,list.files(fars_path))
})

file2012 <- make_filename(2012)
file2013 <- make_filename(2013)
file2014 <- make_filename(2014)
file2015 <- make_filename(2015)

test_that("read_fars functions if file name exist", {
    expected_columns <- c('MONTH','YEAR','STATE','LATITUDE','LONGITUD')
    expect_error(fars_read(file2012,fars_path=fars_path))
    expect(all(expected_columns %in% names(fars_read(file2013,fars_path))))
    expect(all(expected_columns %in% names(fars_read(file2014,fars_path))))
    expect(all(expected_columns %in% names(fars_read(file2015,fars_path))))
})
