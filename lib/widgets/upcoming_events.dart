import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efficacy_admin/Pages/edit_event.dart';
import 'package:efficacy_admin/utils/bottom_sheet_only_buttons.dart';
import 'package:efficacy_admin/utils/bottom_sheet_with_data.dart';
import 'package:efficacy_admin/utils/loading_screen.dart';
import 'package:efficacy_admin/Pages/add_edit_screen.dart';
import 'package:efficacy_admin/Pages/event_detail.dart';
import 'package:efficacy_admin/provider/event_provider.dart';
import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:efficacy_admin/widgets/event_detatils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Upcoming extends StatefulWidget {
  final String id;
  const Upcoming({Key? key, required this.id}) : super(key: key);

  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  List data = [];
  bool isloading = false;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    setState(() {
      isloading = true;
    });
    final middata = await Provider.of<EventProvider>(context, listen: false)
        .fetchEvents([widget.id]);
    data = json.decode(middata);
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? const LoadingScreen()
        : Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.299,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        child: EventCard(
                          // onTapData: showCustomBottomSheet(context),
                          detail: data[index],
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventDetail(
                                  detail: data[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      onLongPress: () =>
                          showCustomBottomSheetWithDeleteAndEditButtons(
                              context: context,
                              onEditTap: () {
                                Navigator.pop(context);
                                showBottomSheetWithData(context);
                                print('-------------------edit trigger');
                              },
                              onDeleteTap: () {
                                print('----deleting triggered');
                              }),
                      // onLongPress: () {
                      //   showModalBottomSheet(
                      //     context: context,
                      //     isScrollControlled: true,
                      //     builder: (BuildContext context) => Container(
                      //       color: const Color(0xff757575),
                      //       child: Container(
                      //         height:
                      //             (MediaQuery.of(context).size.height) / 4.4,
                      //         decoration: const BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(20.0),
                      //             topRight: Radius.circular(20.0),
                      //           ),
                      //         ),
                      //         child: Column(
                      //           children: [
                      //             const SizedBox(
                      //               height: 20.0,
                      //               width: 100.0,
                      //               child: Divider(
                      //                 color: Colors.black87,
                      //                 thickness: 2,
                      //               ),
                      //             ),
                      //             GestureDetector(
                      //               onTap: () {
                      //                 FirebaseFirestore.instance
                      //                     .collection('Events')
                      //                     .doc(data[index]['eventID'])
                      //                     .delete();
                      //                 FirebaseStorage.instance
                      //                     .refFromURL(data[index]['posterURL'])
                      //                     .delete();
                      //               },
                      //               child: ListTile(
                      //                 leading: Icon(
                      //                   Icons.delete,
                      //                   color: AppColorLight.primary,
                      //                 ),
                      //                 title: Text(
                      //                   'Delete',
                      //                   style: TextStyle(
                      //                     color: AppColorLight.primary,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             GestureDetector(
                      //               onTap: () {
                      //                 Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                     builder: (context) => EditEvent(
                      //                       detail: data[index],
                      //                     ),
                      //                   ),
                      //                 );
                      //               },
                      //               child: ListTile(
                      //                 leading: Icon(
                      //                   Icons.edit,
                      //                   color: AppColorLight.primary,
                      //                 ),
                      //                 title: Text(
                      //                   'Edit',
                      //                   style: TextStyle(
                      //                     color: AppColorLight.primary,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   );
                      // },
                    );
                  },
                ),
              ),
            ],
          );
  }
}
