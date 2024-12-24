// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';

// class FaceDetectionCamera extends StatefulWidget {
//   const FaceDetectionCamera({super.key});

//   @override
//   _FaceDetectionCameraState createState() => _FaceDetectionCameraState();
// }

// class _FaceDetectionCameraState extends State<FaceDetectionCamera> {
//   CameraController? _controller;
//   Future<void>? _initializeControllerFuture;
//   final FaceDetector _faceDetector = GoogleMlKit.vision.faceDetector();
//   List<Face> _faces = [];

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     final firstCamera = cameras.first;

//     _controller = CameraController(
//       firstCamera,
//       ResolutionPreset.high,
//     );

//     _initializeControllerFuture = _controller?.initialize();
//     await _initializeControllerFuture;

//     // Start the image stream
//     _controller?.startImageStream((CameraImage image) {
//       _detectFaces(image);
//     });
//   }

//   Future<void> _detectFaces(CameraImage image) async {
//     final inputImage = _convertCameraImage(image);
//     final faces = await _faceDetector.processImage(inputImage);

//     setState(() {
//       _faces = faces;
//     });
//   }

//   InputImage _convertCameraImage(CameraImage image) {
//     // Convert CameraImage to InputImage format
//     final WriteBuffer allBytes = WriteBuffer();
//     for (final plane in image.planes) {
//       allBytes.putUint8List(plane.bytes);
//     }
//     final bytes = allBytes.done().buffer.asUint8List();

//     final inputImageData = InputImageData(
//       bytes: bytes,
//       height: image.height,
//       width: image.width,
//       rotation:
//           InputImageRotation.rotation0deg, // Adjust based on your camera setup
//       // Use the appropriate format based on the image
//       // Use InputImageFormat.yuv_420 or InputImageFormat.nv21, etc.
//       format: InputImageFormat.nv21, // Example format; change as needed
//     );

//     return InputImage.fromBytes(
//       bytes: bytes,
//       inputImageData: inputImageData,
//     );
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     _faceDetector.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Face Detection')),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Stack(
//               children: [
//                 CameraPreview(_controller!),
//                 CustomPaint(
//                   painter: FacePainter(faces: _faces),
//                 ),
//               ],
//             );
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

// class FacePainter extends CustomPainter {
//   final List<Face> faces;

//   FacePainter({required this.faces});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.red
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;

//     for (Face face in faces) {
//       final rect = face.boundingBox;
//       canvas.drawRect(
//           Rect.fromLTRB(rect.left, rect.top, rect.right, rect.bottom), paint);
//     }
//   }

//   @override
//   bool shouldRepaint(FacePainter oldDelegate) {
//     return oldDelegate.faces != faces;
//   }
// }
