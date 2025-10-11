class UserModel{
  String email;
  String uid;
  String role;

  UserModel({required this.email, required this.uid, required this.role});

  Map<String , dynamic> toMap()=> {'email':email,'uid':uid,'role':role};

  factory UserModel.fromMap(Map<String , dynamic> map)=> UserModel(email: map['email'], uid: map['uid'], role: map['role']);
}