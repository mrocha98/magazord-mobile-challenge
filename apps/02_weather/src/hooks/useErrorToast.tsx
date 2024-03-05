import { useToast } from "@gluestack-ui/themed";
import { useId } from "react";

import { ErrorToast } from "../components/error-toast.component";

export function useErrorToast() {
  const toast = useToast();
  const id = useId();

  const showErrorToast = ({
    title,
    description,
  }: { title?: string; description?: string } = {}) =>
    toast.show({
      placement: "top",
      id,
      render: (props) => (
        <ErrorToast id={props.id} title={title} description={description} />
      ),
    });

  const hideErrorToast = () => toast.close(id);

  return { showErrorToast, hideErrorToast };
}
