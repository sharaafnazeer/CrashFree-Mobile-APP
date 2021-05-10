import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String buttonText;
  final Function onBtnPressed;

  const CustomButton({Key key, this.buttonText, this.onBtnPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(buttonText, style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(width: 10,),
                          Icon(Icons.arrow_forward,)
                        ],
                      ),
                    ),
                    onPressed : onBtnPressed,
                  color: Theme.of(context).primaryColor,);
  }

}