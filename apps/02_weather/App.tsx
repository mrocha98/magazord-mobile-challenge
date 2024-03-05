import { config } from "@gluestack-ui/config";
import { GluestackUIProvider } from "@gluestack-ui/themed";
import React from "react";

import { WeatherPage } from "./src/features/weather.page";

export default function App() {
  return (
    <GluestackUIProvider config={config}>
      <WeatherPage />
    </GluestackUIProvider>
  );
}
