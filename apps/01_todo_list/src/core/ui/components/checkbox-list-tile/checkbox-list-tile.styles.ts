import {StyleSheet} from 'react-native';

export const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 8,
    borderRadius: 8,
    borderWidth: 1,
    borderColor: 'rgba(0 0 0 / .8)',
  },
  leading: {
    marginLeft: 4,
    marginRight: 16,
  },
  checkMark: {
    color: '#2563eb',
  },
  trailing: {
    marginLeft: 'auto',
    marginRight: 16,
  },
  content: {
    maxWidth: '75%',
  },
  title: {
    fontSize: 16,
    fontWeight: 'bold',
  },
  subtitle: {
    fontSize: 14,
  },
  checkedText: {
    textDecorationLine: 'line-through',
  },
  uncheckedText: {
    textDecorationLine: 'none',
  },
});
