import {AfterContentChecked, AfterViewInit, ChangeDetectorRef, Component, EventEmitter, Input, OnInit, Output} from '@angular/core';
import {ArrayService} from '../../services/array.service';
import {BehaviorSubject} from 'rxjs';

@Component({
  selector: 'app-array',
  templateUrl: './array.component.html',
  styleUrls: ['./array.component.scss']
})
export class ArrayComponent implements OnInit, AfterViewInit {

  count = 10;
  min = 0;
  max = 10;
  isUniqueValues = false;
  arrayString = new BehaviorSubject<string>('');

  @Input() title;
  @Input() Array: number[];
  @Output() ArrayChange = new EventEmitter<number[]>();

  constructor(private arrayService: ArrayService,
              private cdr: ChangeDetectorRef) {
  }

  ngOnInit(): void {
  }

  ngAfterViewInit(): void {
    this.generateNewArray();
  }

  public generateNewArray(): void {
    this.Array = this.arrayService.generateNewArray(this.count, this.min, this.max, this.isUniqueValues);
    this.ArrayChange.emit(this.Array);
    this.arrayString.next(this.Array.join(', '));
    this.cdr.detectChanges();
  }
}
