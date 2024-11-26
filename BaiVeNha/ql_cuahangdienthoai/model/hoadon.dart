import 'dienthoai.dart';

class HoaDon {
  // Thuộc tính
  String _maHoaDon;
  DateTime _ngayBan;
  DienThoai _dienThoai;
  int _soLuongMua;
  double _giaBanThucTe;
  String _tenKhachHang;
  String _soDienThoaiKhach;

  // Constructor đầy đủ tham số
  HoaDon(this._maHoaDon, this._ngayBan, this._dienThoai, this._soLuongMua,
      this._giaBanThucTe, this._tenKhachHang, this._soDienThoaiKhach);

  // Getter/setter với validation
  DienThoai get dienThoai => _dienThoai;
  set dienThoai(DienThoai dienThoai) {
    _dienThoai = dienThoai;
  }

  String get maHoaDon => _maHoaDon;
  set maHoaDon(String value) {
    if (value.isEmpty || !RegExp(r"^HD-\d{3}$").hasMatch(value)) {
      throw Exception('Mã hóa đơn không hợp lệ!');
    }
    _maHoaDon = value;
  }

  DateTime get ngayBan => _ngayBan;
  set ngayBan(DateTime value) {
    if (value.isAfter(DateTime.now())) {
      throw Exception('Ngày bán không thể sau ngày hiện tại!');
    }
    _ngayBan = value;
  }

  int get soLuongMua => _soLuongMua;
  set soLuongMua(int value) {
    if (value <= 0 || value > _dienThoai.soLuongTonKho) {
      throw Exception('Số lượng mua không hợp lệ!');
    }
    _soLuongMua = value;
  }

  double get giaBanThucTe => _giaBanThucTe;
  set giaBanThucTe(double value) {
    if (value <= 0) throw Exception('Giá bán thực tế phải lớn hơn 0!');
    _giaBanThucTe = value;
  }

  String get tenKhachHang => _tenKhachHang;
  set tenKhachHang(String value) {
    if (value.isEmpty) throw Exception('Tên khách hàng không thể rỗng!');
    _tenKhachHang = value;
  }

  String get soDienThoaiKhach => _soDienThoaiKhach;
  set soDienThoaiKhach(String value) {
    if (value.isEmpty || !RegExp(r"^\d{10}$").hasMatch(value)) {
      throw Exception('Số điện thoại khách không hợp lệ!');
    }
    _soDienThoaiKhach = value;
  }

  // Phương thức tính tổng tiền
  double tinhTongTien() {
    return _giaBanThucTe * _soLuongMua;
  }

  // Phương thức tính lợi nhuận thực tế
  double tinhLoiNhuanThucTe() {
    return (_dienThoai.giaBan - _dienThoai.giaNhap) * _soLuongMua;
  }

  // Phương thức hiển thị thông tin hóa đơn
  void hienThiThongTinHoaDon() {
    print('Mã HD: $_maHoaDon');
    print('Ngày bán: $_ngayBan');
    print('Sản phẩm: ${_dienThoai.tenDienThoai}');
    print('Số lượng: $_soLuongMua');
    print('Giá bán thực tế: $_giaBanThucTe');
    print('Khách hàng: $_tenKhachHang');
    print('Số điện thoại khách: $_soDienThoaiKhach');
  }
}
