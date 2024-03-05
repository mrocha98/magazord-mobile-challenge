import React, {useEffect, useRef} from 'react';
import {
  Button,
  FlatList,
  SafeAreaView,
  Text,
  TextInput,
  TouchableOpacity,
  View,
} from 'react-native';
import {Controller, useForm} from 'react-hook-form';
import {zodResolver} from '@hookform/resolvers/zod';
import {FontAwesomeIcon} from '@fortawesome/react-native-fontawesome';
import {faTrashCan} from '@fortawesome/free-solid-svg-icons';
import {z} from 'zod';
import {styles as S} from './todo-list.styles';
import {useTodoListStore} from './todo-list.store';
import {CheckboxListTile} from '../../core/ui/components';

const schema = z.object({
  title: z.string().trim().min(3).max(64),
  description: z.string().trim().min(3).max(128),
});

type FormType = z.infer<typeof schema>;

function ListSeparator() {
  return <View style={S.listSeparator} />;
}

export function TodoListPage() {
  const flatListRef = useRef<FlatList>(null);
  const {
    tasks,
    initializeTasks,
    addTask,
    deleteTask,
    completeTask,
    unCompleteTask,
  } = useTodoListStore();
  const {control, handleSubmit, reset} = useForm<FormType>({
    resolver: zodResolver(schema),
  });

  const onSubmit = handleSubmit(taskData => {
    addTask(taskData);
    reset();
    flatListRef.current?.scrollToEnd();
  });

  useEffect(() => {
    initializeTasks();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <View style={S.container}>
      <SafeAreaView>
        <Controller
          control={control}
          name="title"
          render={({field: {onChange, onBlur, value}, fieldState: {error}}) => (
            <>
              <TextInput
                placeholder="Title"
                style={S.input}
                placeholderTextColor={S.placeholder.color}
                onBlur={onBlur}
                onChangeText={onChange}
                value={value}
              />
              {error?.message && (
                <Text style={S.inputErrorMessage}>{error.message}</Text>
              )}
            </>
          )}
        />
        <View style={S.inputSeparator} />
        <Controller
          control={control}
          name="description"
          render={({field: {onChange, onBlur, value}, fieldState: {error}}) => (
            <>
              <TextInput
                placeholder="Description"
                style={S.input}
                placeholderTextColor={S.placeholder.color}
                onBlur={onBlur}
                onChangeText={onChange}
                value={value}
              />
              {error?.message && (
                <Text style={S.inputErrorMessage}>{error.message}</Text>
              )}
            </>
          )}
        />
        <View style={S.listSeparator} />
        <Button title="Create task" onPress={onSubmit} />
        <View style={S.listSeparator} />
      </SafeAreaView>
      <FlatList
        ref={flatListRef}
        data={tasks}
        keyExtractor={(task, _) => task.id.toString()}
        ListEmptyComponent={
          <Text style={S.emptyListText}>No tasks, start creating one!</Text>
        }
        ItemSeparatorComponent={ListSeparator}
        renderItem={({item: task}) => (
          <CheckboxListTile
            checked={task.completed}
            title={task.title}
            description={task.description}
            onCheck={checked =>
              (checked ? completeTask : unCompleteTask)(task.id)
            }
            trailing={
              <TouchableOpacity onPress={() => deleteTask(task.id)}>
                <FontAwesomeIcon icon={faTrashCan} color="#e11d48" />
              </TouchableOpacity>
            }
          />
        )}
      />
    </View>
  );
}
