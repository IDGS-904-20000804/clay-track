import { trigger, state, style, transition, animate } from '@angular/animations';
import { ChangeDetectorRef, Component } from '@angular/core';
import { MessageService } from 'primeng/api';
import { MateriaPrimaService } from 'src/app/servicios/materiaPrima/materia-prima.service';
import { Receta, RecetasService } from 'src/app/servicios/recetas/recetas.service';
import { VentasService } from 'src/app/servicios/ventas/ventas.service';
import Swal from 'sweetalert2';
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
  visibleImagen: boolean = false;
  unidadMedida!: number;
  idMateriaP!: string;
  cantidad!: string;
  arrayMateriaPrima: any[] = new Array();
  arrayFotos: any[] = new Array();
  columna: string = 'col-9';
  navBar: boolean = false;
  arrayMateriaPrimaSelector: any[] = new Array();
  arrayColores: any[] = new Array();
  coloresObtenidos: any[] = new Array();
  foto!: File;
  idImagen: string = '';
  idImagen2: number = 0;
  arrayReceta: any;
  tamanios = [
    { nombre: 'Chico', valor: 1 },
    { nombre: 'Mediano', valor: 2 },
    { nombre: 'Grande', valor: 3 }
  ];
  idTamanio: number = 0;
  loading: boolean = true;
  idFoto: number = 0;
  nombre: string = ''
  precio: number = 0
  cantidadReceta: any


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

  receta!: Receta
  idReceta:number=0

  colorDescriptionsMap: { [key: number]: string } = {};

  ngOnInit(): void {
    // Populate color descriptions map
    this.arrayColores.forEach((color: any) => {
      this.colorDescriptionsMap[color.idCatColor] = color.description;
    });
  }


  showDialog() {
    this.visible = true;
  }

  showDialogImagen() {
    this.visibleImagen = true;
  }

  toggleNavBar() {
    if (this.navBar == false) {
      this.navBar = true;
      this.columna = 'col-12';
    } else {
      this.navBar = false;
      this.columna = 'col-9';
    }

  }
  constructor(private _servicioVentas:VentasService, private cdr: ChangeDetectorRef, private messageService: MessageService, private _servicioMateriaP: MateriaPrimaService, private _servicioReceta: RecetasService) {
    this.obtenerMateriaPrima();
    this.obtenerColores();
    this.obtenerReceta();
    this.obtenerFotos();
    


  }

  obtenerIdReceta(id: string) {
    this._servicioReceta.obtenerRecetaPorId(id).subscribe((datosReceta:any) => {
      this.idReceta = datosReceta.idCatRecipe
      this.arrayReceta = datosReceta;
      this.nombre = datosReceta.name;
      this.precio = datosReceta.price;
      this.idTamanio = datosReceta.fkCatSize;
      this.idFoto = datosReceta.fkCatImage;
      this.cantidadReceta=datosReceta.quantityStock;
      this.coloresObtenidos = datosReceta.colors.map((color: any) => color.idCatColor);
      this.arrayMateriaPrima = datosReceta.rawMaterialDetails.map((detail: any) => {
        return {
          idCatalog: 0,
            quantity: detail.quantity,
            fkCatRawMaterial: detail.fkRawMaterial
        };
    });      
      console.log('DATOS', datosReceta)
      console.log('colores',this.coloresObtenidos)
      this.showDialog();
      this.obtenerReceta()
    })
  }

  


  obtenerReceta() {
    this.loading = true;
    this._servicioReceta.obtenerReceta().subscribe((receta) => {
      this.arrayReceta = receta;
      console.log('RECEYA', this.arrayReceta)
      this.loading = false;
    }, (err) => {
      console.log(err)
      this.messageService.add({ key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener la Receta' });
      this.loading = false;

    })
  }

  agregarEmpleado() {
    this.visible = false;
    this.messageService.add({ key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo el empleado correctamente.' });
  }

  cancelar() {
    this.visible = false;
    this.visibleImagen = false;
    this.messageService.add({ key: 'tc', severity: 'error', summary: 'Error', detail: 'Ha anulado el guardado del empleado.' });
  }

  agregarMateria() {
    console.log(this.unidadMedida);
    const recetaExistente = this.arrayMateriaPrima.find(
      (materiaPrima) => materiaPrima.fkCatRawMaterial === this.unidadMedida
    );

    const cantidadNueva = parseFloat(this.cantidad);

    if (!isNaN(cantidadNueva) && cantidadNueva > 0) {
      if (recetaExistente) {
        recetaExistente.quantity += cantidadNueva;
        const materialOriginal = this.arrayMateriaPrima.find(
          (material) => material.name === recetaExistente.fkCatRawMaterial
        );
        if (materialOriginal) {
          materialOriginal.totalQuantityRawMaterialUsed += cantidadNueva;
        }
      } else {
        this.arrayMateriaPrima.push({
          idCatalog: 0,
          quantity: cantidadNueva,
          fkCatRawMaterial: this.unidadMedida,
        });
        const materialOriginal = this.arrayMateriaPrima.find(
          (material) => material.name === this.unidadMedida
        );
        if (materialOriginal) {
          materialOriginal.totalQuantityRawMaterialUsed += cantidadNueva;
        }
      }
    } else {
    }
  }

  obtenerNombreMateriaPrima(id: number): string {
    const material = this.arrayMateriaPrima.find(
      (materiaPrima) => materiaPrima.idCatalog === id
    );
    return material ? material.name : '';
  }



  eliminarMateriaP(i: number) {
    this.arrayMateriaPrima.splice(i, 1)
  }

  obtenerMateriaPrima() {
    this._servicioMateriaP.obtenerMateriaP().subscribe(
      (materiaP) => {
        this.arrayMateriaPrimaSelector = materiaP;
        console.log('Materia Prima', this.arrayMateriaPrimaSelector);
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
 

  obtencionIdColor(event:any) {
    this.coloresObtenidos = [];
    for (let color of event.value) {
        if (this.arrayColores.findIndex(c => c.id === color) !== -1) {
            this.coloresObtenidos.push(color);
        }
    }
}
selectedColors: any[] = [];


  agregarReceta() {
    if(this.idReceta>0){
      this.actualizarReceta()
      this.selectedColors = this.arrayColores.filter(color => this.coloresObtenidos.includes(color.idCatColor));

    }else{
    this.receta = {
      name: this.nombre,
      price: this.precio,
      fkCatSize: this.idTamanio,
      fkCatImage: this.idFoto,
      colorIds: this.coloresObtenidos,
      rawMaterials:
        this.arrayMateriaPrima
    };
    console.log(this.receta)

    // const provedor = {
    //   "name": "Nestor",
    //   "price": 0,
    //   "fkCatSize": 1,
    //   "fkCatImage": 1,
    //   "colorIds": [
    //     3, 4, 5
    //   ],
    //   "rawMaterials": [
    //     {
    //       "idCatalog": 0,
    //       "quantity": 3,
    //       "fkCatRawMaterial": 3
    //     }
    //   ]
    // }
    this._servicioReceta.guardarReceta(this.receta).subscribe(
      (response) => {
        // Cliente guardado con éxito, realizar acciones adicionales si es necesario
        this.visible = false;
        this.messageService.add({ key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo la receta correctamente.' });
        console.log('Receta guardado exitosamente:', response);
        this.obtenerReceta()
      },
      (error) => {
        // Ocurrió un error al guardar el cliente, manejar el error apropiadamente
        console.error('Error al guardar la receta:', error);
      }
    );
    }





  }

  guardarFoto() {
    this.guardarFotoReceta(this.datoFoto)
  }


  guardarFotoReceta(file: File) {
    this._servicioReceta.uploadRecipeFile(file).subscribe(
      (response: any) => {
        this.messageService.add({ key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se cargo la foto correctamente.' });
        this.idImagen = response.idCatImage
      },
      (error: any) => {
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

  selectedFile!: File;

  onFileChange(event: Event) {
    const inputElement = event.target as HTMLInputElement;
    if (inputElement.files && inputElement.files.length > 0) {
      this.selectedFile = inputElement.files[0];
    }
  }
  datoFoto!: File;
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


  obtenerFotos() {
    this.loading = true;
    this._servicioReceta.obtenerFotos().subscribe((fotos) => {
      this.arrayFotos = fotos;
      console.log('FOTOS', this.arrayFotos)
      this.loading = false;
    }, (err) => {
      console.log(err)
      this.messageService.add({ key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al obtener las Fotos' });
      this.loading = false;

    })
  }


  actualizarReceta(){

   
    
    this.receta = {
      name: this.nombre,
      price: this.precio,
      fkCatSize: this.idTamanio,
      fkCatImage: this.idFoto,
      colorIds: [1,2,3],
      rawMaterials:
        this.arrayMateriaPrima
    };

    
    this._servicioReceta.actualizarReceta(this.receta, this.idReceta).subscribe((datos)=>{
      this.messageService.add({ key: 'tc', severity: 'success', summary: 'Exito', detail: 'Se guardo la receta correctamente.' });
 console.log(datos)
 this.obtenerReceta()
    });
  }

  eliminarReceta(id: string) {
    // Mostrar SweetAlert de confirmación antes de eliminar el proveedor
    Swal.fire({
      title: 'Confirmación',
      text: '¿Estás seguro de eliminar este Producto?',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Sí, eliminar',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) {
        // El usuario ha confirmado la eliminación
        this._servicioVentas.eliminarStock(id).subscribe(
          (response) => {
            // Proveedor eliminado con éxito, realizar acciones adicionales si es necesario
            this.messageService.add({ key: 'tc', severity: 'success', summary: 'Éxito', detail: 'Se eliminó el Producto correctamente.' });
            console.log('Stock eliminado exitosamente:', response);
            this.obtenerReceta(); 
          },
          (error) => {
            // Ocurrió un error al eliminar el proveedor, manejar el error apropiadamente
            this.messageService.add({ key: 'tc', severity: 'error', summary: 'Error', detail: 'Error al eliminar el Stock' });
            console.error('Error al eliminar el apropiadamente:', error);
          }
        );
      }
    });
  }




}
