class Note {
  int? _id;
  String _title;
  String? _description;
  String _date;


  Note.withID(this._id, this._title, this._description, this._date);

  Note(this._title, this._description, this._date);

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String? get description => _description;

  set description(String value) {
    _description = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int? get id => _id;

  set id(int value) {
    _id = value;
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note.withID(
      json['id'],
      json['title'],
      json['description'],
      json['date'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': _id,
    'title': _title,
    'description': _description,
    'date': _date,
  };
}