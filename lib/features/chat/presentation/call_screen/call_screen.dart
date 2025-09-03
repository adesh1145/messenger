// lib/call_screen/call_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as WebRTC;
import 'package:get/get.dart';
import 'package:messenger/core/utils/enums.dart';

import 'call_controller.dart';

class CallScreen extends GetView<CallController> {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          await controller.leaveCall();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Obx(() {
            // Loading state
            if (controller.isLoading.value) {
              return _buildLoadingScreen();
            }

            // Build video tiles
            return _buildCallInterface();
          }),
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Container(
      color: Colors.black,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 2,
            ),
            SizedBox(height: 24),
            Text(
              'Initializing call...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please wait while we connect you',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallInterface() {
    final tiles = <Widget>[];

    // Local video tile (always show if stream is ready)
    if (controller.isLocalStreamReady.value) {
      tiles.add(
        _buildVideoTile(
          renderer: controller.localRenderer,
          label: "You",
          isLocal: true,
        ),
      );
    }

    // Remote video tiles
    for (final entry in controller.remoteRenderers.entries) {
      tiles.add(
        _buildVideoTile(
          renderer: entry.value,
          label: _getParticipantName(entry.key),
          isLocal: false,
          participantId: entry.key,
        ),
      );
    }

    // Show waiting screen if no participants
    if (tiles.isEmpty) {
      return _buildWaitingScreen();
    }

    return Stack(
      children: [
        // Video grid
        _buildVideoGrid(tiles),

        // Top info bar
        _buildTopInfoBar(),

        // Bottom control bar
        _buildBottomControlBar(),

        // Connection status indicator
        _buildConnectionStatus(),
      ],
    );
  }

  Widget _buildWaitingScreen() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Icon(
                  Icons.people_outline,
                  size: 60,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Waiting for others to join...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Room ID: ${controller.roomId ?? 'Unknown'}',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 16),
              if (controller.isLocalStreamReady.value)
                const Text(
                  'Your camera is ready',
                  style: TextStyle(color: Colors.green, fontSize: 14),
                ),
            ],
          ),
        ),
        _buildTopInfoBar(),
        _buildBottomControlBar(),
      ],
    );
  }

  Widget _buildVideoGrid(List<Widget> tiles) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = tiles.length;
        final config = _getGridConfig(count);

        return Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(
            top: 80, // Space for top bar
            bottom: 100, // Space for bottom bar
            left: 8,
            right: 8,
          ),
          child: _buildGridView(tiles, config, constraints),
        );
      },
    );
  }

  Widget _buildGridView(
    List<Widget> tiles,
    _GridConfig config,
    BoxConstraints constraints,
  ) {
    final availableWidth = constraints.maxWidth - 16; // Account for padding
    final availableHeight =
        constraints.maxHeight - 180; // Account for top and bottom bars

    if (tiles.length == 1) {
      // Single participant - full screen
      return Center(
        child: AspectRatio(aspectRatio: 9 / 16, child: tiles.first),
      );
    } else if (tiles.length == 2) {
      // Two participants - vertical split
      return Column(
        children: [
          Expanded(child: tiles[0]),
          const SizedBox(height: 8),
          Expanded(child: tiles[1]),
        ],
      );
    } else {
      // Multiple participants - grid layout
      final itemWidth = (availableWidth / config.columns) - 8;
      final itemHeight = itemWidth * 9 / 16;

      return SingleChildScrollView(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tiles
              .map(
                (tile) =>
                    SizedBox(width: itemWidth, height: itemHeight, child: tile),
              )
              .toList(),
        ),
      );
    }
  }

  Widget _buildVideoTile({
    required WebRTC.RTCVideoRenderer renderer,
    required String? label,
    required bool isLocal,
    String? participantId,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[900],
        border: isLocal
            ? Border.all(color: Colors.blue.withOpacity(0.6), width: 2)
            : Border.all(color: Colors.white12, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Video view
          _buildVideoView(renderer, isLocal),

          // Overlay for disabled camera
          if (isLocal && !controller.isCamOn.value) _buildCameraOffOverlay(),

          // Name label
          _buildNameLabel(label, isLocal),

          // Audio indicator
          if (isLocal) _buildAudioIndicator(),

          // Connection quality indicator (for remote)
          if (!isLocal && participantId != null)
            _buildConnectionQuality(participantId),
        ],
      ),
    );
  }

  Widget _buildVideoView(WebRTC.RTCVideoRenderer renderer, bool isLocal) {
    return Container(
      color: Colors.grey[900],
      child: WebRTC.RTCVideoView(
        renderer,
        mirror: isLocal,
        objectFit: WebRTC.RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        placeholderBuilder: (context) => Container(
          color: Colors.grey[900],
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isLocal ? Icons.person : Icons.person_outline,
                  size: 60,
                  color: Colors.white38,
                ),
                const SizedBox(height: 8),
                Text(
                  isLocal ? 'Your video' : 'Loading video...',
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCameraOffOverlay() {
    return Container(
      color: Colors.black87,
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.videocam_off, size: 48, color: Colors.white70),
            SizedBox(height: 8),
            Text(
              'Camera is off',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameLabel(String? label, bool isLocal) {
    return Positioned(
      left: 12,
      bottom: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isLocal ? Colors.blue.withOpacity(0.6) : Colors.white24,
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLocal) const Icon(Icons.person, size: 14, color: Colors.blue),
            if (isLocal) const SizedBox(width: 4),
            Text(
              label ?? 'Participant',
              style: TextStyle(
                color: isLocal ? Colors.blue : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAudioIndicator() {
    return Positioned(
      right: 12,
      bottom: 12,
      child: Obx(
        () => Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: controller.isMicOn.value
                ? Colors.green.withOpacity(0.8)
                : Colors.red.withOpacity(0.8),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            controller.isMicOn.value ? Icons.mic : Icons.mic_off,
            size: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionQuality(String participantId) {
    return Positioned(
      right: 12,
      top: 12,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Icon(
          Icons.signal_cellular_4_bar,
          size: 16,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _buildTopInfoBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              // Back button
              IconButton(
                onPressed: () async {
                  await controller.leaveCall();
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              const SizedBox(width: 12),

              // Room info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Video Call',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Obx(
                      () => Text(
                        '${controller.participants.length} participant${controller.participants.length != 1 ? 's' : ''}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => controller.callState.value == CallState.connected
                    ? _buildCallDuration()
                    : Text(
                        controller.callState.value == CallState.ended ||
                                controller.callState.value == CallState.failed
                            ? 'Call ended'
                            : controller.callState.value == CallState.ringing
                            ? 'Ringing...'
                            : controller.callState.value == CallState.connecting
                            ? "Connecting..."
                            : controller.callState.value == CallState.rejected
                            ? "Call Rejected"
                            : controller.callState.value == CallState.connected
                            ? "Connected"
                            : "Calling...",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCallDuration() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.access_time, size: 14, color: Colors.white70),
          SizedBox(width: 4),
          Text(
            '00:00',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControlBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.9), Colors.transparent],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Mic toggle
              Obx(
                () => _buildControlButton(
                  onPressed: controller.toggleMic,
                  icon: controller.isMicOn.value ? Icons.mic : Icons.mic_off,
                  isActive: controller.isMicOn.value,
                  tooltip: controller.isMicOn.value ? 'Mute' : 'Unmute',
                ),
              ),

              // Camera toggle
              Obx(
                () => _buildControlButton(
                  onPressed: controller.toggleCamera,
                  icon: controller.isCamOn.value
                      ? Icons.videocam
                      : Icons.videocam_off,
                  isActive: controller.isCamOn.value,
                  tooltip: controller.isCamOn.value
                      ? 'Turn off camera'
                      : 'Turn on camera',
                ),
              ),

              // Switch camera
              _buildControlButton(
                onPressed: controller.switchCamera,
                icon: Icons.flip_camera_ios,
                isActive: true,
                tooltip: 'Switch camera',
              ),

              // End call
              _buildEndCallButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required VoidCallback onPressed,
    required IconData icon,
    required bool isActive,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: isActive
              ? Colors.white.withOpacity(0.2)
              : Colors.red.withOpacity(0.8),
          shape: BoxShape.circle,
          border: Border.all(
            color: isActive ? Colors.white.withOpacity(0.3) : Colors.red,
            width: 1,
          ),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          color: Colors.white,
          iconSize: 24,
        ),
      ),
    );
  }

  Widget _buildEndCallButton() {
    return Tooltip(
      message: 'End call',
      child: Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () async {
            await controller.leaveCall();
          },
          icon: const Icon(Icons.call_end),
          color: Colors.white,
          iconSize: 28,
        ),
      ),
    );
  }

  Widget _buildConnectionStatus() {
    return Positioned(
      top: 90,
      right: 16,
      child: Obx(() {
        if (!controller.isLocalStreamReady.value) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning, size: 14, color: Colors.white),
                SizedBox(width: 4),
                Text(
                  controller.callState.value == CallState.ended ||
                          controller.callState.value == CallState.failed
                      ? 'Call ended'
                      : controller.callState.value == CallState.ringing
                      ? 'Ringing...'
                      : controller.callState.value == CallState.connecting
                      ? "Connecting..."
                      : controller.callState.value == CallState.rejected
                      ? "Call Rejected"
                      : controller.callState.value == CallState.connected
                      ? "Connected"
                      : "Calling...",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  String? _getParticipantName(String participantId) {
    final participant = controller.participants.firstWhereOrNull(
      (p) => p.uid == participantId,
    );
    return participant?.name ?? 'Remote User';
  }

  _GridConfig _getGridConfig(int count) {
    if (count <= 1) return const _GridConfig(columns: 1);
    if (count == 2) return const _GridConfig(columns: 1);
    if (count <= 4) return const _GridConfig(columns: 2);
    if (count <= 9) return const _GridConfig(columns: 3);
    return const _GridConfig(columns: 4);
  }
}

class _GridConfig {
  final int columns;
  const _GridConfig({required this.columns});
}
