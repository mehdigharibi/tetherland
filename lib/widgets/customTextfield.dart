import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tetherlandclone/helper/numberHelper.dart';
import 'package:tetherlandclone/service/apiProvider.dart';

import '../helper/constants.dart';

class customTextfield extends StatefulWidget {
  String hintTex;
  String boxHinttext;
  TextEditingController controller;
  bool focusNode;
  customTextfield(
      {super.key,
      required this.hintTex,
      required this.boxHinttext,
      required this.controller,
      required this.focusNode});

  @override
  State<customTextfield> createState() => _customTextfieldState();
}

class _customTextfieldState extends State<customTextfield> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, textProvider, child) {
      return Container(
        padding: EdgeInsets.only(left: 3, right: 3),
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(
                width: 1,
                color: (widget.focusNode)
                    ? btnGold
                    : Colors.grey.withOpacity(0.5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 70,
              height: 38,
              color: grayColor,
              child: Center(
                child: Text(
                  widget.boxHinttext,
                  style: TextStyle(
                      fontFamily: 'Anjoman',
                      color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: FocusScope(
                  child: Focus(
                    onFocusChange: (value) {
                      setState(() {
                        widget.focusNode = value;
                      });
                    },
                    child: TextField(
                      onChanged: (value) async {
                        if (value.isEmpty) {
                          Provider.of<apiProvider>(context, listen: false)
                              .toman
                              .clear();
                        }
                        int? calc = await Provider.of<apiProvider>(context,
                                listen: false)
                            .calculateToman()
                            .then((value) {
                          print(value);
                          Provider.of<apiProvider>(context, listen: false)
                              .toman
                              .text = separateThousands((int.parse(
                                      value.toString()) *
                                  int.parse(widget.controller.text.toString()))
                              .toString());
                        });
                      },
                      maxLength: 6,
                      //  inputFormatters: [ThousandsSeparatorInputFormatter()],
                      keyboardType: TextInputType.number,
                      controller: widget.controller,
                      style: TextStyle(fontFamily: 'Anjoman'),
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          counterText: '',
                          hintTextDirection: TextDirection.rtl,
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(fontFamily: 'Anjoman', fontSize: 13),
                          hintText: widget.hintTex),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
