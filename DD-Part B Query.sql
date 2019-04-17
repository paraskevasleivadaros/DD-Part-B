INSERT INTO Staff (staffNo, staffName, staffSurname)
SELECT DISTINCT (staffNo), staffName, staffSurname
FROM MainTable;

INSERT INTO Payment (payCode, payMethod)
SELECT DISTINCT (payCode), payMethod
FROM MainTable;

INSERT INTO Customer (custCode, custName, custSurname, custPhone)
SELECT DISTINCT (custCode), custName, custSurname, custPhone
FROM MainTable;

INSERT INTO Booking (bookCode, bookDt, payCode, custCode, staffNo)
SELECT DISTINCT (bookCode), bookDt, payCode, custCode, staffNo
FROM MainTable;

INSERT INTO Camping (campCode, campName, numOfEmp)
SELECT DISTINCT (campCode), campName, numOfEmp
FROM MainTable;

INSERT INTO Category (catCode, areaM2, unitCost)
SELECT DISTINCT (catCode), areaM2, unitCost
FROM MainTable;

INSERT INTO Emplacement (campCode, empNo, catCode)
SELECT DISTINCT (campCode), (empNo), catCode
FROM MainTable;

INSERT INTO Rental (bookCode, campCode, empNo, startDt, endDt, noPers)
SELECT DISTINCT (bookCode), (campCode), (empNo), (startDt), endDt, noPers
FROM MainTable;

-- 4a

SELECT COUNT(bookCode)
FROM Payment, Booking
WHERE Payment.payCode = Booking.payCode
GROUP BY payMethod;

-- 4b

SELECT TOP 1 staffName, staffSurname, COUNT(Booking.staffNo) AS TotalBookings
FROM Staff, Booking
WHERE Staff.staffNo = Booking.staffNo
GROUP BY staffName, staffSurname
ORDER BY TotalBookings DESC;

-- 4b ΕΛΕΓΧΟΣ ΠΩΣ ΙΣΧΥΕΙ ΑΥΤΟ ΠΟΥ ΓΡΑΨΑΜΕ:
-- If your order by is set to a value that has MORE then one result, 
-- then the top 1 row thus has more then one (date) value that meets this criteria.
-- Source: https://stackoverflow.com/questions/28777098/why-does-this-select-top-1-query-return-more-than-one-result

SELECT staffName, staffSurname, COUNT(Booking.staffNo) AS TotalBookings
FROM Staff, Booking
WHERE Staff.staffNo = Booking.staffNo
GROUP BY staffName, staffSurname
ORDER BY TotalBookings DESC;

-- 4c Δεν είμαι σίγουρος

SELECT COUNT(Booking.bookCode)
FROM Rental, Category, Emplacement, Camping, Booking 
WHERE Category.catCode='A' AND Category.catCode=Emplacement.catCode AND Emplacement.campCode=Camping.campCode AND Rental.bookCode=Booking.bookCode;

-- 4d Δεν είμαι σίγουρος

SELECT custSurname, custName, COUNT(Booking.custCode) AS TotalBookings
FROM Customer, Booking
WHERE Customer.custCode=Booking.custCode AND bookDt='2000'
GROUP BY custSurname, custName
ORDER BY custSurname;

-- 4e

