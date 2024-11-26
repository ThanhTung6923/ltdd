import '../model/cuahang.dart';
import '../model/dienthoai.dart';
import '../model/hoadon.dart';

void main() {
  // Tạo các đối tượng mẫu
  var dt1 =
      DienThoai('DT-001', 'iPhone 14', 'Apple', 15000000, 20000000, 70, true);
  var dt2 = DienThoai(
      'DT-002', 'Samsung Galaxy S23', 'Samsung', 10000000, 15000000, 50, true);

  var cuaHang = CuaHang('Cửa hàng điện thoại 345', 'Hồ Chí Minh');

  // Thêm điện thoại vào cửa hàng
  cuaHang.themDienThoai(dt1);
  cuaHang.themDienThoai(dt2);

  // In thông tin các điện thoại
  print('\nDanh sách điện thoại trong cửa hàng');
  for (var dt in cuaHang.danhSachDienThoai) {
    dt.hienThiThongTin(); // Gọi phương thức hienThiThongTin() để hiển thị thông tin điện thoại
  }

  // Tạo hóa đơn bán hàng
  var hoaDon1 = HoaDon(
      'HD-001', DateTime.now(), dt1, 1, 20000000, 'Nguyễn Văn A', '0912345678');
  cuaHang.themHoaDon(hoaDon1);
  var hoaDon2 = HoaDon(
      'HD-002', DateTime.now(), dt1, 2, 40000000, 'Trần Thị B', '0912345679');
  cuaHang.themHoaDon(hoaDon2);
  var hoaDon3 = HoaDon(
      'HD-003', DateTime.now(), dt2, 3, 45000000, 'Lê Văn C', '0912345680');
  cuaHang.themHoaDon(hoaDon3);

  print("------------------------");
  // In thông tin hóa đơn
  print('\nThông tin hóa đơn');
  hoaDon1.hienThiThongTinHoaDon();
  hoaDon2.hienThiThongTinHoaDon();
  hoaDon3.hienThiThongTinHoaDon();
  print("------------------------");

  // Kiểm tra các phương thức
  testCapNhatDienThoai(cuaHang);
  testNgungKinhDoanhDienThoai(cuaHang);
  testTimKiemDienThoai(cuaHang);
  testTimKiemHoaDon(cuaHang);

  // Thống kê điện thoại bán chạy nhất
  print("------------------------");
  print('\nThống kê top điện thoại bán chạy');
  cuaHang.thongKeTopDienThoaiBanChay();

  // Thống kê tồn kho
  print("------------------------");
  cuaHang.thongKeTonKho(); // Thống kê tồn kho

  // Tính tổng doanh thu trong một khoảng thời gian
  print("------------------------");
  DateTime startDate =
      DateTime.now().subtract(Duration(days: 30)); // 30 ngày trước
  DateTime endDate = DateTime.now(); // Ngày hiện tại
  double tongDoanhThu = cuaHang.tinhTongDoanhThu(startDate, endDate);
  print('Tổng doanh thu trong khoảng thời gian: $tongDoanhThu');

  // Tính tổng lợi nhuận trong một khoảng thời gian
  double tongLoiNhuan = cuaHang.tinhTongLoiNhuan(startDate, endDate);
  print('Tổng lợi nhuận trong khoảng thời gian: $tongLoiNhuan');
}

// Kiểm tra cập nhật điện thoại
void testCapNhatDienThoai(CuaHang cuaHang) {
  print("\nKiểm tra cập nhật điện thoại:");
  var dt3 = DienThoai('DT-002', 'Samsung Galaxy Z Fold', 'Samsung', 12000000,
      17000000, 100, true);
  cuaHang.capNhatDienThoai(dt3); // Cập nhật điện thoại có mã DT-002

  // In lại danh sách điện thoại
  for (var dt in cuaHang.danhSachDienThoai) {
    dt.hienThiThongTin();
  }

  // Thử cập nhật điện thoại không tồn tại
  try {
    var dt4 =
        DienThoai('DT-003', 'Nokia 3310', 'Nokia', 1000000, 1500000, 20, true);
    cuaHang.capNhatDienThoai(dt4); // Điện thoại này không tồn tại
  } catch (e) {
    print('Lỗi: $e'); // In lỗi nếu có ngoại lệ
  }
}

// Kiểm tra ngừng kinh doanh điện thoại
void testNgungKinhDoanhDienThoai(CuaHang cuaHang) {
  print("\nKiểm tra ngừng kinh doanh điện thoại:");
  cuaHang.ngungKinhDoanhDienThoai(
      'DT-001'); // Ngừng kinh doanh điện thoại có mã DT-001

  // In lại danh sách điện thoại để kiểm tra trạng thái
  for (var dt in cuaHang.danhSachDienThoai) {
    dt.hienThiThongTin();
  }

  // Thử ngừng kinh doanh điện thoại không tồn tại
  try {
    cuaHang.ngungKinhDoanhDienThoai('DT-003'); // Điện thoại này không tồn tại
  } catch (e) {
    print('Lỗi: $e'); // In lỗi nếu có ngoại lệ
  }
}

// Kiểm tra tìm kiếm điện thoại
void testTimKiemDienThoai(CuaHang cuaHang) {
  print("\nKiểm tra tìm kiếm điện thoại:");
  cuaHang.timKiemDienThoai('Samsung'); // Tìm kiếm theo hãng "Samsung"
  cuaHang.timKiemDienThoai('iPhone'); // Tìm kiếm theo tên "iPhone"

  // Tìm kiếm không có kết quả
  cuaHang.timKiemDienThoai('Nokia'); // Tìm kiếm một điện thoại không tồn tại
}

// Kiểm tra tìm kiếm hóa đơn
void testTimKiemHoaDon(CuaHang cuaHang) {
  print("\nKiểm tra tìm kiếm hóa đơn:");
  // Tìm kiếm theo mã hóa đơn
  cuaHang.timKiemHoaDon('HD-001');
  // Tìm kiếm theo tên khách hàng
  cuaHang.timKiemHoaDon('Nguyễn Văn A');
  // Tìm kiếm theo ngày bán (dùng chuỗi ngày bán)
  cuaHang.timKiemHoaDon(DateTime.now().toString());
  // Tìm kiếm không có kết quả
  cuaHang.timKiemHoaDon('HD-999');
  // Thống kê lợi nhuận
  print('\nThống kê lợi nhuận');
  cuaHang.thongKeLoiNhuan();
}
