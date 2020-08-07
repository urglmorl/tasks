import {Component, EventEmitter, Input, OnInit, Output} from '@angular/core';
import {ArrayService} from '../../services/array.service';

@Component({
  selector: 'app-array',
  templateUrl: './array.component.html',
  styleUrls: ['./array.component.scss']
})
export class ArrayComponent implements OnInit {

  count = 10;
  min = 0;
  max = 10;
  isUniqueValues = false;

  @Input() title: string;
  @Input() Array: number[] = new Array<number>();
  @Output() ArrayChange = new EventEmitter<number[]>();

  constructor(private arrayService: ArrayService) {
  }

  ngOnInit(): void {
    this.generateNewArray();
  }

  public generateNewArray(): void {
    this.Array = this.arrayService.generateNewArray(this.count, this.min, this.max, this.isUniqueValues);
    this.ArrayChange.emit(this.Array);
  }
}
