/// Global class to store data
/// and paginated products fetched from RestApi
/// and the type of data will be the parameter type of class

class Data<T> {
  final int statusCode;
  final String message;
  final T data;

  const Data({
    this.message = 'Data not found',
    this.data,
    this.statusCode,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    T _data;
    if (json['statusCode'] == 200) {
      _data = json['data'];
    }
    String _message = '';
    if (json['message'] is String) {
      _message = json['message'];
    } else if (json['message'] is Map) {
      if (json['message'].entries.first.value is List) {
        _message = '${json['message'].entries.first.value.first}';
      }
    } else {
      _message = json['message']?.toString();
    }
    return Data<T>(
      statusCode: json['statusCode'],
      message: _message,
      data: _data,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': statusCode,
      'message': message,
      'data': data,
    };
  }

  // Copy with existing data
  Data<T> copyWith<T>({
    int statusCode,
    String message,
    T data,
  }) =>
      Data<T>(
        data: data ?? this.data,
        message: message ?? this.message,
        statusCode: statusCode ?? this.statusCode,
      );
}





