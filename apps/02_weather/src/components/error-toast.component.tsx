import {
  Toast,
  ToastDescription,
  ToastTitle,
  VStack,
} from "@gluestack-ui/themed";

export interface ErrorToastProps {
  id: unknown; // Gluestack will pass id as any
  title?: string;
  description?: string;
}

export function ErrorToast({
  id,
  title = "Something went wrong",
  description = "Try again later",
}: ErrorToastProps) {
  const nativeId = `error-toast-${id}`;
  return (
    <Toast nativeID={nativeId} action="error" variant="solid">
      <VStack space="xs">
        <ToastTitle>{title}</ToastTitle>
        <ToastDescription>{description}</ToastDescription>
      </VStack>
    </Toast>
  );
}
