class User {
  final int id;
  final String name;
  final String mobile;
  final String image;
  final String token;

  User(
      {required this.id,
      required this.name,
      required this.mobile,
      required this.image,
      required this.token,});
  factory User.fromJson(Map<String, dynamic> json, {String? token}) => User(
        id: json['id'],
        name: json['name'],
        mobile: json['mobile'],
        image: json['image'],
        token: json['token']??token??''
      );
}
