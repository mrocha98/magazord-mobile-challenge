import {MMKV} from 'react-native-mmkv';

export class Storage {
  private constructor(readonly mmkv: MMKV) {}

  static #instance: Storage | null = null;

  static getInstance(): Storage {
    return (this.#instance ??= new Storage(Storage.mmkvConfig()));
  }

  private static mmkvConfig(): MMKV {
    return new MMKV({
      id: 'container',
    });
  }
}
