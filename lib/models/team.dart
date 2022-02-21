
class Team {
  int? id;
  String? name;
  int? createdBy;
  String? users;

  Team({this.id,this.name,this.createdBy,this.users});

  factory Team.fromJson(Map<String,dynamic> item){
    
    return Team(
      id: int.parse(item['id']),
      name: item['name'],
      createdBy: int.parse(item['createdBy']),
      users: item['users']
    );
  }

   Map<String,dynamic> toJson(){
    final Map<String,dynamic> item = new Map<String,dynamic>();
    item['name'] = this.name;
    item['createdBy'] = this.createdBy;
    return item;
  }

}