class UserModel
{
  String? email;
  String? name;
  String? phone;
  String? uId;
  String? image;
  String? cover;

  UserModel({
    this.email,
    this.phone,
    this.name,
    this.uId,
    this.image,
    this.cover,
  });

  UserModel.fromJson(Map<String,dynamic>? json)
  {
    email= json!['email'];
    phone= json['phone'];
    name= json['name'];
    uId= json['uId'];
    image= json['image'];
    cover= json['cover'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'email':email,
      'phone': phone,
      'name':name,
      'uId':uId,
      'image':image,
      'cover':cover,
    };
  }
}