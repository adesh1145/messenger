import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

// Handle FCM in background (when app is terminated/background)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Expect a custom data payload your server sends
  final data = message.data;
  if (data['type'] == 'incoming_call') {
    await _showIncomingCallFromPush(data);
  }
}

Future<void> _showIncomingCallFromPush(Map<String, dynamic> data) async {
  final uuid =
      data['call_id'] ?? DateTime.now().millisecondsSinceEpoch.toString();
  final name = data['caller_name'] ?? 'Unknown';
  final avatar = data['avatar'] ?? '';
  final isVideo = (data['is_video']?.toString() ?? 'false') == 'true';

  final params = <String, dynamic>{
    'id': uuid,
    'nameCaller': name,
    'appName': 'My Flutter Call App',
    'avatar': avatar, // network image or empty
    'handle': data['handle'] ?? '+0000000000',
    'type': isVideo ? 1 : 0, // 0=audio, 1=video
    'duration': 30000, // time to auto end if unanswered (ms)
    'textAccept': 'Accept',
    'textDecline': 'Decline',
    'missedCallNotification': {'show': true, 'subtitle': 'Missed'},
    'extra': {
      'room_id': data['room_id'] ?? 'room-123',
      'token': data['token'] ?? '',
    },
    'android': {
      'isCustomNotification': true,
      'isShowLogo': false,
      'ringtonePath': 'system_ringtone_default',
      'backgroundColor': '#0955fa',
      'actionColor': '#4CAF50',
      'incomingCallNotificationChannelName': 'Incoming Call',
      'missedCallNotificationChannelName': 'Missed Call',
      'fullScreenIntent': true,
      'showFullScreenIntent': true,
      'answerAfterSeconds': 0,
    },
    'ios': {
      'iconName': 'AppIcon40x40',
      'supportsVideo': true,
      'maximumCallGroups': 1,
      'maximumCallsPerCallGroup': 1,
      'audioSessionMode': 'default',
      'audioSessionActive': true,
      'audioSessionPreferredSampleRate': 44100.0,
      'audioSessionPreferredIOBufferDuration': 0.005,
      'supportsDTMF': true,
      'supportsHolding': true,
      'supportsGrouping': false,
      'supportsUngrouping': false,
      'ringtonePath': 'Ringtone.caf',
    },
  };

  await FlutterCallkitIncoming.showCallkitIncoming(
    CallKitParams.fromJson(params),
  );
}

Future<void> _endCall(String id) async {
  await FlutterCallkitIncoming.endCall(id);
}

Future<void> _startCallUI(Map<String, dynamic> extra) async {
  // Navigate to your in‑call screen, join RTC room, etc.
  // This example just shows a placeholder.
}

void _listenCallEvents() {
  FlutterCallkitIncoming.onEvent.listen((event) async {
    final name = event!.event; // e.g. Event.actionCallAccept
    final body = event.body ?? {};
    final id = body['id']?.toString() ?? '';

    switch (name) {
      case Event.actionCallAccept:
        await FlutterCallkitIncoming.setCallConnected(id);
        await _startCallUI(body['extra'] ?? {});
        break;
      case Event.actionCallDecline:
      case Event.actionCallEnded:
        await _endCall(id);
        break;
      case Event.actionCallTimeout:
        await _endCall(id);
        break;
      default:
        break;
    }
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Ask notification permission (iOS + Android 13+)
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    provisional: false,
  );

  // Set background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _token;

  @override
  void initState() {
    super.initState();
    _initFCM();
    _listenCallEvents();

    // Foreground message handler
    FirebaseMessaging.onMessage.listen((message) async {
      final data = message.data;
      if ((data['type'] ?? '') == 'incoming_call') {
        await _showIncomingCallFromPush(data);
      }
    });

    // App opened from notification tap
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      // If user tapped when incoming call is ringing, you could show UI
    });
  }

  Future<void> _initFCM() async {
    _token = await FirebaseMessaging.instance.getToken();
    debugPrint('FCM token: $_token');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('WhatsApp‑style Incoming Call')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your FCM token (send a test push with this):'),
              const SizedBox(height: 8),
              SelectableText(_token ?? 'Fetching…'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  // Local test trigger without FCM
                  await _showIncomingCallFromPush({
                    'type': 'incoming_call',
                    'caller_name': 'Rahul',
                    'handle': '+91 99999 99999',
                    'is_video': 'true',
                    'room_id': 'demo-room',
                  });
                },
                child: const Text('Test Incoming Call (Local)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
