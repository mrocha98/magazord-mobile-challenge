import {
  Box,
  Button,
  ButtonText,
  SafeAreaView,
  Spinner,
} from "@gluestack-ui/themed";
import { PermissionStatus } from "expo-location";
import React, { useEffect, useState } from "react";

import { ReportCard } from "../components/report-card.component";
import { useBoolean } from "../hooks/useBoolean";
import { useErrorToast } from "../hooks/useErrorToast";
import { useLocation } from "../hooks/useLocation";
import { OpenMeteoService } from "../services/open-meteo-service";
import { WeatherReport } from "../types/weather-report";

export function WeatherPage() {
  const { latitude, longitude, permissionStatus, retry } = useLocation();
  const [report, setReport] = useState<WeatherReport | null>(null);
  const {
    value: hasError,
    setTrue: setHasErrorToTrue,
    setFalse: setHasErrorToFalse,
  } = useBoolean(false);
  const { showErrorToast, hideErrorToast } = useErrorToast();

  useEffect(() => {
    if (!!latitude && !!longitude) {
      new OpenMeteoService()
        .getReport(latitude, longitude)
        .then((report) => {
          setReport(report);
          setHasErrorToFalse();
        })
        .catch((error) => {
          console.error(error);
          setReport(null);
          setHasErrorToTrue();
        });
    }
  }, [latitude, longitude]);

  useEffect(() => {
    if (hasError) {
      showErrorToast({ title: "Failed to get weather report" });
    }

    return () => {
      hideErrorToast();
    };
  }, [hasError]);

  const showRetryButton = permissionStatus !== PermissionStatus.GRANTED;
  const showReport = report != null;
  const showSpinner =
    !hasError && !showReport && permissionStatus === PermissionStatus.GRANTED;

  return (
    <SafeAreaView>
      <Box height="100%" alignItems="center" justifyContent="center">
        {showRetryButton && (
          <Button onPress={retry}>
            <ButtonText>Request permission</ButtonText>
          </Button>
        )}
        {showSpinner && <Spinner size="large" />}
        {showReport && <ReportCard report={report} />}
      </Box>
    </SafeAreaView>
  );
}
