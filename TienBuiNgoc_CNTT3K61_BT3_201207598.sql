-- Bài 1:
use QLSinhVien
go
--1. Tạo View danh sách sinh viên, gồm các thông tin sau: Mã sinh viên, Họ sinh viên,
--Tên sinh viên, Học bổng.
create view BT1_1 as
select ds.MaSV, ds.HoSV, ds.TenSV, ds.HocBong from DSSinhVien ds

select * from BT1_1

--2. Tạo view Liệt kê các sinh viên có học bổng từ 150,000 trở lên và sinh ở Hà Nội, gồm
--các thông tin: Họ tên sinh viên, Mã khoa, Nơi sinh, Học bổng.
create view BT1_2 as
select ds.HoSV, ds.TenSV, ds.MaKhoa, ds.NoiSinh, ds.HocBong from DSSinhVien ds
where ds.HocBong > 150000 and ds.NoiSinh = N'Hà Nội'

select * from BT1_2

--3. Tạo view liệt kê những sinh viên nam của khoa Anh văn và khoa tin học, gồm các thông
--tin: Mã sinh viên, Họ tên sinh viên, tên khoa, Phái.
create view BT1_3 as
select ds.MaSV, ds.HoSV, ds.TenSV, k.TenKhoa, ds.Phai from DSSinhVien ds join DMKhoa k on ds.MaKhoa = k.MaKhoa
where ds.Phai = N'Nam' and k.TenKhoa in (N'Anh văn', N'Tin học')

select * from BT1_3

--4. Tạo view gồm những sinh viên có tuổi từ 20 đến 25, thông tin gồm: Họ tên sinh viên,
--Tuổi, Tên khoa.
create view BT1_4 as
select ds.HoSV, ds.TenSV, (year(GETDATE()) - year(ds.NgaySinh)) as N'Tuổi',k.TenKhoa from DSSinhVien ds join DMKhoa k on ds.MaKhoa = k.MaKhoa
where (year(GETDATE()) - year(ds.NgaySinh)) between 20 and 25

select * from BT1_4

--5. Tạo view cho biết thông tin về mức học bổng của các sinh viên, gồm: Mã sinh viên,
--Phái, Mã khoa, Mức học bổng. Trong đó, mức học bổng sẽ hiển thị là “Học bổng cao”
--nếu giá trị của field học bổng lớn hơn 500,000 và ngược lại hiển thị là “Mức trung bình”
create view BT1_5 as
select ds.MaSV, ds.Phai, ds.MaKhoa, N'Mức học bổng'=case when ds.HocBong > 500000 then N'Học bổng cao'
else N'Mức trung bình' end from DSSinhVien ds

select * from BT1_5

--6. Tạo view đưa ra thông tin những sinh viên có học bổng lớn hơn bất kỳ học bổng của
--sinh viên học khóa anh văn
create view BT1_6 as
select * from DSSinhVien 
where HocBong > (select max(HocBong) from DSSinhVien where MaKhoa = 'AV')

select * from BT1_6

--7. Tạo view đưa ra thông tin những sinh viên đạt điểm cao nhất trong từng môn.
create view BT1_7 as
select ds.HoSV, ds.TenSV, ds.Phai, ds.NgaySinh, ds.NoiSinh, ds.HocBong, b.* from DSSinhVien ds, 
(select MaSV, KetQua.MaMH, Diem from KetQua, (select MaMH, max(Diem) as maxDiem from KetQua group by MaMH)a
where KetQua.MaMH = a.MaMH and Diem = a.maxDiem) b
where ds.MaSV=b.MaSV 

select * from BT1_7

--8. Tạo view đưa ra những sinh viên chưa thi môn cơ sở dữ liệu.
create view BT1_8 as
select * from DSSinhVien where not exists 
(select distinct * from KetQua where MaMH = '01' and MaSV = DSSinhVien.MaSV)

select * from BT1_8


