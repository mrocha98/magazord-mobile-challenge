import {StyleSheet} from 'react-native';

export const styles = StyleSheet.create({
  container: {
    padding: 24,
    flex: 1,
  },
  input: {
    height: 40,
    padding: 12,
    borderWidth: 1,
    borderRadius: 8,
  },
  inputErrorMessage: {
    color: '#f43f5e',
    marginTop: 4,
  },
  placeholder: {
    color: '#333',
  },
  listSeparator: {
    height: 12,
  },
  inputSeparator: {
    height: 16,
  },
  emptyListText: {
    fontSize: 18,
    textAlign: 'center',
    marginTop: 32,
  },
});
