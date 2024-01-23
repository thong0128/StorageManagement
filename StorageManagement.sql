create database StorageManagement;
use StorageManagement;

create table Materials(
Id int auto_increment primary key,
Material_Code varchar(255) unique,
Name varchar(255),
Unit varchar(255),
Price int
);

create table Stock(
Id int auto_increment primary key,
Materials_Id int,
Initial_Quantity int,
Total_Import_Quantity int,
Total_Export_Quantity int,
Foreign key(Materials_Id) references Materials(id)
);

create table Suppliers(
Id int auto_increment primary key,
Supplier_Code varchar(255) unique,
Name varchar(255),
Address varchar(255),
Phone varchar(11)
);

create table Orders(
Id int auto_increment primary key,
Order_Code varchar(255) unique,
Order_Date Date,
Supplier_Id int,
Foreign key(Supplier_Id) references Suppliers(id)
);

create table Goods_Received_Note(
Id int auto_increment primary key,
GRN_Code varchar(255) unique,
GRN_Date date,
Order_Id int,
foreign key(Order_id) references Orders(id)
);

create table Goods_Despatched_Note(
Id int auto_increment primary key,
GDN_Code varchar(255) unique,
GDN_Date date,
Customer_Name varchar(255)
);

create table Order_Detail(
Id int auto_increment primary key,
Order_Id int,
Material_Id int,
Quantity int,
foreign key(Order_Id) references Orders(id),
foreign key(Material_id) references Materials(id)
);

create table GRN_Detail(
Id int auto_increment primary key,
GRN_Id int,
Material_Id int,
Quantity int,
Price int,
Note varchar(255),
foreign key(GRN_Id) references goods_received_note(id),
foreign key(Material_Id) references Materials(id)
);

create table GDN_Detail(
Id int auto_increment primary key,
GDN_Id int,
Material_Id int,
Quantity int,
Price int,
Note varchar(255),
foreign key(GDN_Id) references goods_despatched_note(id),
foreign key(Material_Id) references Materials(id)
);

insert into Materials 
(Material_Code, Name, Unit, Price)
values
('cmk2xal6wl', 'Steel', 'Kg', 10000),
('h9bh1koydz', 'Wood', 'Kg', 5000),
('mnqwmiro6u', 'Aluminium', 'Kg', 80000),
('bo8onw36mx', 'Copper', 'Kg', 15000),
('pzgmu8npdr', 'Cement', 'Bag', 90000);

insert into stock 
(Materials_Id, Initial_Quantity, Total_Import_Quantity, Total_Export_Quantity)
values
(2, 100, 288, 126),
(3, 50, 451, 529),
(5, 200, 822, 649),
(1, 1000, 243, 242),
(1, 80, 901, 505);

insert into suppliers
(Supplier_Code, Name, Address, Phone)
values
('VHMPU5F3R7', 'Green Tech', 'Ho Chi Minh', '0972699926'),
('X09Z9N4618', 'Dong Son', 'Ha Noi', '0945017758'),
('079R4C6AUP', 'Hung Xuan Phat', 'Dong Nai', '0969118889');

insert into orders
(Order_Code, Order_Date, Supplier_Id)
values
('MP2WUE2XjV', '2020-03-25', 1),
('6tYMLVOFqv', '2020-08-31', 2),
('JmrIk51ovF', '2022-03-12', 3);

insert into goods_received_note
(GRN_Code, GRN_Date, Order_Id)
values
('evt9ypGQcE', '2020-04-17', 1),
('bqSRv5bOew', '2023-12-03', 1),
('rHkvl65oYT', '2024-01-30', 3);

insert into goods_despatched_note
(GDN_Code, GDN_Date, Customer_Name)
values
('aGt6GJLpzZ', '2021-09-06', 'Phung Lam Truong'),
('md8ynvhucC', '2023-11-23', 'Ngo Trung Thanh'),
('oIm9MtFUBi', '2023-11-30', 'Bui Minh Toan');

insert into order_detail
(Order_Id, Material_Id, Quantity)
values
(2, 3, 633),
(2, 3, 31),
(3, 2, 531),
(1, 2, 706),
(1, 3, 641),
(1, 2, 22);

insert into grn_detail
(GRN_Id, Material_Id, Quantity, Price, Note)
values
(3, 1, 59, 74182, 'JSxLEsMDqgtAVNwEpGex'),
(3, 1, 247, 41311, 'WdXxAoMonCoBoCDDlScO'),
(2, 1, 878, 72440, 'gzzYBOPsmvbnTuLksHBG'),
(2, 3, 716, 19906, 'iFpxgbKXVigmLjiJZCzS'),
(3, 2, 191, 43807, 'wdUiHepWSAtDdTAWDzqU'),
(1, 2, 159, 12251, 'HHSsUYkLUNejkySWaYpD');

insert into gdn_detail
(GDN_Id, Material_Id, Quantity, Price, Note)
values
(2, 1, 44, 60535, 'TqtGVsOSMv'),
(3, 1, 746, 43768, 'iiUPUfQBNh'),
(3, 1, 43, 12101, 'sXtgCUSMKn'),
(2, 1, 827, 74317, 'aMeLdANOEf'),
(2, 3, 813, 48654, 'VKlvjkfIDE'),
(1, 2, 640, 86273, 'xGmpDMRipd');

-- Câu 1.
create view vw_CTPNHAP as
select 
grn.GRN_Code as GRN_Code, 
m.Material_Code as Material_Code, 
grn_d.Quantity as Quantity, 
grn_d.Price as Price,
(grn_d.Quantity * grn_d.Price) as Cost
from goods_received_note as grn 
join grn_detail as grn_d on grn.id = grn_d.GRN_Id
join materials as m on grn_d.Material_Id = m.id;
select * from vw_CTPNHAP;

-- Câu 2. 
create view vw_CTPNHAP_VT as
select 
grn.GRN_Code as GRN_Code, 
m.Material_Code as Material_Code, 
m.Name as Material_Name,
grn_d.Quantity as Quantity, 
grn_d.Price as Price,
(grn_d.Quantity * grn_d.Price) as Cost
from goods_received_note as grn 
join grn_detail as grn_d on grn.id = grn_d.GRN_Id
join materials as m on grn_d.Material_Id = m.id;
select * from vw_CTPNHAP_VT;

-- Câu 3. 
create view vw_CTPNHAP_VT_PN as
select 
grn.GRN_Code as GRN_Code, 
grn.GRN_Date as GRN_Date,
o.Order_Code as Order_Code,
m.Material_Code as Material_Code, 
m.Name as Material_Name,
grn_d.Quantity as Quantity, 
grn_d.Price as Price,
(grn_d.Quantity * grn_d.Price) as Cost
from materials as m
join grn_detail as grn_d on m.id = grn_d.Material_Id
join goods_received_note as grn on grn_d.GRN_Id = grn.id
join orders as o on grn.Order_Id = o.id;
select * from vw_CTPNHAP_VT_PN;

-- Câu 4. 
create view vw_CTPNHAP_VT_PN_DH as
select 
grn.GRN_Code as GRN_Code, 
grn.GRN_Date as GRN_Date,
o.Order_Code as Order_Code,
s.Supplier_Code as Supplier_Code,
m.Material_Code as Material_Code, 
m.Name as Material_Name,
grn_d.Quantity as Quantity, 
grn_d.Price as Price,
(grn_d.Quantity * grn_d.Price) as Cost
from materials as m
join grn_detail as grn_d on m.id = grn_d.Material_Id
join goods_received_note as grn on grn_d.GRN_Id = grn.id
join orders as o on grn.Order_Id = o.id
join suppliers as s on  o.Supplier_Id = s.id;
select * from vw_CTPNHAP_VT_PN_DH;

-- Câu 5. 
create view vw_CTPNHAP_loc as
select 
grn.GRN_Code as GRN_Code, 
m.Material_Code as Material_Code, 
grn_d.Quantity as Quantity, 
grn_d.Price as Price,
(grn_d.Quantity * grn_d.Price) as Cost
from goods_received_note as grn 
join grn_detail as grn_d on grn.id = grn_d.GRN_Id
join materials as m on grn_d.Material_Id = m.id
where Quantity > 5;
select * from vw_CTPNHAP_loc;

-- Câu 6.
create view vw_CTPNHAP_VT_loc as
select 
grn.GRN_Code as GRN_Code, 
m.Material_Code as Material_Code, 
m.Name as Material_Name,
grn_d.Quantity as Quantity, 
grn_d.Price as Price,
(grn_d.Quantity * grn_d.Price) as Cost
from goods_received_note as grn 
join grn_detail as grn_d on grn.id = grn_d.GRN_Id
join materials as m on grn_d.Material_Id = m.id
where m.Unit = 'Set';
select * from vw_CTPNHAP_VT_loc;

-- Câu 7. 
create view vw_CTPXUAT as
select 
gdn.GDN_Code as GDN_Code,
m.Material_Code as Material_Code,
gdn_d.Quantity as Quantity,
gdn_d.Price as Price,
(gdn_d.Quantity * gdn_d.Price) as Cost
from materials as m
join gdn_detail as gdn_d on m.id = gdn_d.Material_Id
join goods_despatched_note as gdn on gdn.id = gdn_d.GDN_Id;
select * from vw_CTPXUAT;

-- Câu 8.
create view vw_CTPXUAT_VT as
select 
gdn.GDN_Code as GDN_Code,
m.Material_Code as Material_Code,
m.name as Material_name,
gdn_d.Quantity as Quantity,
gdn_d.Price as Price
from materials as m
join gdn_detail as gdn_d on m.id = gdn_d.Material_Id
join goods_despatched_note as gdn on gdn.id = gdn_d.GDN_Id;
select * from vw_CTPXUAT_VT;

-- Câu 9. 
create view vw_CTPXUAT_VT_PX as
select 
gdn.GDN_Code as GDN_Code,
gdn.Customer_Name as Customer_Name,
m.Material_Code as Material_Code,
m.name as Material_name,
gdn_d.Quantity as Quantity,
gdn_d.Price as Price
from materials as m
join gdn_detail as gdn_d on m.id = gdn_d.Material_Id
join goods_despatched_note as gdn on gdn.id = gdn_d.GDN_Id;
select * from vw_CTPXUAT_VT_PX;

-- Stored procedure

-- Câu 1. 
DELIMITER //
drop procedure if exists `FinalQuantity`//
CREATE PROCEDURE FinalQuantity(
    MCode varchar(255)
)
BEGIN
	select 
	TotalReceive - TotalDispatch as FinalQuantity
    from
    (select 
    sum(grn_d.Quantity) as TotalReceive,
    sum(gdn_d.Quantity) as TotalDispatch
    from materials as m 
    join gdn_detail as gdn_d on m.id = gdn_d.Material_Id
    join grn_detail as grn_d on m.id = grn_d.Material_Id
    where m.Material_Code = MCode)temp;
    
END //
DELIMITER ;
call FinalQuantity('cmk2xal6wl');

-- Câu 2. Tạo SP cho biết tổng tiền xuất của vật tư với mã vật tư là tham số vào, out là tổng tiền xuất
DELIMITER //
drop procedure if exists `TotalExportMoney`//
CREATE PROCEDURE TotalExportMoney(
   in MCode varchar(255),
   out TotalExportMoney int
)
BEGIN
    select 
    sum(gdn_d.Quantity * gdn_d.Price) into TotalExportMoney
    from grn_detail as gdn_d
    join materials as m on gdn_d.Material_Id = m.id
    where m.Material_Code = MCode;
END //
DELIMITER ;
call TotalExportMoney('cmk2xal6wl', @total);
select @total;

-- Câu 3. 
DELIMITER //
drop procedure if exists `TotalQuantityByOrderCode`//
CREATE PROCEDURE TotalQuantityByOrderCode(
	OCode varchar(255)
)
BEGIN
    select 
    sum(od.Quantity) as TotalQuantity
    from order_detail as od
    join orders as o on od.Order_Id = o.id
    where o.Order_Code = OCode;
END //
DELIMITER ;
call TotalQuantityByOrderCode('MP2WUE2XjV');

-- Câu 4.
DELIMITER //
drop procedure if exists `AddOrder`//
CREATE PROCEDURE AddOrder(
	OCode varchar(255),
    ODate date,
    SId int
)
BEGIN
    insert into orders
    (Order_Code, Order_Date, Supplier_Id)
    values
    (OCode, ODate, Sid);
END //
DELIMITER ;
call AddOrder('asdfasdf','2024-01-01',3);

-- Câu 5. Tạo SP dùng để thêm một chi tiết đơn đặt hàng.
DELIMITER //
drop procedure if exists `AddOrderDetail`//
CREATE PROCEDURE AddOrderDetail(
	OId int,
    MId int,
    Quantity int
)
BEGIN
    insert into order_detail
    (Order_Id, Material_Id, Quantity)
    values
    (OId, MId, Quantity);
END //
DELIMITER ;
call AddOrderDetail(2,4,500);