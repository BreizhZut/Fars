test_that("make_filename return a well formatted filename",{
    expect_warning(make_filename("toto"))
    expect_match(make_filename(1234),"^accident_[0-9]{4}.csv.bz2$")
    expect_match(make_filename("1234"),"^accident_[0-9]{4}.csv.bz2$")
})
