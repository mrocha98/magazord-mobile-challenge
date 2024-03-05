import {StateStorage} from 'zustand/middleware';
import {Storage} from '../config/storage';

const mmkv = Storage.getInstance().mmkv;

export const mmkvStorage: StateStorage = {
  getItem: (name: string) => mmkv.getString(name) ?? null,
  setItem: (name: string, value: string) => mmkv.set(name, value),
  removeItem: (name: string) => mmkv.delete(name),
};
