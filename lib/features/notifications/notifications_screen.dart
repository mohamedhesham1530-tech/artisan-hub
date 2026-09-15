import 'package:flutter/material.dart';
import '../../data/notification_data.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState
    extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Notifications",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: NotificationData
              .notifications
              .isEmpty
          ? const Center(
              child: Text(
                "No Notifications",
              ),
            )
          : ListView.builder(
              padding:
                  const EdgeInsets.all(20),

              itemCount:
                  NotificationData
                      .notifications
                      .length,

              itemBuilder:
                  (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.only(
                    bottom: 12,
                  ),

                  decoration:
                      BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius
                            .circular(20),
                  ),

                  child: ListTile(
                    leading:
                        const CircleAvatar(
                      backgroundColor:
                          Color(
                        0xff2563EB,
                      ),

                      child: Icon(
                        Icons
                            .notifications,
                        color: Colors
                            .white,
                      ),
                    ),

                    title: Text(
                      NotificationData
                              .notifications[
                          index],
                    ),

                    trailing:
                        IconButton(
                      icon:
                          const Icon(
                        Icons.delete,
                        color:
                            Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          NotificationData
                              .notifications
                              .removeAt(
                                  index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}