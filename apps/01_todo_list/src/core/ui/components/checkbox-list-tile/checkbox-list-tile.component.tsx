import React from 'react';
import {Text, TouchableOpacity, View} from 'react-native';
import {faSquare} from '@fortawesome/free-regular-svg-icons';
import {faSquareCheck} from '@fortawesome/free-solid-svg-icons';
import {FontAwesomeIcon} from '@fortawesome/react-native-fontawesome';
import {styles as S} from './checkbox-list-tile.styles';

export interface CheckboxListTileProps {
  checked: boolean;
  onCheck: (value: boolean) => void;
  title: string;
  description: string;
  trailing?: React.JSX.Element;
}

export function CheckboxListTile({
  checked,
  onCheck,
  title,
  description,
  trailing,
}: CheckboxListTileProps) {
  return (
    <View style={S.container}>
      <TouchableOpacity style={S.leading} onPress={() => onCheck(!checked)}>
        <FontAwesomeIcon
          icon={checked ? faSquareCheck : faSquare}
          color={checked ? S.checkMark.color : undefined}
        />
      </TouchableOpacity>
      <View style={S.content}>
        <Text style={[S.title, checked ? S.checkedText : S.uncheckedText]}>
          {title}
        </Text>
        <Text style={[S.subtitle, checked ? S.checkedText : S.uncheckedText]}>
          {description}
        </Text>
      </View>
      <View style={S.trailing}>{trailing}</View>
    </View>
  );
}
