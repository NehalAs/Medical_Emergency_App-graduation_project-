class HospitalModel
{
  String? email;
  String? name;
  String? phone;
  String? uId;
  String? image;
  String? cover;
  String? userType;
  String? APos;
  String? ANag;
  String? BPos;
  String? BNag;
  String? ABPos;
  String? ABNag;
  String? OPos;
  String? ONag;


  HospitalModel({
    this.email,
    this.phone,
    this.name,
    this.uId,
    this.image,
    this.cover,
    this.userType,
    this.APos,
    this.ANag,
    this.BPos,
    this.BNag,
    this.ABPos,
    this.ABNag,
    this.OPos,
    this.ONag,
  });

  HospitalModel.fromJson(Map<String,dynamic>? json)
  {
    email= json!['email'];
    phone= json['phone'];
    name= json['name'];
    uId= json['uId'];
    image= json['image'];
    cover= json['cover'];
    userType= json['userType'];
    APos= json!['A+'];
    ANag= json!['A-'];
    BPos= json!['B+'];
    BNag= json!['B-'];
    ABPos=json!['AB+'];
    ABNag=json!['AB-'];
    OPos=json!['O+'];
    ONag=json!['O-'];
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
      'userType':userType,
      'A+':APos,
      'A-': ANag,
      'B+':BPos,
      'B-':BNag,
      'AB+':ABPos,
      'AB-':ABNag,
      'O+':OPos,
      'O-':ONag,
    };
  }
}