/* Data Cleaning in SQL Query

*/




select * 
from PortfolioProject..NashvilleHousing

----Standardize Date Format

select saledate 
from PortfolioProject..NashvilleHousing

select saledate, convert(Date,saledate)
from PortfolioProject..NashvilleHousing

select sale, convert(Date,saledate)
from PortfolioProject..NashvilleHousing


SELECT Saledate, CONVERT(DATE, SaleDate) AS SaleDateconverted
FROM PortfolioProject..NashvilleHousing;



update NashvilleHousing
set SaleDate = CONVERT(date,SaleDate)

alter table Nashnillehousing
add saledateconverted Date;

alter table Nashnillehousing
add saledateconverted Date;


----populate propert address data 
select * 
from PortfolioProject..NashvilleHousing
--where PropertyAddress is null
order by ParcelID


select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress
from PortfolioProject..NashvilleHousing a
join PortfolioProject..NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null


update a
set PropertyAddress = ISNULL(a.Propertyaddress,b.propertyaddress)
from PortfolioProject..NashvilleHousing a
join PortfolioProject..NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null


-----------------------------------------------------------------------

----Breaking out address into individual columns (Address,City,State)
select propertyaddress
from PortfolioProject..NashvilleHousing
--where PropertyAddress is null
--order by ParcelID

select 
SUBSTRING (propertyaddress,1,Charindex(',',Propertyaddress) -1) as address
,SUBSTRING(propertyaddress, charindex (',',Propertyaddress)+1,LEN (Propertyaddress)) as  address

from PortfolioProject..nashvillehousing

alter table NashvilleHousing
add PropertySplitAddress Nvarchar(255);

update NashvilleHousing
set PropertySplitAddress = SUBSTRING (propertyaddress,1,Charindex(',',Propertyaddress) -1)

alter table NashvilleHousing
add propertySplitCity Nvarchar(255);

update NashvilleHousing
set propertySplitCity = SUBSTRING(propertyaddress, charindex (',',Propertyaddress)+1,LEN (Propertyaddress))

select *
from PortfolioProject..NashvilleHousing

-------------------------------------------------------------------------------
----change Y and N to Yes and No in "Sold as Vacant" field

select Distinct(SoldAsVacant), Count(SoldAsVacant)
from PortfolioProject..NashvilleHousing
group by SoldAsVacant
order by 2

select SoldAsVacant
,case when SoldAsVacant = 'Y' then 'Yes'
		when SoldAsVacant = 'N' then 'No'
		Else SoldAsVacant
		End
from PortfolioProject..NashvilleHousing


update NashvilleHousing
set SoldAsVacant = case when SoldAsVacant = 'Y'then  'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
	End

---------------------------------------------------------------------------
-- Remove Duplicates
-- CTE 
/*Common Table Expression (CTE) is a temporary result 
set in SQL that can be referenced in other parts of a query.
CTEs are defined using the WITH keyword and are also known as WITH queries. 
*/

With RowNumCTE AS(
select *,
	ROW_NUMBER() over (
	PARTITION BY ParcelID,
	PropertyAddress,
	SalePrice,
	LegalReference
	order by
		UniqueID
		)row_num

from PortfolioProject..NashvilleHousing
--order by ParcelID
)

select *
from RowNumCTE
where row_num>1
order by PropertyAddress

-------------------------------------------------------
-- Delete Unused Columns

select *
from PortfolioProject..NashvilleHousing

ALTER TABLE portfolioProject..Nashvillehousing
DROP column OwnerAddress,TaxDistrict,PropertyAddress

Alter Table PortfolioProject..NashvilleHousing
Drop Column SaleDate























































 
























































