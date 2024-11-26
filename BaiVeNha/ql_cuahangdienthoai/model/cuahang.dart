import 'dienthoai.dart';
import 'hoadon.dart';

class CuaHang {
  // Thuộc tính
  String _tenCuaHang;
  String _diaChi;
  List<DienThoai> _danhSachDienThoai = [];
  List<HoaDon> _danhSachHoaDon = [];

  // Constructor
  CuaHang(this._tenCuaHang, this._diaChi);

  // Getter và Setter
  String get tenCuaHang => _tenCuaHang;
  set tenCuaHang(String value) => _tenCuaHang = value;

  String get diaChi => _diaChi;
  set diaChi(String value) => _diaChi = value;

  List<DienThoai> get danhSachDienThoai => _danhSachDienThoai;
  set danhSachDienThoai(List<DienThoai> value) => _danhSachDienThoai = value;

  List<HoaDon> get danhSachHoaDon => _danhSachHoaDon;
  set danhSachHoaDon(List<HoaDon> value) => _danhSachHoaDon = value;

  // Các phương thức quản lý điện thoại
  void themDienThoai(DienThoai dienThoai) {
    _danhSachDienThoai.add(dienThoai);
    print('Đã thêm điện thoại: ${dienThoai.tenDienThoai}');
  }

  void capNhatDienThoai(DienThoai dienThoai) {
    var index = _danhSachDienThoai
        .indexWhere((dt) => dt.maDienThoai == dienThoai.maDienThoai);
    if (index != -1) {
      _danhSachDienThoai[index] = dienThoai;
      print('Cập nhật thành công: ${dienThoai.tenDienThoai}');
    } else {
      throw Exception('Điện thoại không tồn tại!');
    }
  }

  void ngungKinhDoanhDienThoai(String maDienThoai) {
    var dienThoai = _danhSachDienThoai.firstWhere(
        (dt) => dt.maDienThoai == maDienThoai,
        orElse: () =>
            DienThoai('DT-000', 'Không tên', 'Không hãng', 0, 0, 0, false));
    if (dienThoai.maDienThoai == 'DT-000') {
      throw Exception('Điện thoại không tồn tại!');
    } else {
      dienThoai.trangThai = false;
      print('Điện thoại ${dienThoai.tenDienThoai} ngừng kinh doanh.');
    }
  }

  void timKiemDienThoai(String keyword) {
    var result = _danhSachDienThoai
        .where((dt) =>
            dt.maDienThoai.contains(keyword) ||
            dt.tenDienThoai.contains(keyword) ||
            dt.hangSanXuat.contains(keyword))
        .toList();
    if (result.isEmpty) {
      print('Không tìm thấy điện thoại với từ khóa: $keyword');
    } else {
      print('Danh sách điện thoại tìm thấy:');
      result.forEach((dt) => dt.hienThiThongTin());
    }
  }

  // Các phương thức quản lý hóa đơn
  void themHoaDon(HoaDon hoaDon) {
    _danhSachHoaDon.add(hoaDon);
    print('Đã thêm hóa đơn: ${hoaDon.maHoaDon}');
  }

  // Tìm kiếm hóa đơn theo mã hóa đơn, ngày bán, hoặc tên khách hàng
  void timKiemHoaDon(String searchTerm) {
    bool found = false;
    for (var hoaDon in danhSachHoaDon) {
      // Tìm kiếm theo mã hóa đơn, ngày bán, hoặc tên khách hàng
      if (hoaDon.maHoaDon.contains(searchTerm) ||
          hoaDon.tenKhachHang.contains(searchTerm) ||
          hoaDon.ngayBan.toString().contains(searchTerm)) {
        hoaDon.hienThiThongTinHoaDon();
        found = true;
      }
    }
    if (!found) {
      print('Không tìm thấy hóa đơn nào với từ khóa: $searchTerm');
    }
  }

