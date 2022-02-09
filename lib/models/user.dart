
class User {
  int? id;
  String? username;
  String? email;
  String? password;

  User({this.id,this.username,this.email,this.password});

  factory User.fromJson(Map<String,dynamic> item){
    
    return User(
      id: int.parse(item['id']),
      username: item['username'],
      email: item['email'],
      password: item['password'],
    );
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> item = new Map<String,dynamic>();
    item['id'] = this.id;
    item['username'] = this.username;
    item['email'] = this.email;
    item['password'] = this.password;

    return item;
  }


  

}