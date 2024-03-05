import * as Location from "expo-location";
import { useEffect, useState } from "react";

export function useLocation() {
  const [permissionStatus, setPermissionStatus] = useState(
    Location.PermissionStatus.UNDETERMINED,
  );
  const [latitude, setLatitude] = useState<number | null>(null);
  const [longitude, setLongitude] = useState<number | null>(null);

  const getPermission = async () => {
    if (permissionStatus === Location.PermissionStatus.GRANTED) {
      return;
    }
    const response = await Location.requestForegroundPermissionsAsync();
    setPermissionStatus(response.status);
  };

  const getLocation = async () => {
    if (permissionStatus !== Location.PermissionStatus.GRANTED) {
      return;
    }
    const { coords } = await Location.getCurrentPositionAsync({});
    setLatitude(coords.latitude);
    setLongitude(coords.longitude);
  };

  const retry = async () => {
    await getPermission();
    await getLocation();
  };

  useEffect(() => {
    retry();
  }, [permissionStatus]);

  return {
    permissionStatus,
    latitude,
    longitude,
    getPermission,
    getLocation,
    retry,
  };
}
