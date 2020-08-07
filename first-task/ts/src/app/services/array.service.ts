import {Injectable} from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ArrayService {

  constructor() {
  }

  private static randomInt(min, max): number {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }

  public generateNewArray(count: number, min: number, max: number, unique: boolean = false): number[] {
    if (unique) {
      const result = new Set<number>();
      for (let i = 0; i < count; i++) {
        const item = ArrayService.randomInt(min, max);
        if (result.has(item)) {
          i--;
        } else {
          result.add(item);
        }
      }
      return Array.from(result.values());
    } else {
      const result = new Array<number>();
      for (let i = 0; i < count; i++) {
        result.push(ArrayService.randomInt(min, max));
      }
      return result;
    }
  }
}
