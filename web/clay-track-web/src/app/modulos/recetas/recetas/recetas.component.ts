import { trigger, state, style, transition, animate } from '@angular/animations';
import { ChangeDetectorRef, Component } from '@angular/core';
import { MessageService } from 'primeng/api';
import { MateriaPrimaService } from 'src/app/servicios/materiaPrima/materia-prima.service';
import {  Receta, RecetasService } from 'src/app/servicios/recetas/recetas.service';
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
  idImagen:string='';
  idImagen2:number=0;
  arrayReceta: any[]=  new Array();
  tamanios = [
    { nombre: 'Chico', valor: 1 },
    { nombre: 'Mediano', valor: 2 },
    { nombre: 'Grande', valor: 3 }
  ];
  idTamanio:number=0;
  loading: boolean = true;



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

  receta: Receta = {
    name: "",
    price: 0,
    fkCatSize: 1,
    fkCatImage: 2,
    colorIds: this.coloresObtenidos,
    rawMaterials: 
      this.arrayMateriaPrima
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
  constructor( private cdr: ChangeDetectorRef, private messageService: MessageService, private _servicioMateriaP: MateriaPrimaService, private _servicioReceta: RecetasService) { 
    this.obtenerMateriaPrima();
    this.obtenerColores();
    this.obtenerReceta();
  

  }

  obtenerReceta(){
    this.loading = true; 
    this._servicioReceta.obtenerReceta().subscribe((receta)=>{
      this.arrayReceta=receta;
      console.log('RECEYA',this.arrayReceta)
      this.loading = false; 
    }, (err)=>{
      console.log(err)
      this.messageService.add({key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener la Receta' });
      this.loading = false; 

    })
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
          quantity: cantidadNueva,
          fkCatRawMaterial: this.unidadMedida,
        });
      }
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
  this.guardarFotoReceta(this.datoFoto)

    // this._servicioReceta.guardarReceta(this.receta).subscribe(
    //   (response) => {
    //     // Cliente guardado con éxito, realizar acciones adicionales si es necesario
    //     this.visible = false;
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
    this._servicioReceta.uploadRecipeFile(file).subscribe(
          (response:any) => {
            this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se cargo la foto correctamente.' });
            this.idImagen=response.idCatImage
            console.log('File uploaded successfully:', this.idImagen);
            this.idImagen2=parseInt(this.idImagen)
            if(this.idImagen2>0){
              this.receta = {
                name: "",
                price: 0,
                fkCatSize: 1,
                fkCatImage: this.idImagen2,
                colorIds: this.coloresObtenidos,
                rawMaterials: 
                  this.arrayMateriaPrima
              };
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
          },
          (error:any) => {
            console.error('Error uploading file:', error);
          }
        );
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
  datoFoto!:File;
  // idFile: string = "";
  // idFileJson: any;
  // selectedfileJson: any;


  // uploadJsonFile(event: any) {
  //   const target: DataTransfer = <DataTransfer>(event.target);
  //   if (target.files.length !== 1) {
  //     throw new Error('Cannot use multiple files');
  //   }
  //   this.selectedfileJson = event.target.files[0];
  //   console.log('FOTO',this.idFileJson)
  // }


  obtenerFoto(files: File[]) {
    this.datoFoto = files[0]; // Obtener el archivo del evento
    this.cdr.detectChanges(); // Forzar la detección de cambios
  }

  



}
