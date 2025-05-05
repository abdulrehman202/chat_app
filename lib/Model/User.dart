
class User{
  late String _id, _name;
  
  User(this._id, this._name);

  String get id
  {
    return _id;
  }

  set id(String id)
  {
    _id = id;
  }

  String get name
  {
    return _name;
  }

  set name(String name)
  {
    _name = name;
  }
  
}