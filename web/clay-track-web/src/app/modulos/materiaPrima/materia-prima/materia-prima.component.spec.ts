import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MateriaPrimaComponent } from './materia-prima.component';

describe('MateriaPrimaComponent', () => {
  let component: MateriaPrimaComponent;
  let fixture: ComponentFixture<MateriaPrimaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [MateriaPrimaComponent]
    });
    fixture = TestBed.createComponent(MateriaPrimaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
