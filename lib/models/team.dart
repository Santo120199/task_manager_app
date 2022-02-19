
class Team {
  int? id;
  String? name;
  int? createdBy;

  Team({this.id,this.name,this.createdBy});

  factory Team.fromJson(Map<String,dynamic> item){
    
    return Team(
      id: int.parse(item['id']),
      name: item['username'],
      createdBy: item['email'],
    );
  }

   Map<String,dynamic> toJson(){
    final Map<String,dynamic> item = new Map<String,dynamic>();
    item['name'] = this.name;
    item['createdBy'] = this.createdBy;
    return item;
  }

}