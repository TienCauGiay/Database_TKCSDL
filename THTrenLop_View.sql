use BT1CSDL
go

-- 16
create view C16 as
select tSach.TenSach, sum(tChiTietHDB.SLBan) as TONGSOLUONGBBAN
from tHoaDonBan inner join tChiTietHDB on tHoaDonBan.SoHDB = tChiTietHDB.SoHDB inner join tSach on tChiTietHDB.MaSach = tSach.MaSach
where YEAR(tHoaDonBan.NgayBan) = 2014 group by tSach.TenSach

select * from C16

-- 2_1
create procedure C2_1
@ngay nvarchar(50), @SLHD int output, @SLTB int output
as
begin
select @SLHD = (select count(tHoaDonBan.SoHDB) from tHoaDonBan where tHoaDonBan.NgayBan = @ngay)
select @SLTB = (select sum(tChiTietHDB.SLBan * tSach.DonGiaBan) from tHoaDonBan join tChiTietHDB on tHoaDonBan.SoHDB = tChiTietHDB.SoHDB
join tSach on tChiTietHDB.MaSach = tSach.MaSach where tHoaDonBan.NgayBan = @ngay)
end;

declare @SLHD int, @SLTB int
exec C2_1 N'2014-08-11', @SLHD output, @SLTB output
print @SLHD
print @SLTB

-- 2_2
create function C2Cham2(@thang int, @nam int) returns table as
	return(select top 10 tSach.TenSach, sum(tChiTietHDB.SLBan) as SLB from tSach join tChiTietHDB on tSach.MaSach = tChiTietHDB.MaSach 
	join tHoaDonBan on tChiTietHDB.SoHDB = tHoaDonBan.SoHDB where month(tHoaDonBan.NgayBan) = @thang and year(tHoaDonBan.NgayBan) = 2014
	group by tSach.TenSach order by sum(tChiTietHDB.SLBan) desc)

select * from C2Cham2(1)

-- 17
create view C_17 as
select tKhachHang.TenKH from tKhachHang inner join tHoaDonBan on tKhachHang.MaKH = tHoaDonBan.MaKH
inner join tChiTietHDB on tHoaDonBan.SoHDB = tChiTietHDB.SoHDB inner join tSach on tChiTietHDB.MaSach = tSach.MaSach
where YEAR(tHoaDonBan.NgayBan) = 2014 and (tChiTietHDB.SLBan * tSach.DonGiaBan) in 
(select max(tChiTietHDB.SLBan * tSach.DonGiaBan) from tChiTietHDB inner join tSach on tChiTietHDB.MaSach = tSach.MaSach) 

-- 3
create procedure C_3
@MNCC nvarchar(20), @SDS int output, @ST int output
as
begin
select @SDS = (select count(distinct tSach.MaSach) from tSach join tChiTietHDN on tSach.MaSach = tChiTietHDN.MaSach
join tHoaDonNhap on tChiTietHDN.SoHDN = tHoaDonNhap.SoHDN where tHoaDonNhap.MaNCC = @MNCC)
select @ST = (select sum(tChiTietHDN.SLNhap * tSach.DonGiaNhap) from tHoaDonNhap join tChiTietHDN on tHoaDonNhap.SoHDN = tChiTietHDN.SoHDN
join tSach on tChiTietHDN.MaSach = tSach.MaSach where tHoaDonNhap.MaNCC = @MNCC)
end;

declare @SDS int, @ST int
exec C_3 'NCC06', @SDS output, @ST output
print @SDS
print @ST

alter table tKhachHang
	add [NgaySinh] [datetime] null;

select * from tKhachHang
-- 4
create function C_4 
(@ns nvarchar(20)) 
