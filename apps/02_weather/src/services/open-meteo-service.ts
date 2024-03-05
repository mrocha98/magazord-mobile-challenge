import { OpenMeteoResponse } from "../types/open-meteo-response";
import { WeatherReport } from "../types/weather-report";

export class OpenMeteoService {
  async getReport(latitude: number, longitude: number): Promise<WeatherReport> {
    const url = `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,precipitation,rain&forecast_days=1`;
    const response = await fetch(url);
    const { current: json } = (await response.json()) as OpenMeteoResponse;
    return {
      temperature: json.temperature_2m,
      apparentTemperature: json.apparent_temperature,
      humidity: json.relative_humidity_2m,
      precipitation: json.precipitation,
      rain: json.rain,
      isDay: json.is_day === 1,
    } as WeatherReport;
  }
}
