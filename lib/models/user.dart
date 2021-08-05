class User {
  String? _name;
  String? _email;
  String? _password;
  String? _mobile;
  bool? _flaglogged;

  User(this._name, this._email, this._password, this._flaglogged, this._mobile);

  User.map(dynamic obj) {
    this._name = obj['name'];
    this._email = obj['email'];
    this._password = obj['password'];
    this._flaglogged = obj['true'];
    this._mobile = obj['mobile'];
  }

  String? get name => _name;
  String? get email => _email;

  String? get password => _password;
  String? get mobile => _mobile;
  bool? get flaglogged => _flaglogged;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["email"] = _email;
    map["password"] = _password;
    map["flaglogged"] = _flaglogged;
    map["mobile"] = _mobile;
    return map;
  }
}
