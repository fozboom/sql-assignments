select "CurrencyRateDate",
    abs("AverageRate" - lag("AverageRate") over (order by "CurrencyRateDate")) as rate_change
from currencyrate
where "ToCurrencyCode" = 'CAD'
order by rate_change desc
limit 2
