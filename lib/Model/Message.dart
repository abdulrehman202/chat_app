class Message{
  String _id, _content,  _sender, _receiver;
  DateTime _time;
  
  Message(this._id, this._content, this._time, this._sender, this._receiver);

  String get id
  {
    return _id;
  }

  set id(String id)
  {
    _id = id;
  }

  String get content
  {
    return _content;
  }

  set content(String content)
  {
    _content = content;
  }
  
  DateTime get time
  {
    return _time;
  }

  set time(DateTime time)
  {
    _time = time;
  }
  
  String get sender
  {
    return _sender;
  }

  set sender(String sender)
  {
    _sender = sender;
  }
  
    String get receiver
  {
    return _receiver;
  }

  set receiver(String receiver)
  {
    _receiver = receiver;
  }
  

}