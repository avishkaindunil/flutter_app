import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class TakePhotoPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const TakePhotoPage({Key? key, required this.cameras}) : super(key: key);

  @override
  State<TakePhotoPage> createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  late CameraController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.cameras.isNotEmpty) {
      _controller = CameraController(
        widget.cameras[0],
        ResolutionPreset.medium,
        enableAudio: false,
      );
      _controller.initialize().then((_) {
        if (!mounted) return;
        setState(() {
          _isInitialized = true;
        });
      });
    }
  }

  @override
  void dispose() {
    if (_isInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final previewHeight = constraints.maxHeight * 0.75;
        return Column(
          children: [
            if (!_isInitialized)
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else
              Container(
                height: previewHeight,
                width: constraints.maxWidth,
                color: Colors.black,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: CameraPreview(_controller),
                ),
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: _isInitialized
                  ? () async {
                try {
                  final file = await _controller.takePicture();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Saved to ${file.path}')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: \$e')),
                  );
                }
              }
                  : null,
              child: const Text('CAPTURE'),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
