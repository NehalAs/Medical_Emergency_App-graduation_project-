class RequestModel
{
 String? senderId;
 String? receiverId;
 String? dateTime;
 bool? isAccepted;
 String? bloodType;
 String? text;



 RequestModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.isAccepted,
    this.bloodType,
    this.text,
 });

 RequestModel.fromJson(Map<String,dynamic>? json)
 {
   senderId= json!['senderId'];
   receiverId= json['receiverId'];
   dateTime= json['dateTime'];
   isAccepted= json['isAccepted'];
   bloodType= json['bloodType'];
   text= json['text'];
 }

 Map<String,dynamic> toMap()
{
   return {
     'senderId':senderId,
     'receiverId': receiverId,
     'dateTime':dateTime,
     'isAccepted':isAccepted,
     'bloodType':bloodType,
     'text':text,
   };
}
}