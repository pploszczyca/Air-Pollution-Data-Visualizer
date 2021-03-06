import 'package:flutter_dotenv/flutter_dotenv.dart';

final backendURL = dotenv.env['APDV_BACKEND_URL'] ?? 'http://localhost:5000/';     // For Android Emulator use: 'http://10.0.2.2:5000/'
const getDataSummaryURL = 'sensor/list';
const getEndpointDataURL= 'sensor';
const getFieldEnable = 'field/enable';
