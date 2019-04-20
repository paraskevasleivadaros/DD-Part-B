-- 3

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

-- 4b ������� ��� ������ ���� ��� �������:
-- If your order by is set to a value that has MORE then one result, 
-- then the top 1 row thus has more then one (date) value that meets this criteria.
-- Source: https://stackoverflow.com/questions/28777098/why-does-this-select-top-1-query-return-more-than-one-result

SELECT staffName, staffSurname, COUNT(Booking.staffNo) AS TotalBookings
FROM Staff, Booking
WHERE Staff.staffNo = Booking.staffNo
GROUP BY staffName, staffSurname
ORDER BY TotalBookings DESC;

-- 4c 

SELECT COUNT(Booking.bookCode) AS CategoryABookings
FROM Rental, Category, Emplacement, Camping, Booking 
WHERE Category.catCode='A' AND Category.catCode = Emplacement.catCode AND Emplacement.campCode = Camping.campCode AND Rental.bookCode = Booking.bookCode;

-- 4d 

SELECT custSurname, custName, COUNT(Booking.custCode) AS Year2000Bookings
FROM Customer LEFT JOIN Booking
ON Customer.custCode = Booking.custCode
WHERE  bookDt BETWEEN '2000-01-01' AND '2000-12-31'
GROUP BY custSurname, custName
ORDER BY custSurname;

-- 4d ������� ��� ������ ���� ��� �������:
SELECT DISTINCT Customer.custName, Booking.bookDt
FROM Customer, Booking, Rental, Emplacement, Camping
WHERE Customer.custCode = Booking.custCode AND bookDt BETWEEN '2000-01-01' AND '2000-12-31' AND Booking.bookCode = Rental.bookCode AND Emplacement.campCode = Camping.campCode
GROUP BY Booking.bookDt, Customer.custName
ORDER BY Booking.bookDt, Customer.custName;

-- 4e

SELECT Camping.campName, SUM(Category.unitCost * (DATEDIFF(DAY, Rental.startDt, Rental.endDt)+1) * noPers) AS TotalProfits
FROM Camping, Emplacement, Rental, Category
WHERE Camping.campCode = Emplacement.campCode AND Category.catCode = Emplacement.catCode AND Rental.campCode = Emplacement.campCode AND Rental.empNo = Emplacement.empNo
GROUP BY Camping.campName
ORDER BY Camping.campName

-- 5

