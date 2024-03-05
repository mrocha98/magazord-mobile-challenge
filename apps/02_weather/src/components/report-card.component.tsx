import {
  Card,
  HStack,
  Heading,
  Icon,
  MoonIcon,
  SunIcon,
  Text,
  VStack,
} from "@gluestack-ui/themed";
import React from "react";

import { WeatherReport } from "../types/weather-report";

export interface ReportCardProps {
  report: WeatherReport;
}

type CardRowProps = {
  label: string;
  value: string;
  unit: string;
};

function CardRow({ label, value, unit }: CardRowProps) {
  return (
    <HStack alignItems="center" justifyContent="space-between" columnGap="$6">
      <Heading size="md">{label}:</Heading>
      <Text>
        {value}
        {unit}
      </Text>
    </HStack>
  );
}

export function ReportCard({
  report: {
    temperature,
    apparentTemperature,
    humidity,
    precipitation,
    isDay,
    rain,
  },
}: ReportCardProps) {
  const rows: CardRowProps[] = [
    {
      label: "Temperature",
      value: temperature.toString(),
      unit: "°C",
    },
    {
      label: "Apparent",
      value: apparentTemperature.toString(),
      unit: "°C",
    },
    { label: "Humidity", value: humidity.toString(), unit: "%" },
    {
      label: "Precipitation",
      value: precipitation.toString(),
      unit: "mm",
    },
    { label: "Rain", value: rain.toString(), unit: "mm" },
  ];

  return (
    <Card variant="elevated" size="lg">
      <Icon
        as={isDay ? SunIcon : MoonIcon}
        size="xl"
        color={isDay ? "$amber500" : "$primary600"}
        alignSelf="center"
        marginBottom="$4"
      />
      <VStack gap="$1">
        {rows.map((props, index) => (
          <CardRow key={`card-row-${index}`} {...props} />
        ))}
      </VStack>
    </Card>
  );
}
