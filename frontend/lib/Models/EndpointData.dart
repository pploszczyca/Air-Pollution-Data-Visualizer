class EndpointData{
  late double temperature;
  late double pressure;
  late double humidity;
  late double pm1_0;
  late double pm2_5;
  late double pm10;
  late DateTime date;

  EndpointData(this.temperature, this.pressure, this.humidity, this.pm1_0,
      this.pm2_5, this.pm10, this.date);
}