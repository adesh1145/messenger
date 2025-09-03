// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import '../../../features/chat/presentation/chat_screen/chat_screen.dart';
import '../../widget/colors.dart';
import '../../widget/text.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
// import 'package:contacts_service/contacts_service.dart';

class ContactListPageUi extends StatefulWidget {
  const ContactListPageUi({super.key});

  @override
  State<ContactListPageUi> createState() => _ContacListPageUiState();
}

class _ContacListPageUiState extends State<ContactListPageUi> {
  @override
  void initState() {
    super.initState();
    getContactPermission();
  }

  final messageController = TextEditingController();
  final _listViewController = ScrollController();
  String? message;
  // List<Contact> allContacts = [];
  bool isLoading = true;
  String warningMessage = "";
  void getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      fetchContacts();
    } else {
      await Permission.contacts.request();
      if (await Permission.contacts.isGranted) {
        fetchContacts();
      } else {
        warningMessage = "Please Give Contact Permission.\n Go Settings";
        setState(() {});
      }
    }
  }

  void fetchContacts() async {
    // allContacts = await ContactsService.getContacts();
    isLoading = false;
    setState(() {});
  }

  // String checkNumberisExistInContact(index) {
  //   try {
  //     return allContacts[index].phones![0].value!;
  //   } catch (e) {
  //     return "";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 70,
                width: MediaQuery.of(context).size.width,
                color: blueColor7,
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.06,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: TextWidget(
                            text: "Select Contact",
                            textcolor: Colors.white,
                            fontweight: FontWeight.w500,
                            fontsize: MediaQuery.of(context).size.width * 0.06,
                          ),
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(0),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactListPageUi(),
                              ),
                            );
                          });
                        },
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.06,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.refresh),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 70,
              left: 0,
              child: Container(
                color: blueColor7,
                child: Container(
                  height:
                      MediaQuery.of(context).size.height -
                      100 -
                      MediaQuery.of(context).viewInsets.bottom,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    gradient: gradientColor,
                  ),
                  child: Container(
                    height:
                        MediaQuery.of(context).size.height -
                        100 -
                        15 -
                        55 -
                        10 -
                        MediaQuery.of(context).viewInsets.bottom -
                        59,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: isLoading == true
                        ? Center(
                            child:
                                warningMessage ==
                                    "Please Give Contact Permission.\n Go Settings"
                                ? TextWidget(text: warningMessage)
                                : CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            controller: _listViewController,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.only(top: 10),
                                child: InkWell(
                                  onTap: () {},
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatScreen(),
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      padding:
                                          WidgetStateProperty.all<EdgeInsets>(
                                            EdgeInsets.zero,
                                          ),
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: blueColor7,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'assets/images/client.png',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      title: TextWidget(
                                        text: "",
                                        //  "${allContacts[index].displayName}",
                                        fontweight: FontWeight.w500,
                                      ),
                                      subtitle: TextWidget(
                                        text: "",
                                        // checkNumberisExistInContact(index)
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: 0,
                            // allContacts.length,
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
