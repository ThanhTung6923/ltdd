class DienThoai {
  // Thuộc tính
  String _maDienThoai;
  String _tenDienThoai;
  String _hangSanXuat;
  double _giaNhap;
  double _giaBan;
  int _soLuongTonKho;
  bool _trangThai;

  // Constructor đầy đủ tham số
  DienThoai(this._maDienThoai, this._tenDienThoai, this._hangSanXuat,
      this._giaNhap, this._giaBan, this._soLuongTonKho, this._trangThai);

  // Getter/setter với validation
  String get maDienThoai => _maDienThoai;
  set maDienThoai(String value) {
    if (value.isEmpty || !RegExp(r"^DT-\d{3}$").hasMatch(value)) {
      throw Exception('Mã điện thoại không hợp lệ!');
    }
    _maDienThoai = value;
  }

  String get tenDienThoai => _tenDienThoai;
  set tenDienThoai(String value) {
    if (value.isEmpty) throw Exception('Tên điện thoại không thể rỗng!');
    _tenDienThoai = value;
  }

  String get hangSanXuat => _hangSanXuat;
  set hangSanXuat(String value) {
    if (value.isEmpty) throw Exception('Hãng sản xuất không thể rỗng!');
    _hangSanXuat = value;
  }

  double get giaNhap => _giaNhap;
  set giaNhap(double value) {
    if (value <= 0) throw Exception('Giá nhập phải lớn hơn 0!');
    _giaNhap = value;
  }

  double get giaBan => _giaBan;
  set giaBan(double value) {
    if (value <= 0 || value <= _giaNhap) {
      throw Exception('Giá bán phải lớn hơn giá nhập!');
    }
    _giaBan = value;
  }

  int get soLuongTonKho => _soLuongTonKho;
  set soLuongTonKho(int value) {
    if (value < 0) throw Exception('Số lượng tồn kho không thể nhỏ hơn 0!');
    _soLuongTonKho = value;
  }

  bool get trangThai => _trangThai;
  set trangThai(bool value) {
    _trangThai = value;
  }

  // Phương thức tính lợi nhuận dự kiến
  double tinhLoiNhuanDuKien() {
    return (_giaBan - _giaNhap) * _soLuongTonKho;
  }

  // Phương thức hiển thị thông tin điện thoại
  void hienThiThongTin() {
    print('Mã DT: $_maDienThoai');
    print('Tên DT: $_tenDienThoai');
    print('Hãng: $_hangSanXuat');
    print('Giá nhập: $_giaNhap');
    print('Giá bán: $_giaBan');
    print('Số lượng tồn kho: $_soLuongTonKho');
    print('Trạng thái: ${_trangThai ? "Còn kinh doanh" : "Ngừng kinh doanh"}');
  }

  // Phương thức kiểm tra có thể bán không
  bool coTheBan() {
    return _soLuongTonKho > 0 && _trangThai;
  }
}