--9. Tạo view đưa ra thông tin những sinh viên không trượt môn nào.
create view BT1_9 as
select ds.MaSV, ds.HoSV + ' ' + ds.TenSV as HoTenSV, ds.Phai, ds.NgaySinh, ds.NoiSinh, ds.HocBong
from DSSinhVien ds, KetQua kq where ds.MaSV = kq.MaSV
group by ds.MaSV, ds.HoSV, + ds.TenSV, ds.Phai, ds.NgaySinh, ds.NoiSinh, ds.HocBong
having min(kq.Diem) >=4 and count(kq.MaSV) >=1

select * from KetQua

select * from BT1_9

--10. Tạo view danh sách sinh viên không bi rớt môn nào
create view BT1_10 as
select ds.MaSV, ds.HoSV + ' ' + ds.TenSV as HoTenSV, ds.Phai, ds.NgaySinh, ds.NoiSinh, ds.HocBong
from DSSinhVien ds, KetQua kq where ds.MaSV = kq.MaSV
group by ds.MaSV, ds.HoSV, + ds.TenSV, ds.Phai, ds.NgaySinh, ds.NoiSinh, ds.HocBong
having min(kq.Diem) >= 4

select * from BT1_10


-- Bài 2:
use QLHocSinh
go
--1. Tạo view DSHS10A1 gồm thông tin Mã học sinh, họ tên, giới tính (là “Nữ” nếu Nu=1, ngược lại là “Nam”), 
-- các điểm Toán, Lý, Hóa, Văn của các học sinh lớp 10A1
create view DSHS10A1 as
select a.MAHS, ds.HO + ' '+ ds.TEN as N'Họ tên', N'Giới tính'=case when ds.NU = 1 then N'Nữ' 
else N'Nam' end, a.TOAN, a.LY, a.HOA, a.VAN from DSHS ds, (select d.MAHS, d.TOAN, d.LY, d.HOA, d.VAN from DIEM d)a
where ds.MAHS = a.MAHS and ds.MALOP = N'10A1'

select * from DSHS10A1

--2. - Tạo login TranThanhPhong, tạo user TranThanhPhong cho TranThanhPhong trên CSDL QLHocSinh. 
-- Phân quyền Select trên view DSHS10A1 cho TranThanhPhong. Đăng nhập TranThanhPhong để kiểm tra
--- Tạo login PhamVanNam, tạo user PhamVanNam cho PhamVanNam trên CSDL QLHocSinh Đăng nhập PhamVanNam để kiểm tra
--- Tạo view DSHS10A2 tương tự như câu 1
--Phân quyền Select trên view DSHS10A2 cho PhamVanNam
--Đăng nhập PhamVanNam để kiểm tra
exec sp_addlogin TranThanhPhong, 123
use QLHocSinh
exec sp_adduser TranThanhPhong, TranThanhPhong
grant select on DSHS10A1 to TranThanhPhong

create view DSHS10A2 as
select a.MAHS, ds.HO + ' '+ ds.TEN as N'Họ tên', N'Giới tính'=case when ds.NU = 1 then N'Nữ' 
else N'Nam' end, a.TOAN, a.LY, a.HOA, a.VAN from DSHS ds, (select d.MAHS, d.TOAN, d.LY, d.HOA, d.VAN from DIEM d)a
where ds.MAHS = a.MAHS and ds.MALOP = N'10A1'

exec sp_addlogin PhamVanNam, 123
use QLHocSinh
exec sp_adduser PhamVanNam, PhamVanNam
grant select on DSHS10A2 to PhamVanNam

--3. Tạo view báo cáo Kết thúc năm học gồm các thông tin: 
-- Mã học sinh, Họ và tên, Ngày sinh, Giới tính, Điểm Toán, Lý, Hóa, Văn, Điểm Trung bình, Xếp loại, 
-- Sắp xếp theo xếp loại (chọn 1000 bản ghi đầu). Trong đó:
--Điểm trung bình (DTB) = ((Toán + Văn)*2 + Lý + Hóa)/6)
--Cách thức xếp loại như sau:
--- Xét điểm thấp nhất (DTN) của các 4 môn
--- Nếu DTB>5 và DTN>4 là “Lên Lớp”, ngược lại là lưu ban
update DIEM
set DIEM.DTB = round(((DIEM.TOAN + DIEM.VAN)*2 + DIEM.LY + DIEM.HOA)/6, 2) from DIEM 