  // Thống kê
  void thongKeLoiNhuan() {
    double tongLoiNhuan = 0;
    _danhSachHoaDon.forEach((hoaDon) {
      tongLoiNhuan += hoaDon.tinhLoiNhuanThucTe();
    });
    print('Tổng lợi nhuận từ các hóa đơn: $tongLoiNhuan');
  }

  // Thống kê điện thoại bán chạy
  void thongKeTopDienThoaiBanChay() {
    var dienThoaiBanChay = <String, int>{};
    // Duyệt qua tất cả các hóa đơn và tính số lượng bán của mỗi điện thoại
    danhSachHoaDon.forEach((hoaDon) {
      if (dienThoaiBanChay.containsKey(hoaDon.dienThoai.tenDienThoai)) {
        dienThoaiBanChay[hoaDon.dienThoai.tenDienThoai] =
            dienThoaiBanChay[hoaDon.dienThoai.tenDienThoai]! +
                hoaDon.soLuongMua;
      } else {
        dienThoaiBanChay[hoaDon.dienThoai.tenDienThoai] = hoaDon.soLuongMua;
      }
    });
    // Sắp xếp các điện thoại theo số lượng bán
    var sortedList = dienThoaiBanChay.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    // In ra top điện thoại bán chạy
    print('Top điện thoại bán chạy:');
    sortedList.forEach((entry) {
      print('${entry.key}: ${entry.value} chiếc');
    });
  }

  // Phương thức thống kê tồn kho
  void thongKeTonKho() {
    print('Thống kê tồn kho:');
    danhSachDienThoai.forEach((dienThoai) {
      print('${dienThoai.tenDienThoai}: ${dienThoai.soLuongTonKho}');
    });
  }

  // Phương thức tính tổng doanh thu theo khoảng thời gian
  double tinhTongDoanhThu(DateTime startDate, DateTime endDate) {
    double tongDoanhThu = 0;

    danhSachHoaDon.forEach((hoaDon) {
      if (hoaDon.ngayBan.isAfter(startDate) &&
          hoaDon.ngayBan.isBefore(endDate)) {
        tongDoanhThu += hoaDon.tinhTongTien();
      }
    });
    return tongDoanhThu;
  }

  // Phương thức tính tổng lợi nhuận theo khoảng thời gian
  double tinhTongLoiNhuan(DateTime startDate, DateTime endDate) {
    double tongLoiNhuan = 0;

    danhSachHoaDon.forEach((hoaDon) {
      if (hoaDon.ngayBan.isAfter(startDate) &&
          hoaDon.ngayBan.isBefore(endDate)) {
        tongLoiNhuan += hoaDon.tinhLoiNhuanThucTe();
      }
    });
    return tongLoiNhuan;
  }

  // Hiển thị thông tin cửa hàng
  void hienThiThongTinCuaHang() {
    print('Cửa hàng: $_tenCuaHang');
    print('Địa chỉ: $_diaChi');
    print('Số lượng điện thoại trong cửa hàng: ${_danhSachDienThoai.length}');
    print('Số lượng hóa đơn: ${_danhSachHoaDon.length}');
  }

  // Hiển thị thông tin danh sách điện thoại trong cửa hàng
  void hienThiDanhSachDienThoai() {
    print('Danh sách điện thoại trong cửa hàng:');
    if (_danhSachDienThoai.isEmpty) {
      print('Không có điện thoại trong cửa hàng.');
    } else {
      _danhSachDienThoai.forEach((dt) {
        dt.hienThiThongTin();
      });
    }
  }

  // Hiển thị thông tin danh sách hóa đơn
  void hienThiDanhSachHoaDon() {
    print('Danh sách hóa đơn:');
    if (_danhSachHoaDon.isEmpty) {
      print('Không có hóa đơn nào.');
    } else {
      _danhSachHoaDon.forEach((hoaDon) {
        hoaDon.hienThiThongTinHoaDon();
      });
    }
  }
}
