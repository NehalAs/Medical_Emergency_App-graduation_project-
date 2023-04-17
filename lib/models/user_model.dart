class UserModel
{
  String? email;
  String? name;
  String? phone;
  String? uId;

  UserModel({
    this.email,
    this.phone,
    this.name,
    this.uId,
  });

  UserModel.fromJson(Map<String,dynamic>? json)
  {
    email= json!['email'];
    phone= json['phone'];
    name= json['name'];
    uId= json['uId'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'email':email,
      'phone': phone,
      'name':name,
      'uId':uId,
    };
  }
}