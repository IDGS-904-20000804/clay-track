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

interface UploadEvent {
  originalEvent: Event;
  files: File[];
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
  unidadMedida!:number;
  idMateriaP!:string;
  cantidad!:string;
  arrayMateriaPrima: any[]=  new Array();
  columna:string='col-9';
  navBar:boolean=false;
  arrayMateriaPrimaSelector: any[]= new Array();
  arrayColores: any[]= new Array();
  coloresObtenidos: any[]= new Array();
  foto!:File;

  // {
  //   "name": "string",
  //   "price": 0,
  //   "fkCatSize": 1,
  //   "fkCatImage": 1,
  //   "colorIds": [
  //     0
  //   ],
  //   "rawMaterials": [
  //     {
  //       "idCatalog": 0,
  //       "quantity": 0,
  //       "fkCatRawMaterial": 0
  //     }
  //   ]
  // }

  receta: Product = {
    name: "",
    price: 0,
    fkCatImage: 1,
    fkCatSize: 1,
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
    console.log(this.unidadMedida)
    const recetaExistente = this.arrayMateriaPrima.find(
      (materiaPrima) => materiaPrima.materia === this.unidadMedida
    );
  
    const cantidadNueva = parseFloat(this.cantidad);
  
    if (!isNaN(cantidadNueva) && cantidadNueva > 0) {
      if (recetaExistente) {
        recetaExistente.cantidad += cantidadNueva;
      } else {
        this.arrayMateriaPrima.push({
          idCatalog: 0,
          materia: this.unidadMedida,
          cantidad: cantidadNueva
        });
      }
      this.unidadMedida = 0;
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
    console.log(this.foto)
    this.guardarFotoReceta(this.selectedfileJson)
    // this._servicioReceta.guardarReceta().subscribe(
    //   (response) => {
    //     // Cliente guardado con éxito, realizar acciones adicionales si es necesario
    //     this.visible = false;
    //     this.guardarFotoReceta(this.foto)
    //     this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo la receta correctamente.' });
    //     console.log('Receta guardado exitosamente:', response);
    //   },
    //   (error) => {
    //     // Ocurrió un error al guardar el cliente, manejar el error apropiadamente
    //     console.error('Error al guardar la receta:', error);
    //   }
    // );
    
    }

  guardarFotoReceta(file: File){
    this._servicioReceta.guardarRecetaFoto(file).subscribe((foto)=>{
      this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se cargo la foto correctamente.' });
    },(error)=>{
      console.error('Error al cargar la foto:', error);
    })
  }


    selectedObject: any = null;

  seleccionarMateriaPrima(event: any) {
    const index = event.target.value;
    if (index >= 0 && index < this.arrayMateriaPrimaSelector.length) {
      this.selectedObject = this.arrayMateriaPrimaSelector[index];
    } else {
      this.selectedObject = null;
    }
  }

  uploadedFiles: any[] = [];


  onUpload(event: any) {
    this.uploadedFiles = []; // Limpia la lista de archivos subidos

    // Agregar la foto cargada a la variable 'foto'
    this.foto = event.files[0];

    // Agregar los archivos subidos a la lista 'uploadedFiles'
    for (let file of event.files) {
      this.uploadedFiles.push(file);
    }
  }

  selectedFile!: File ;

  onFileChange(event: Event) {
    const inputElement = event.target as HTMLInputElement;
    if (inputElement.files && inputElement.files.length > 0) {
      this.selectedFile = inputElement.files[0];
    }
  }

  idFile: string = "";
  idFileJson: any;
  selectedfileJson: any;


  uploadJsonFile(event: any) {
    const target: DataTransfer = <DataTransfer>(event.target);
    if (target.files.length !== 1) {
      throw new Error('Cannot use multiple files');
    }
    this.selectedfileJson = event.target.files[0];
    console.log('FOTO',this.idFileJson)
  }


  onFileSelected(event: any): void {
    const file: File = event.target.files[0];
    if (file) {
      this._servicioReceta.uploadRecipeFile(file).subscribe(
        (response:any) => {
          console.log('File uploaded successfully:', response);
          // Puedes realizar acciones adicionales después de cargar el archivo.
        },
        (error:any) => {
          console.error('Error uploading file:', error);
        }
      );
    }
  }



}
