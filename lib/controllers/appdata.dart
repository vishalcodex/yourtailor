import 'package:flutter/foundation.dart';
import 'package:tailer_app/helper/network_helper.dart';
import 'package:tailer_app/models/gender.dart';
import 'package:tailer_app/models/occasion.dart';
import 'package:tailer_app/models/type.dart';
import 'package:tailer_app/models/user.dart';

class AppData extends ChangeNotifier {
  User _userData;
  bool _loading = false;
  bool _needFabric = false;
  Gender _selectedGender;
  List<Occasion> _occasions = [];
  List<DressType> _types = [];
  List<DressType> _maleTypes = [];
  List<DressType> _femaleTypes = [];
  String _date = '';
  String _fromTime = '';
  String _toTime = '';
  String _address = '';
  List<String> _images = [];

  User get userData => _userData;

  List<String> get images => _images;

  String get date => _date;

  bool get loading => _loading;

  bool get needFabric => _needFabric;

  String get fromTime => _fromTime;

  String get toTime => _toTime;

  String get address => _address;

  Gender get selectedGender => _selectedGender;

  List<Occasion> get occasions =>
      List<Occasion>.from(_occasions.where((element) => element.selected));

  List<DressType> get types =>
      List<DressType>.from(_types.where((element) => element.selected));

  List<DressType> get femaleTypes => _femaleTypes;

  List<DressType> get maleTypes => _maleTypes;

  void setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  void setNeedFabric(bool val) {
    _needFabric = val;
    notifyListeners();
  }

  void setMaleSelected(int index, bool val) {
    _maleTypes[index].selected = val;
    notifyListeners();
  }

  void setFemaleSelected(int index, bool val) {
    _femaleTypes[index].selected = val;
    notifyListeners();
  }

  void setUserData(String name, String email, String mobile) {
    _userData = User(
      name: name,
      email: email,
      mobile: mobile,
    );
    notifyListeners();
  }

  void setUserInfoData(
      String date, String fromTime, String toTime, String address) {
    _date = date;
    _fromTime = fromTime;
    _toTime = toTime;
    _address = address;
    notifyListeners();
  }

  void setOccasions(List<Occasion> occasions) {
    _occasions = occasions;
    notifyListeners();
  }

  void setDressTypes(List<DressType> types) {
    _types = types;
    notifyListeners();
  }

  void setSelectedGender(Gender gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  Future<dynamic> sendData() async {
    var occasion = '';
    occasions.forEach((element) {
      occasion += element.title + ',';
    });
    var type = '';
    List<DressType> dressTypes = _selectedGender.title == "Male" ? _maleTypes : _femaleTypes;
    dressTypes.forEach((element) {
      if (element.selected) {
        type += element.title + '(${_needFabric ? element.needFabricPrice : element.haveFabricPrice}₹),';
      }
    });
    print(type);
    var data = {
      'phone': _userData.mobile,
      'name': _userData.name,
      'email': _userData.email,
      'address': address,
      'fromTime': fromTime,
      'toTime': toTime,
      'date': date,
      'gender': _selectedGender.title,
      'fabric': _needFabric ? 'I need fabric' : 'I have fabric',
      'occasions': occasion,
      'types': type,
    };
    return NetworkHelper().post('api/appointment', data).then((res) {
      return res;
    });
    // return NetworkHelper().post('send_mail.php', data).then((res) {
    //   return res;
    // });
  }

  int _current = 0;

  int get current => _current;

  void updateCurrent(int index) {
    _current = index;
    notifyListeners();
  }

  Future<dynamic> getData() {
    return NetworkHelper().get('api/types').then((res) {
      if (res['status'] == true) {
        final resImages = res['images'];
        final resTypes = res['types'];
        _images = List<String>.from(resImages);
        if (resTypes != null) {
          _types = List<DressType>.from(
            resTypes.map(
              (type) => DressType.fromMap(type),
            ),
          );
          _maleTypes = List<DressType>.from(
              _types.where((element) => element.type == 1));
          _femaleTypes = List<DressType>.from(
              _types.where((element) => element.type == 0));
        }
        notifyListeners();
      }
      if (res['status'] == false) {
        return res;
      }
      return res;
    });
  }

  Future<dynamic> getUpdatedData() {
    return NetworkHelper().get('api/prices').then((res) {
      if (res['status'] == true) {
        final resImages = res['images'];
        final resTypes = res['types'];
        _images = List<String>.from(resImages);
        if (resTypes != null) {
          _types = List<DressType>.from(
            resTypes.map(
                  (type) => DressType.fromMap(type),
            ),
          );
          _maleTypes = List<DressType>.from(
              _types.where((element) => element.type == 1));
          _femaleTypes = List<DressType>.from(
              _types.where((element) => element.type == 2));
        }
        notifyListeners();
      }
      if (res['status'] == false) {
        return res;
      }
      return res;
    });
  }
}
