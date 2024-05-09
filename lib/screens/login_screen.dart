import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_auth.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Đăng nhập",
                style: TextStyle(
                  fontFamily: 'bold',
                  color: Colors.primary,
                  fontSize: 34.0,
                ),
              ),
              SizedBox(height: 150.0),
              TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 16.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(
                  hintText: "Mật khẩu",
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 16.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Text(
                    "Bạn chưa có tài khoản? ",
                    style: TextStyle(
                      fontFamily: 'medium',
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    "Đăng kí",
                    style: TextStyle(
fontFamily: 'bold',
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                "Quên mật khẩu",
                style: TextStyle(
                  fontFamily: 'medium',
                  color: Colors.black,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                onPressed: () {},
                color: Colors.blue,
                child: Text(
                  "Đăng nhập",
                  style: TextStyle(
                    fontFamily: 'medium',
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}