class UserModel
{
  String? email;
  String? name;
  String? phone;
  String? uId;
  String? image;
  String? cover;
  String? location;
  String? country;
  String? city;
  String? governorate;
  String? bloodType;
  String? userType;

  UserModel({
    this.email,
    this.phone,
    this.name,
    this.uId,
    this.image,
    this.cover,
    this.location,
    this.country,
    this.city,
    this.governorate,
    this.bloodType,
    this.userType,
  });

  UserModel.fromJson(Map<String,dynamic>? json)
  {
    email= json!['email'];
    phone= json['phone'];
    name= json['name'];
    uId= json['uId'];
    image= json['image'];
    cover= json['cover'];
    location= json['location'];
    country= json['country'];
    city= json['city'];
    governorate= json['governorate'];
    bloodType= json['bloodType'];
    userType= json['userType'];
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
      'location':location,
      'country':country,
      'city':city,
      'governorate':governorate,
      'bloodType':bloodType,
      'userType':userType,
    };
  }
}