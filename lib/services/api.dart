import 'dart:convert';
import 'dart:developer';

import 'package:developer_challenge_schedule/common/utils.dart';
import 'package:developer_challenge_schedule/constants/global.dart';
import 'package:developer_challenge_schedule/models/datamodels.dart';
import 'package:developer_challenge_schedule/widgets/custom_button.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

class SchedulerApi {
  postSchedule(
    BuildContext context,
    String start,
    end,
    date,
    name,
  ) async {
    try {
      var url = Uri.parse(
          'https://alpha.classaccess.io/api/challenge/v1/save/schedule');
      var response = await http.post(url, body: {
        "name": name,
        "startTime": start,
        "endTime": end,
        "date": date,
        "phoneNumber": phoneNum
      });
      var r = json.decode(response.body);
      if (r['success'] == false) {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.yellow,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          builder: (BuildContext context) {
            return SizedBox(
              height: 300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'This overlaps with another schedule and cant be saved',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w700),
                    ),
                    const Text(
                      'This overlaps with another schedule and cant be saved',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w400),
                    ),
                    CustomButton(
                      text: 'Okey',
                      color: Colors.blue,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            );
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List> getSchedule() async {
    List data = [];
    try {
      var url = Uri.parse(
          'https://alpha.classaccess.io/api/challenge/v2/schedule/$phoneNum');
      var response = await http.get(url);

      var r = json.decode(response.body);
      data = r['data'];
    } catch (e) {
      log(e.toString());
      //
    }
    return data;
  }
}
