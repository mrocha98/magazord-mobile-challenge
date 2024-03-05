import {create} from 'zustand';
import type {Task} from '../../types/task';
import {createJSONStorage, persist} from 'zustand/middleware';
import {mmkvStorage} from '../../core/middlewares/mmkv_storage';

export interface TodoListState {
  tasks: Array<Task>;
  initializeTasks: () => void;
  addTask: (params: Pick<Task, 'title' | 'description'>) => void;
  deleteTask: (id: number) => void;
  completeTask: (id: number) => void;
  unCompleteTask: (id: number) => void;
}

let newId = 0;

export const useTodoListStore = create<TodoListState>()(
  persist(
    (set, get) => ({
      tasks: [],
      initializeTasks: () => set(_ => ({tasks: get().tasks})),
      addTask: ({title, description}) =>
        set(state => {
          const newTask: Task = {
            id: newId++,
            title,
            description,
            completed: false,
          };
          return {
            tasks: [...state.tasks, newTask],
          };
        }),
      deleteTask: id =>
        set(state => ({
          tasks: state.tasks.filter(task => task.id !== id),
        })),
      completeTask: id =>
        set(state => ({
          tasks: state.tasks.map(task =>
            task.id === id ? {...task, completed: true} : task,
          ),
        })),
      unCompleteTask: id =>
        set(state => ({
          tasks: state.tasks.map(task =>
            task.id === id ? {...task, completed: false} : task,
          ),
        })),
    }),
    {name: 'todo-list-storage', storage: createJSONStorage(() => mmkvStorage)},
  ),
);
