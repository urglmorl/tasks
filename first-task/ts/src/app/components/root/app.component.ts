import {Component} from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'ts';

  A: number[];
  B: number[];
  C: number[];
  ResultSet = new Set<number>();
  viewedResult = '';

  public makeResult(): void {
    this.ResultSet = new Set<number>();
    for (const item of this.A) {
      if (this.B.includes(item) && !this.C.includes(item)) {
        this.ResultSet.add(item);
      }
    }
    console.log(this.ResultSet);
    this.viewedResult = Array.from(this.ResultSet.values()).join(', ');
  }

}
