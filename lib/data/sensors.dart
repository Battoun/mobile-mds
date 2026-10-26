import '../models/sensor.dart';

// Pour l'étape 1, les capteurs sont écrits en dur ici.
// Plus tard, ils viendront d'une API ou d'une base de données.
const List<Sensor> kSensors = [
  Sensor(
    id: '1',
    name: 'Salon',
    temperature: 21.8,
    humidity: 45,
    isOnline: true,
    battery: 82,
    state: 'OK',
    lastMeasurement: 'Il y a 2 min',
  ),
  Sensor(
    id: '2',
    name: 'Garage',
    temperature: 29.6,
    humidity: 61,
    isOnline: true,
    battery: 45,
    state: 'Alerte',
    lastMeasurement: 'Il y a 5 min',
  ),
  Sensor(
    id: '3',
    name: 'Chambre',
    temperature: 18.2,
    humidity: 50,
    isOnline: false,
    battery: 12,
    state: 'Hors ligne',
    lastMeasurement: 'Il y a 3 h',
  ),
];

Sensor? findSensorById(String id) {
  for (final sensor in kSensors) {
    if (sensor.id == id) return sensor;
  }
  return null;
}