alter table DIEM
	add [DTN] [FLOAT] NULL; 

update DIEM
set DIEM.DTN = CASE WHEN VAN >= TOAN AND LY >= TOAN AND HOA >= TOAN THEN TOAN
WHEN TOAN >= VAN AND LY >= VAN AND HOA >= VAN THEN VAN
WHEN TOAN >= LY AND VAN >= LY AND HOA >= LY THEN LY
WHEN TOAN >= HOA AND VAN >= HOA AND LY >= HOA THEN HOA
END

update DIEM
set DIEM.XEPLOAI = case when DTN > 4 AND DTB > 5 then N'Lên lớp' else N'Lưu ban' end

create view Bao_Cao_Ket_Thuc_Nam_Hoc as
select top 1000 a.MAHS, ds.HO + ' '+ ds.TEN as N'Họ tên', ds.NGAYSINH, N'Giới tính'=case when ds.NU = 1 then N'Nữ' 
else N'Nam' end, a.TOAN, a.LY, a.HOA, a.VAN, a.DTB, a.XEPLOAI from DSHS ds, (select d.MAHS, d.TOAN, d.LY, d.HOA, d.VAN, d.DTB,d.XEPLOAI from DIEM d)a
where ds.MAHS = a.MAHS order by a.DTB desc

select * from Bao_Cao_Ket_Thuc_Nam_Hoc

--4. Tạo view danh sách HOC SINH XUAT SAC bao gồm các học sinh có DTB>=8.5 và DTN>=8 với các trường: 
-- Lop, Mahs, Hoten, Namsinh (năm sinh), Nu, Toan, Ly, Hoa, Van, DTN, DTB
create view Hoc_Sinh_Xuat_Sac as
select ds.MALOP, a.MAHS, ds.HO + ' '+ ds.TEN as HoTen, year(ds.NGAYSINH) as NamSinh, GioiTinh=case when ds.NU = 1 then N'Nữ' 
else N'Nam' end, a.TOAN, a.LY, a.HOA, a.VAN, a.DTN, a.DTB from DSHS ds, (select d.MAHS, d.TOAN, d.LY, d.HOA, d.VAN, d.DTB,d.DTN from DIEM d)a
where ds.MAHS = a.MAHS and a.DTB >= 8.5 and a.DTN >=8

select * from Hoc_Sinh_Xuat_Sac

--5. Tạo view danh sách HOC SINH DAT THU KHOA KY THI bao gồm các học sinh xuất sắc có DTB lớn nhất với các trường:
-- Lop, Mahs, Hoten, Namsinh, Nu, Toan, Ly, Hoa, Van, DTB
create view Hoc_Sinh_Dat_Thu_Khoa_Ky_Thi as
select MALOP, MAHS, HoTen, NamSinh, GioiTinh, TOAN, LY, HOA, VAN, DTB from Hoc_Sinh_Xuat_Sac
where DTB in (select max(DTB) from Hoc_Sinh_Xuat_Sac)

select * from Hoc_Sinh_Dat_Thu_Khoa_Ky_Thi

--Bài tập 3: 
use QLSinhVien
go
--1. Tạo login Login1, tạo User1 cho Login1
exec sp_addlogin Login1, 123
use QLSinhVien
exec sp_adduser Login1, user_1
--2. Phân quyền Select trên bảng DSSinhVien cho User1
grant select on DSSinhVien to user_1
--3. Đăng nhập để kiểm tra
--4. Tạo login Login2, tạo User2 cho Login2
exec sp_addlogin Login2, 123
use QLSinhVien
exec sp_adduser Login2, user_2
--5. Phân quyền Update trên bảng DSSinhVien cho User2, người này có thể cho phép người khác sử dụng quyền này
grant update on DSSinhVien to user_2 with grant option
--6. Đăng nhập dưới Login2 và trao quyền Update trên bảng DSSinhVien cho User 1
-- trước tiên phải đăng nhập Login2
use QLSinhVien
grant update on DSSinhVien to user_1
--7. Đăng nhập Login 1 để kiểm tra




