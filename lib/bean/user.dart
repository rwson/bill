class UserBean {

  final String title; 
  final String poster; 

  UserBean({this.title, this.poster});

  factory UserBean.fromJson(Map<String, dynamic> json) {
    return UserBean(
      title: json['Title'], 
      poster: json['Poster']
    );
  }

}