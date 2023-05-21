-- Data Cleaning in SQL

SELECT *
FROM NashvilleHousing

-- Standarize Date Format
SELECT SaleDate, CONVERT(Date,SaleDate)
From NashvilleHousing

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)

------------------------------------------------------

-- Property Adress Data
Select *
From NashvilleHousing
-- WHERE PropertyAddress is null
ORDER by ParcelID

-- ParcelID is linked to Property Address. Use it to populate null Property Address
Select A.ParcelID, A.PropertyAddress, B.ParcelID, B.PropertyAddress
From NashvilleHousing A
JOIN NashvilleHousing B
	ON  A.ParcelID = B.ParcelID
	AND A.[UniqueID ] <> B.[UniqueID ]
WHERE A.PropertyAddress is NULL

UPDATE A
SET PropertyAddress = ISNULL (A.PropertyAddress,B.PropertyAddress)
From NashvilleHousing A
JOIN NashvilleHousing B
	ON  A.ParcelID = B.ParcelID
	AND A.[UniqueID ] <> B.[UniqueID ]
WHERE A.PropertyAddress is NULL

------------------------------------------------------

-- Breaking Property Address into individual columns (Address, City, State)

SELECT PropertyAddress
FROM NashvilleHousing

-- Extract the Street name using "," as delimiter
 SELECT
 SUBSTRING (PropertyAddress, 1, CHARINDEX(',',PropertyAddress) - 1) as Address
 , SUBSTRING (PropertyAddress, CHARINDEX(',',PropertyAddress) + 1 , LEN(PropertyAddress)) as Address
 FROM NashvilleHousing

ALTER TABLE NashVilleHousing
ADD PropertySplitAddress Nvarchar(255);

UPDATE NashvilleHousing
SET PropertySplitAddress =  SUBSTRING (PropertyAddress, 1, CHARINDEX(',',PropertyAddress) - 1)

ALTER TABLE NashVilleHousing
ADD PropertySplitCity Nvarchar(255);

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING (PropertyAddress, CHARINDEX(',',PropertyAddress) + 1 , LEN(PropertyAddress))

------------------------------------------------------

-- Breaking the Owner Address into (Address, City, State)
SELECT OwnerAddress
FROM NashVilleHousing

-- Using PARSENAME to take advantage of the address being split using ","
SELECT
PARSENAME(REPLACE(OwnerAddress,',','.'),1) as State
, PARSENAME(REPLACE(OwnerAddress,',','.'),2) as City
, PARSENAME(REPLACE(OwnerAddress,',','.'),3) as Address
FROM NashVilleHousing

ALTER TABLE NashVilleHousing
ADD OwnerSplitAddress Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSplitAddress =  PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALTER TABLE NashVilleHousing
ADD OwnerSplitCity Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSplitCity =  PARSENAME(REPLACE(OwnerAddress,',','.'),2)

ALTER TABLE NashVilleHousing
ADD OwnerSplitState Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSplitState =  PARSENAME(REPLACE(OwnerAddress,',','.'),1)

------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(SoldAsVacant), count(SoldAsVacant)
From NashvilleHousing
group by SoldAsVacant
Order by 2

Select SoldAsVacant
, CASE 
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END
FROM NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE 
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END
FROM NashvilleHousing

------------------------------------------------------

-- Remove Duplicates

-- Assign groups to duplicates
WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
		PARTITION BY 
			ParcelID,
			PropertyAddress,
			SaleDate,
			LegalReference
			ORDER BY
				UniqueID
				) row_num
FROM NashvilleHousing
)

DELETE 
FROM RowNumCTE
WHERE row_num > 1


------------------------------------------------------

-- Remove Duplicates

SELECT *
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate