use BT1CSDL
go

-- 1
select tSach.MaSach, tSach.TenSach from tSach inner join tNhaXuatBan on tSach.MaNXB = tNhaXuatBan.MaNXB where tNhaXuatBan.TenNXB = N'NXB Giáo Dục'

-- 2
select * from tSach where tSach.TenSach like N'Ngày%'

-- 3
select tSach.MaSach, tSach.TenSach from tSach inner join tNhaXuatBan on tSach.MaNXB = tNhaXuatBan.MaNXB 
where tNhaXuatBan.TenNXB = N'NXB Giáo Dục' and tSach.DonGiaBan between 100000 and 150000

-- 4
select tSach.MaSach, tSach.TenSach from tSach inner join tNhaXuatBan on tSach.MaNXB = tNhaXuatBan.MaNXB 
where (tNhaXuatBan.TenNXB = N'NXB Giáo Dục' or tNhaXuatBan.TenNXB = N'NXB Trẻ') and tSach.DonGiaBan between 90000 and 140000

-- 5
select tChiTietHDB.SoHDB, sum(tSach.DonGiaBan * tChiTietHDB.SLBan) as TriGiaHoaDonBan from tSach inner join tChiTietHDB on tSach.MaSach = tChiTietHDB.MaSach
inner join tHoaDonBan on tChiTietHDB.SoHDB = tHoaDonBan.SoHDB where tHoaDonBan.NgayBan = '2014/1/1' or tHoaDonBan.NgayBan = '2014/12/31' group by tChiTietHDB.SoHDB

-- 6
select tChiTietHDB.SoHDB, sum(tSach.DonGiaBan * tChiTietHDB.SLBan) as TriGiaHoaDonBan from tSach inner join tChiTietHDB on tSach.MaSach = tChiTietHDB.MaSach
inner join tHoaDonBan on tChiTietHDB.SoHDB = tHoaDonBan.SoHDB where (MONTH(tHoaDonBan.NgayBan) = 4 and YEAR(tHoaDonBan.NgayBan) = 2014) group by tChiTietHDB.SoHDB, tHoaDonBan.NgayBan
order by tHoaDonBan.NgayBan ASC, TriGiaHoaDonBan DESC

-- 7
select tKhachHang.MaKH, tKhachHang.TenKH from tKhachHang inner join tHoaDonBan on tKhachHang.MaKH = tHoaDonBan.MaKH where tHoaDonBan.NgayBan = '2014/4/10'

-- 8 
select tChiTietHDB.SoHDB, sum(tSach.DonGiaBan * tChiTietHDB.SLBan) as TriGiaHoaDonBan from tSach inner join tChiTietHDB on tSach.MaSach = tChiTietHDB.MaSach
inner join tHoaDonBan on tChiTietHDB.SoHDB = tHoaDonBan.SoHDB
inner join tNhanVien on tHoaDonBan.MaNV = tNhanVien.MaNV 
where tNhanVien.TenNV = N'Trần Huy' and tHoaDonBan.NgayBan = '2014/8/11' group by tChiTietHDB.SoHDB

-- 9
select tSach.MaSach, tSach.TenSach from tSach inner join tChiTietHDB on tSach.MaSach = tChiTietHDB.MaSach
		inner join tHoaDonBan on tChiTietHDB.SoHDB = tHoaDonBan.SoHDB
		inner join tKhachHang on tHoaDonBan.MaKH = tKhachHang.MaKH
		where tKhachHang.TenKH = N'Nguyễn Đình Sơn' and MONTH(tHoaDonBan.NgayBan) = 8 and YEAR(tHoaDonBan.NgayBan) = 2014

-- 10
select tChiTietHDB.SoHDB from tChiTietHDB inner join tSach on tChiTietHDB.MaSach = tSach.MaSach where tSach.TenSach = N'Cấu trúc dữ liệu và giải thuật' 

-- 11
select tChiTietHDB.SoHDB from tChiTietHDB where tChiTietHDB.MaSach in ('S01', 'S02') and tChiTietHDB.SLBan between 10 and 20

select tChiTietHDB.SoHDB from tChiTietHDB inner join tSach on tChiTietHDB.MaSach = tSach.MaSach 
where (tSach.MaSach = N'S01' or tSach.MaSach = N'S02') and (tChiTietHDB.SLBan >= 10 and tChiTietHDB.SLBan <= 20)

-- 12
select SoHDB from tChiTietHDB A
where A.MaSach = 'S10' and SLBan between 5 and 15
and exists(select * from tChiTietHDB B where B.MaSach = 'S11' and SLBan between 5 and 15
and A.SoHDB = B.SoHDB)

select distinct tChiTietHDB.SoHDB from tChiTietHDB, tSach
where tChiTietHDB.MaSach = tSach.MaSach and tSach.MaSach='S10' and tChiTietHDB.SLBan between 5 and 10
intersect
select distinct tChiTietHDB.SoHDB from tChiTietHDB, tSach
where tChiTietHDB.MaSach = tSach.MaSach AND tSach.MaSach='S11' and tChiTietHDB.SLBan between 5 and 10

-- 13
select * from tSach where tSach.MaSach not in (select tChiTietHDB.MaSach from tChiTietHDB)

-- 14
select * from tSach where tSach.MaSach not in (select tChiTietHDB.MaSach from tChiTietHDB inner join tHoaDonBan on tChiTietHDB.SoHDB = tHoaDonBan.SoHDB where YEAR(tHoaDonBan.NgayBan) = 2014)

-- 15
select * from tSach inner join tNhaXuatBan on tSach.MaNXB = tNhaXuatBan.MaNXB
where tSach.MaSach not in (select tChiTietHDB.MaSach from tChiTietHDB inner join tHoaDonBan on tChiTietHDB.SoHDB = tHoaDonBan.SoHDB where YEAR(tHoaDonBan.NgayBan) = 2014)
and tNhaXuatBan.TenNXB = N'NXB Giáo Dục'



-- 16?
select distinct H.SoHDB from tChiTietHDB H where not exists(select * from tSach S inner join tNhaXuatBan on S.MaNXB = tNhaXuatBan.MaNXB where tNhaXuatBan.TenNXB = N'NXB Giáo Dục'
and not exists(select * from tChiTietHDB C where C.SoHDB = H.SoHDB and C.MaSach = S.MaSach))

-- 17
select count(distinct tSach.MaSach) as SoDauSachDuocBan from tSach inner join tChiTietHDB on tSach.MaSach = tChiTietHDB.MaSach
inner join tHoaDonBan on tChiTietHDB.SoHDB = tHoaDonBan.SoHDB where YEAR(tHoaDonBan.NgayBan) = 2014

-- 18
select max(tChiTietHDB.SLBan * tSach.DonGiaBan) AS MAXTRiGIAHD, min(tChiTietHDB.SLBan * tSach.DonGiaBan) AS MINTRiGIAHD
from tChiTietHDB inner join tSach on tChiTietHDB.MaSach = tSach.MaSach

-- 19
select AVG(tChiTietHDB.SLBan * tSach.DonGiaBan) as TBCTRIGIAHD from tChiTietHDB inner join tSach on tChiTietHDB.MaSach = tSach.MaSach

-- 20
select sum(tChiTietHDB.SLBan * tSach.DonGiaBan) as DOANHTHU from tChiTietHDB inner join tSach on tChiTietHDB.MaSach = tSach.MaSach
inner join tHoaDonBan on tChiTietHDB.SoHDB = tHoaDonBan.SoHDB where YEAR(tHoaDonBan.NgayBan) = 2014

-- 21
select tHoaDonBan.SoHDB from tHoaDonBan inner join tChiTietHDB on tHoaDonBan.SoHDB = tChiTietHDB.SoHDB
inner join tSach on tChiTietHDB.MaSach = tSach.MaSach
where YEAR(tHoaDonBan.NgayBan) = 2014 
and (tChiTietHDB.SLBan * tSach.DonGiaBan) = (select max(tChiTietHDB.SLBan * tSach.DonGiaBan) from tChiTietHDB inner join tSach on tChiTietHDB.MaSach = tSach.MaSach)

-- 22
select tKhachHang.TenKH from tKhachHang inner join tHoaDonBan on tKhachHang.MaKH = tHoaDonBan.MaKH
inner join tChiTietHDB on tHoaDonBan.SoHDB = tChiTietHDB.SoHDB inner join tSach on tChiTietHDB.MaSach = tSach.MaSach
where YEAR(tHoaDonBan.NgayBan) = 2014 and (tChiTietHDB.SLBan * tSach.DonGiaBan) in (select max(tChiTietHDB.SLBan * tSach.DonGiaBan) from tChiTietHDB inner join tSach on tChiTietHDB.MaSach = tSach.MaSach) 

--23
select top 3 tKhachHang.MaKH, tKhachHang.TenKH from tKhachHang inner join tHoaDonBan on tKhachHang.MaKH = tHoaDonBan.MaKH
inner join tChiTietHDB on tHoaDonBan.SoHDB = tChiTietHDB.SoHDB inner join tSach on tChiTietHDB.MaSach = tSach.MaSach  group by tKhachHang.MaKH, tKhachhang.TenKH
order by sum(tChiTietHDB.SLBan * tSach.DonGiaBan) desc

-- 24
select * from tSach where tSach.DonGiaBan in (select distinct top 3 tSach.DonGiaBan from tSach order by tSach.DonGiaBan desc)

-- 25
select * from tSach inner join tNhaXuatBan on tSach.MaNXB = tNhaXuatBan.MaNXB where tSach.DonGiaBan
in(select distinct top 3 tSach.DonGiaBan from tSach order by tSach.DonGiaBan desc) and tNhaXuatBan.TenNXB = N'NXB Giáo Dục'

--26
select tNhaXuatBan.TenNXB, count(tSach.TenSach) as TONGSODAUSACH from tSach inner join tNhaXuatBan on tSach.MaNXB = tNhaXuatBan.MaNXB
where tNhaXuatBan.TenNXB = N'NXB Giáo Dục' group by tNhaXuatBan.TenNXB

-- 27
select tNhaXuatBan.TenNXB, sum(tSach.SoLuong) as TONGSOSACH from tNhaXuatBan inner join tSach on tNhaXuatBan.MaNXB = tSach.MaNXB
group by tNhaXuatBan.TenNXB

-- 28
select tNhaXuatBan.TenNXB, max(tSach.DonGiaBan) as MAXDONGIABAN, min(tSach.DonGiaBan) as MINDONGIABAN, avg(tSach.DonGiaBan) as TBCDONGIABAN
from tSach inner join tNhaXuatBan on tSach.MaNXB = tNhaXuatBan.MaNXB group by tNhaXuatBan.TenNXB

--29
select tHoaDonBan.NgayBan, sum(tChiTietHDB.SLBan * tSach.DonGiaBan) as DOANHTHU
from tHoaDonBan inner join tChiTietHDB on tHoaDonBan.SoHDB = tChiTietHDB.SoHDB inner join tSach on tChiTietHDB.MaSach = tSach.MaSach
group by tHoaDonBan.NgayBan

-- 30
select tSach.TenSach, sum(tChiTietHDB.SLBan) as TONGSOLUONG
from tHoaDonBan inner join tChiTietHDB on tHoaDonBan.SoHDB = tChiTietHDB.SoHDB inner join tSach on tChiTietHDB.MaSach = tSach.MaSach
where YEAR(tHoaDonBan.NgayBan) = 2014 and MONTH(tHoaDonBan.NgayBan) = 10 group by tSach.TenSach

-- 31 ?

--select month(tHoaDonBan.NgayBan) as THANG, sum(tChiTietHDB.SLBan * tSach.DonGiaBan) as DOANHTHU from tSach inner join tChiTietHDB on tSach.MaSach = tChiTietHDB.MaSach 
--inner join tHoaDonBan on tChiTietHDB.SoHDB = tHoaDonBan.SoHDB where year (tHoaDonBan.NgayBan) = 2014 group by month(tHoaDonBan.NgayBan)
--union
-- select distinct month(tHoaDonBan.NgayBan) as THANG, '0' from tHoaDonBan where year(tHoaDonBan.NgayBan) = 2014 and month(tHoaDonBan.NgayBan) not in (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)

select 
isnull(sum(case month(NgayBan) when 1 then (SLBan * DonGiaBan) end), 0) as Thang1,
isnull(sum(case month(NgayBan) when 2 then (SLBan * DonGiaBan) end), 0) as Thang2,
isnull(sum(case month(NgayBan) when 3 then (SLBan * DonGiaBan) end), 0) as Thang3,
isnull(sum(case month(NgayBan) when 4 then (SLBan * DonGiaBan) end), 0) as Thang4,
isnull(sum(case month(NgayBan) when 5 then (SLBan * DonGiaBan) end), 0) as Thang5,
isnull(sum(case month(NgayBan) when 6 then (SLBan * DonGiaBan) end), 0) as Thang6,
isnull(sum(case month(NgayBan) when 7 then (SLBan * DonGiaBan) end), 0) as Thang7,
isnull(sum(case month(NgayBan) when 8 then (SLBan * DonGiaBan) end), 0) as Thang8,
isnull(sum(case month(NgayBan) when 9 then (SLBan * DonGiaBan) end), 0) as Thang9,
isnull(sum(case month(NgayBan) when 10 then (SLBan * DonGiaBan) end), 0) as Thang10,
isnull(sum(case month(NgayBan) when 11 then (SLBan * DonGiaBan) end), 0) as Thang11,
isnull(sum(case month(NgayBan) when 12 then (SLBan * DonGiaBan) end), 0) as Thang12,
isnull(sum(SLBan*DonGiaBan), 0) as CaNam
from tChiTietHDB as ct join tHoaDonBan as hd on ct.SoHDB = hd.SoHDB join tSach as s on s.MaSach = ct.MaSach
where year(hd.NgayBan) = 2014


--32
select * from tHoaDonBan where tHoaDonBan.SoHDB in (select tHoaDonBan.SoHDB from tHoaDonBan inner join tChiTietHDB on tHoaDonBan.SoHDB = tChiTietHDB.SoHDB
group by tHoaDonBan.SoHDB having count(distinct tChiTietHDB.MaSach) >= 4)

-- 33
select * from tHoaDonBan where tHoaDonBan.SoHDB in (select tHoaDonBan.SoHDB from tHoaDonBan inner join tChiTietHDB on tHoaDonBan.SoHDB = tChiTietHDB.SoHDB
inner join tSach on tChiTietHDB.MaSach = tSach.MaSach inner join tNhaXuatBan on tSach.MaNXB = tNhaXuatBan.MaNXB where tNhaXuatBan.TenNXB = N'NXB Giáo Dục'
group by tHoaDonBan.SoHDB having count(distinct tChiTietHDB.MaSach) = 3)

-- 34
select * from tKhachHang where tKhachHang.MaKH = (select top 1 tHoaDonBan.MaKH from tHoaDonBan group by tHoaDonBan.MaKH order by count(distinct tHoaDonBan.SoHDB) desc)

-- 35
select top 1 month(tHoaDonBan.NgayBan) as THANG_MAX_DOANHSO from tHoaDonBan inner join tChiTietHDB on tHoaDonBan.SoHDB = tChiTietHDB.SoHDB
inner join tSach on tChiTietHDB.MaSach = tSach.MaSach where year(tHoaDonBan.NgayBan) = 2014 
group by month(tHoaDonBan.NgayBan) order by sum(tChiTietHDB.SLBan * tSach.DonGiaBan) desc

-- 36
select * from tSach where tSach.MaSach = (select top 1 tChiTietHDB.MaSach from tChiTietHDB group by tChiTietHDB.MaSach order by sum(tChiTietHDB.SLBan))

-- 37
-- tạo ra view B
create view B as
select max(tSach.DonGiaBan) as MAXGIA, tNhaXuatBan.MaNXB from tSach inner join tNhaXuatBan on tSach.MaNXB = tNhaXuatBan.MaNXB group by tNhaXuatBan.MaNXB

-- truy vấn dựa vào bảng view B vừa tạo
select tSach.MaSach, tSach.TenSach, tNhaXuatBan.TenNXB from tSach inner join tNhaXuatBan on tSach.MaNXB = tNhaXuatBan.MaNXB 
where tSach.DonGiaBan in (select B.MAXGIA from B where tSach.MaNXB = B.MaNXB group by B.MAXGIA)

-- 38
select tSach.TenSach, tSach.DonGiaBan as GIABANDAU, tSach.DonGiaBan * 90 / 100 as SAUKHIGIAM from tSach inner join tNhaXuatBan on tSach.MaNXB = tNhaXuatBan.MaNXB
where tNhaXuatBan.TenNXB = N'NXB Giáo Dục'	

-- 39 ?
alter table tHoaDonBan
	add [TongTien] [money] NULL; 
UPDATE tHoaDonBan
SET tHoaDonBan.TongTien = t.tt
FROM (SELECT SUM(tChiTietHDB.SLBan * tSach.DonGiaBan) AS tt
FROM tHoaDonBan JOIN tChiTietHDB ON tChiTietHDB.SoHDB = tHoaDonBan.SoHDB JOIN tSach ON tSach.MaSach = tChiTietHDB.MaSach
GROUP BY tHoaDonBan.SoHDB) t

-- 40 ?
select tHoaDonBan.NgayBan, tHoaDonBan.TongTien as TRUOCKHIGIAM, (tHoaDonBan.TongTien * 90 / 100) as SAUKHIGIAM from tHoaDonBan
where tHoaDonBan.TongTien > 500000 and year(tHoaDonBan.NgayBan) = 2014 and month(tHoaDonBan.NgayBan) = 9

-- 41
select sum(tChiTietHDN.SLNhap) as TONGSOLUONGNHAP from tHoaDonNhap inner join tChiTietHDN on tHoaDonNhap.SoHDN = tChiTietHDN.SoHDN
inner join tSach on tChiTietHDN.MaSach = tSach.MaSach where year(tHoaDonNhap.NgayNhap) = 2014

-- 42
select sum(tChiTietHDB.SLBan) as TONGSOLUONGBAN from tHoaDonBan inner join tChiTietHDB on tHoaDonBan.SoHDB = tChiTietHDB.SoHDB
inner join tSach on tChiTietHDB.MaSach = tSach.MaSach where year(tHoaDonBan.NgayBan) = 2014

-- 43
select sum(tChiTietHDN.SLNhap * tSach.DonGiaNhap) as TONGTIENNHAP from tHoaDonNhap inner join tChiTietHDN on tHoaDonNhap.SoHDN = tChiTietHDN.SoHDN
inner join tSach on tChiTietHDN.MaSach = tSach.MaSach where year(tHoaDonNhap.NgayNhap) = 2014

-- 44
delete from tChiTietHDB 
where tChiTietHDB.SoHDB in (select tHoaDonBan.SoHDB from tHoaDonBan inner join tNhanVien on tHoaDonBan.MaNV = tNhanVien.MaNV where tNhanVien.TenNV = N'Trần Huy')

delete from tHoaDonBan 
where tHoaDonBan.MaNV = (select tNhanVien.MaNV from tNhanVien where tNhanVien.TenNV = N'Trần Huy')

INSERT [dbo].[tChiTietHDB] ([SoHDB], [MaSach], [SLBan], [KhuyenMai]) VALUES (N'HDB01', N'S01', 7, NULL)
INSERT [dbo].[tChiTietHDB] ([SoHDB], [MaSach], [SLBan], [KhuyenMai]) VALUES (N'HDB01', N'S02', 10, NULL)
INSERT [dbo].[tChiTietHDB] ([SoHDB], [MaSach], [SLBan], [KhuyenMai]) VALUES (N'HDB01', N'S04', 10, NULL)
INSERT [dbo].[tChiTietHDB] ([SoHDB], [MaSach], [SLBan], [KhuyenMai]) VALUES (N'HDB08', N'S01', 2, NULL)
INSERT [dbo].[tChiTietHDB] ([SoHDB], [MaSach], [SLBan], [KhuyenMai]) VALUES (N'HDB08', N'S06', 3, NULL)
INSERT [dbo].[tChiTietHDB] ([SoHDB], [MaSach], [SLBan], [KhuyenMai]) VALUES (N'HDB08', N'S07', 2, NULL)
INSERT [dbo].[tChiTietHDB] ([SoHDB], [MaSach], [SLBan], [KhuyenMai]) VALUES (N'HDB09', N'S03', 5, NULL)
INSERT [dbo].[tChiTietHDB] ([SoHDB], [MaSach], [SLBan], [KhuyenMai]) VALUES (N'HDB09', N'S06', 1, NULL)
INSERT [dbo].[tChiTietHDB] ([SoHDB], [MaSach], [SLBan], [KhuyenMai]) VALUES (N'HDB09', N'S09', 6, NULL)

INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKH]) VALUES (N'HDB01', N'NV01', CAST(N'2014-08-11T00:00:00.000' AS DateTime), N'KH01')
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKH]) VALUES (N'HDB08', N'NV01', CAST(N'2013-01-01T00:00:00.000' AS DateTime), N'KH02')
INSERT [dbo].[tHoaDonBan] ([SoHDB], [MaNV], [NgayBan], [MaKH]) VALUES (N'HDB09', N'NV01', CAST(N'2013-02-10T00:00:00.000' AS DateTime), N'KH02')

-- 45 
update tNhaXuatBan
set TenNXB = N'NXB Văn học' 
where TenNXB = N'NXB Thăng Long'

select * from tNhaXuatBan

-- 46 ?
select tSach.MaSach, tSach.TenSach, isnull(SLB, 0) as SoLuongBan from
tSach left join 
(select MaSach, sum(SLBan) as SLB from tChiTietHDB ctb join tHoaDonBan hdb on ctb.SoHDB = hdb.SoHDB where year(NgayBan) = 2014
group by MaSach) BangSLB on tSach.MaSach = BangSLB.MaSach