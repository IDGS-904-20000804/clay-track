import { trigger, state, style, transition, animate } from '@angular/animations';
import { Component } from '@angular/core';
import { MessageService } from 'primeng/api';
import { AlmacenService } from 'src/app/servicios/almacen/almacen.service';

@Component({
  selector: 'app-almacen',
  templateUrl: './almacen.component.html',
  styleUrls: ['./almacen.component.css'],
  providers: [MessageService],
  animations: [
    trigger('fadeInOut', [
      state('void', style({
        opacity: 0,
        transform: 'translateX(-100%)'
      })),
      state('*', style({
        opacity: 1,
        transform: 'translateX(0)'
      })),
      transition('void <=> *', animate('600ms ease-in-out')),
    ])
  ]
})
export class AlmacenComponent {
  columna:string='col-9';
  navBar:boolean=false;
  loading: boolean = true;
  arrayAlmacen : any = new Array();

  constructor( private messageService: MessageService,private _servicioAlmacen: AlmacenService){
    this.obtenerAlmacen()
  }

  toggleNavBar() {
    if(this.navBar==false){
      this.navBar =true;
      this.columna='col-12';
    }else{
      this.navBar =false;
      this.columna='col-9';
    }
    
  }

  obtenerAlmacen(){
    this.loading = true; 

    this._servicioAlmacen.obtenerAlmacen().subscribe((almacen)=>{
      this.arrayAlmacen=almacen;
      console.log('almacen',this.arrayAlmacen)
      this.loading = false; 

    }, (err)=>{
      console.log(err)
      this.loading = false; 
      this.messageService.add({key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener los clientes' });
    })
  }

}
