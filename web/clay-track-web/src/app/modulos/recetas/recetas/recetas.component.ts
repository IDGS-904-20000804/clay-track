import { trigger, state, style, transition, animate } from '@angular/animations';
import { Component } from '@angular/core';
import { MessageService } from 'primeng/api';
import { MateriaPrimaService } from 'src/app/servicios/materiaPrima/materia-prima.service';
import { Product, RecetasService } from 'src/app/servicios/recetas/recetas.service';
interface Color {
  idCatColor: number;
  description: string;
  hexadecimal: string;
  status: boolean;
  creationDate: string;
  updateDate: string;
}

@Component({
  selector: 'app-recetas',
  templateUrl: './recetas.component.html',
  styleUrls: ['./recetas.component.css'],
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
export class RecetasComponent {

  visible: boolean = false;
  unidadMedida!:string;
  cantidad!:string;
  arrayMateriaPrima: any[]=  new Array();
  columna:string='col-9';
  navBar:boolean=false;
  arrayMateriaPrimaSelector: any[]= new Array();
  arrayColores: any[]= new Array();
  coloresObtenidos: any[]= new Array();


  receta: Product = {
    name: "",
    price: 0,
    imagePath: "path",
    fkCatSize: 0,
    colorIds: [],
    rawMaterials: 
      this.arrayMateriaPrima
    ,
  };
  
  
  showDialog() {
    this.visible = true;
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
  constructor( private messageService: MessageService, private _servicioMateriaP: MateriaPrimaService, private _servicioReceta: RecetasService) { 
    this.obtenerMateriaPrima();
    this.obtenerColores();
  }

  agregarEmpleado() {
    this.visible=false;
    this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo el empleado correctamente.' });
  }

  cancelar() {
    this.visible=false;
    this.messageService.add({ key: 'tc',severity: 'error', summary: 'Error', detail: 'Ha anulado el guardado del empleado.' });
  }

  agregarMateria() {
    const recetaExistente = this.arrayMateriaPrima.find(
      (materiaPrima) => materiaPrima.materia === this.unidadMedida
    );
  
    const cantidadNueva = parseFloat(this.cantidad);
  
    if (!isNaN(cantidadNueva) && cantidadNueva > 0) {
      if (recetaExistente) {
        recetaExistente.cantidad += cantidadNueva;
      } else {
        this.arrayMateriaPrima.push({
          idCatalog: 1,
          materia: this.unidadMedida,
          cantidad: cantidadNueva
        });
      }
      this.unidadMedida = '';
      this.cantidad = '';
    } else {
      this.messageService.add({ key: 'tc',severity: 'info', summary: 'Verifica', detail: 'La cantidad debe ser un número válido mayor que cero.' });
    }
  }
  

  eliminarMateriaP(i: number){
    this.arrayMateriaPrima.splice(i,1)
  }

  obtenerMateriaPrima() {
    this._servicioMateriaP.obtenerMateriaP().subscribe(
      (materiaP) => {
        this.arrayMateriaPrimaSelector = materiaP;
        console.log('Materia Prima', this.arrayMateriaPrima);
      },
      (err) => {
        console.log(err);
        this.messageService.add({ key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener los proveedores' });
      }
    );
  }

  obtenerColores() {
    this._servicioReceta.obtenerColor().subscribe(
      (colores) => {
        this.arrayColores = colores;
        console.log('Materia Prima', this.arrayColores);
      },
      (err) => {
        console.log(err);
        this.messageService.add({ key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener los colores' });
      }
    );
  }
  obtencionIdColor(event: any) {
   this.coloresObtenidos= event.value.map((color: any) => color.idCatColor);
    console.log('IDs seleccionados:', this.coloresObtenidos);
    this.receta.colorIds=this.coloresObtenidos;
  }

  agregarReceta() {
    this._servicioReceta.guardarReceta(this.receta).subscribe(
      (response) => {
        // Cliente guardado con éxito, realizar acciones adicionales si es necesario
        this.visible = false;
        this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo la receta correctamente.' });
        console.log('Receta guardado exitosamente:', response);
      },
      (error) => {
        // Ocurrió un error al guardar el cliente, manejar el error apropiadamente
        console.error('Error al guardar la receta:', error);
      }
    );
    }
  

}
