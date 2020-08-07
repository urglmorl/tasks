import {Component} from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  A = new Array<number>();
  B = new Array<number>();
  C = new Array<number>();
  viewedResult = '';

  // Раскоментировать если нужна реализация не через Set
  public makeResult(): void {
    const result = new Set<number>();
    // const result = new Array<number>();
    for (const item of this.A) {
      if (this.B.includes(item) && !this.C.includes(item) /*&& !result.includes(item)*/) {
        result.add(item);
        // result.push(item);
      }
    }
    this.viewedResult = Array.from(result.values()).join(', '); // result.join(', ');
  }

}
