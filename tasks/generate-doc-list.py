"""
Given: tickers-looked-up.csv


Query data/sqlcake/mandex.sqlite by CIK
    to extract a list of all documents for a given CIK

select * from mandex where cik = LTRIM('0001689923', '0')

"""
