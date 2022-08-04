
Select a1.ProductKey, sum(a1.OrderQuantity) as number_of_order
From (Select *
From sale_2015
Union (
	select *
	From sale_2016)
	) as a1
Group by a1.ProductKey
Order by a1.ProductKey

Select r.ProductKey, sum(r.ReturnQuantity) as number_of_return
From return_table r
Group by r.ProductKey
Order by r.ProductKey;


With abc1 as (

Select p.ProductKey, round((r.number_of_return/p.number_of_order)*100,2) as return_rate
From (Select a1.ProductKey, sum(a1.OrderQuantity) as number_of_order
From (Select *
From sale_2015
Union (
	select *
	From sale_2016)
	) as a1
Group by a1.ProductKey) p
Left join (
Select r.ProductKey, sum(r.ReturnQuantity) as number_of_return
From return_table r
Group by r.ProductKey) r
on p.ProductKey = r.ProductKey

)

select ProductName, return_rate
From abc1
Left join product d
on abc1.ProductKey = d.ProductKey
Where return_rate is not null





