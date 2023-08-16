import { trigger, state, style, transition, animate } from '@angular/animations';
import { Component } from '@angular/core';
import { ChartData, ChartOptions } from 'chart.js';
import { AnalisisService } from 'src/app/servicios/analisis/analisis.service';

interface CustomerData {
    purchaseCount: number;
    totalPurchases: number;
    name: string;
    lastName: string;
    middleName: string;
}

@Component({
    selector: 'app-graficas',
    templateUrl: './graficas.component.html',
    styleUrls: ['./graficas.component.css'],
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
export class GraficasComponent {
    data: any;

    options: any;
    columna: string = 'col-9';
    navBar: boolean = false;
    chartDataR: any;
    chartOptionsR: any;
    arraySalesByClient: any[] = new Array()
    arrayPurchasesBySupplier: any[] = new Array();
    arrayRawMaterialsByRecipe: any[] = new Array();
    arrayRecipesBySale: any[] = new Array()
    tipoGrafica: string = ''
    fecha!: Date
    graficas = [
        { nombre: 'Ventas por cliente', valor: 'SalesByClient' },
        { nombre: 'Compras por proveedor', valor: 'PurchasesBySupplier' },
        { nombre: 'Materias primas por receta', valor: 'RawMaterialsByRecipe' },
        { nombre: 'Recetas Por Venta', valor: 'RecipesBySale' }
    ];

    constructor(private _servicioAnalisis: AnalisisService) {

    }



    obtencionDatos() {
       
        const fechaOriginal = new Date(this.fecha);
        fechaOriginal.setDate(fechaOriginal.getDate() + 1); 

        const fechaFormateada = this.formatearFecha(fechaOriginal);

        console.log(fechaFormateada); // Salida: 2023,8,16

            this._servicioAnalisis.obtenerDatos(fechaFormateada, this.tipoGrafica).subscribe((datos) => {
                if (this.tipoGrafica == 'SalesByClient') {
                    const jsonResult = JSON.parse(datos[0].result);
                    this.arraySalesByClient = jsonResult
                    console.log(this.arraySalesByClient)
                    this. obtenerDatosGraficaVentaCliente()
                  
                } else if (this.tipoGrafica == 'PurchasesBySupplier') {
                    const jsonResult = JSON.parse(datos[0].result);
                    this.arrayPurchasesBySupplier = jsonResult
                    console.log(this.arrayPurchasesBySupplier)
                    this.obtenerGraficaComprasProvedor()
                }
                else if (this.tipoGrafica == 'RawMaterialsByRecipe') {
                    const jsonResult = JSON.parse(datos[0].result);
                    this.arrayRawMaterialsByRecipe = jsonResult
                    this.obtenerGraficaMateriaPorReceta()
                    console.log(this.arrayRawMaterialsByRecipe)
                }
                else if (this.tipoGrafica == 'RecipesBySale') {
                    const jsonResult = JSON.parse(datos[0].result);
                    this.arrayRecipesBySale = jsonResult
                    console.log(this.arrayRecipesBySale )
                   this.obtenerGraficaRecetasPorVenta()
                }
            })
    }


    obtenerDatosGraficaVentaCliente() {
          const labels = this.arraySalesByClient.map(item => item.name);
          console.log(labels)
          const salesCountData = this.arraySalesByClient.map(item => item.salesCount);
          const totalSalesData = this.arraySalesByClient.map(item => item.totalSales);
        
        const documentStyle = getComputedStyle(document.documentElement);
        console.log(labels)
        this.data = {
            labels: labels,
            datasets: [
                {
                    label: 'Recuento de ventas',
                    fill: false,
                    borderColor: documentStyle.getPropertyValue('--blue-500'),
                    yAxisID: 'y',
                    tension: 0.4,
                    data: salesCountData
                },
                {
                    label: 'Ventas totales',
                    fill: false,
                    borderColor: documentStyle.getPropertyValue('--green-500'),
                    yAxisID: 'y1',
                    tension: 0.4,
                    data: totalSalesData
                }
            ]
        };
        this.arrayPurchasesBySupplier=[]
        this.arrayRawMaterialsByRecipe=[]
        this.arrayRecipesBySale=[]
    }

    obtenerGraficaComprasProvedor(){

        this.chartData = {
            labels: this.arrayPurchasesBySupplier.map(customer => `${customer.name} ${customer.lastName}`),
            datasets: [
                {
                    label: 'Cantidad de Compras',
                    backgroundColor: '#FA3838',
                    data: this.arrayPurchasesBySupplier.map(customer => customer.purchaseCount),
                },
                {
                    label: 'Total de Compras',
                    backgroundColor: '#FAC238',
                    data: this.arrayPurchasesBySupplier.map(customer => customer.totalPurchases),
                },
            ],
    
        };
        this.arraySalesByClient=[]
        this.arrayRawMaterialsByRecipe=[]
        this.arrayRecipesBySale=[]
    }

    obtenerGraficaMateriaPorReceta(){
     const materialObjeto = this.arrayRawMaterialsByRecipe
     .sort((a, b) => b.totalQuantityRawMaterialUsed - a.totalQuantityRawMaterialUsed)
     .slice(0, 15);

        this.chartDataPay = {
            labels: materialObjeto.map((item: any) => item.name),
            datasets: [
                {
                    label:'Cantidad total de materia prima utilizada',
                    data: materialObjeto.map((item: any) => item.totalQuantityRawMaterialUsed),
                    backgroundColor: [
                        "#FF6384",
                        "#36A2EB",
                        "#FFCE56",
                        // Agregar más colores aquí si tienes más datos
                    ],
                    hoverBackgroundColor: [
                        "#FF6384",
                        "#36A2EB",
                        "#FFCE56",
                        // Agregar más colores aquí si tienes más datos
                    ]
                }
            ]
        };
        this.arraySalesByClient=[]
        this.arrayPurchasesBySupplier=[]
        this.arrayRecipesBySale=[]
    }

    obtenerGraficaRecetasPorVenta(){
        const recetaObjeto = this.arrayRecipesBySale
     .sort((a, b) => b.totalRecipes - a.totalRecipes)
     .slice(0, 15);
        this.chartDataR = {
            labels: recetaObjeto.map(item => item.descriptionRecipe),
            datasets: [
                {
                    label: 'Total de Recetas',
                    data: this.arrayRecipesBySale.map(item => item.totalRecipes),
                    backgroundColor: '#42A5F5', // Color de las barras
                }
            ]
        };

        this.chartOptionsR = {
            scales: {
                y: {
                    beginAtZero: true // Comenzar desde cero en el eje y
                }
            }
        };
        this.arraySalesByClient=[]
        this.arrayPurchasesBySupplier=[]
        this.arrayRawMaterialsByRecipe=[]
    }
    

    formatearFecha(fecha: Date): string {
        const ano = fecha.getFullYear();
        const mes = fecha.getMonth() + 1; // Los meses en JavaScript van de 0 a 11
        const dia = fecha.getDate();

        return `${ano},${mes},${dia}`;
    }



    rawDataR = [
        {
            "descriptionRecipe": "Azulejo color solido (G) - Marr\u00f3n (#A52A2A)",
            "totalRecipes": 67,
            "totalProfit": 67,
            "idCatRecipe": 12,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Azulejo color solido (C) - Red (#FF0000)",
            "totalRecipes": 34,
            "totalProfit": 34,
            "idCatRecipe": 19,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Azulejo color solido (M) - Crema (#FFFDD0)",
            "totalRecipes": 9,
            "totalProfit": 9,
            "idCatRecipe": 26,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Azulejo colores (G) - Azul (#0000FF), Verde (#008000), Blanco (#FFFFFF)",
            "totalRecipes": 5,
            "totalProfit": 5,
            "idCatRecipe": 39,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Cacerola color solido (G) - Marr\u00f3n (#A52A2A)",
            "totalRecipes": 26,
            "totalProfit": 26,
            "idCatRecipe": 96,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Cuenco colores (C) - Beige (#F5F5DC), Marr\u00f3n (#A52A2A), Crema (#FFFDD0)",
            "totalRecipes": 7,
            "totalProfit": 7,
            "idCatRecipe": 199,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Ensaladera color solido (C) - Marr\u00f3n (#A52A2A)",
            "totalRecipes": 55,
            "totalProfit": 55,
            "idCatRecipe": 220,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Florero color solido (C) - Marr\u00f3n (#A52A2A)",
            "totalRecipes": 87,
            "totalProfit": 87,
            "idCatRecipe": 262,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Florero colores (G) - Terracota (#E2725B), Marr\u00f3n (#A52A2A), Crema (#FFFDD0)",
            "totalRecipes": 3,
            "totalProfit": 3,
            "idCatRecipe": 294,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Fregadero color solido (M) - Azul (#0000FF)",
            "totalRecipes": 6,
            "totalProfit": 6,
            "idCatRecipe": 308,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Fregadero color solido (M) - Red (#FF0000)",
            "totalRecipes": 7,
            "totalProfit": 7,
            "idCatRecipe": 314,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Fregadero color solido (C) - Terracota (#E2725B)",
            "totalRecipes": 30,
            "totalProfit": 30,
            "idCatRecipe": 322,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Fregadero colores (M) - Terracota (#E2725B), Marr\u00f3n (#A52A2A), Crema (#FFFDD0)",
            "totalRecipes": 26,
            "totalProfit": 26,
            "idCatRecipe": 335,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Inodoro color solido (C) - Beige (#F5F5DC)",
            "totalRecipes": 21,
            "totalProfit": 21,
            "idCatRecipe": 340,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Inodoro colores (M) - Azul (#0000FF), Verde (#008000), Blanco (#FFFFFF)",
            "totalRecipes": 3,
            "totalProfit": 3,
            "idCatRecipe": 374,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Inodoro colores (G) - Terracota (#E2725B), Marr\u00f3n (#A52A2A), Crema (#FFFDD0)",
            "totalRecipes": 3,
            "totalProfit": 3,
            "idCatRecipe": 378,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Jarra color solido (M) - Gris (#808080)",
            "totalRecipes": 3,
            "totalProfit": 3,
            "idCatRecipe": 386,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Jarra colores (C) - Beige (#F5F5DC), Marr\u00f3n (#A52A2A), Crema (#FFFDD0)",
            "totalRecipes": 51,
            "totalProfit": 51,
            "idCatRecipe": 409,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Jarra colores (M) - Blanco (#FFFFFF), Gris (#808080), Negro (#000000)",
            "totalRecipes": 57,
            "totalProfit": 57,
            "idCatRecipe": 413,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Jarr\u00f3n color solido (C) - Azul (#0000FF)",
            "totalRecipes": 21,
            "totalProfit": 21,
            "idCatRecipe": 433,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Jarr\u00f3n color solido (C) - Terracota (#E2725B)",
            "totalRecipes": 52,
            "totalProfit": 52,
            "idCatRecipe": 448,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Jarr\u00f3n colores (G) - Beige (#F5F5DC), Marr\u00f3n (#A52A2A), Crema (#FFFDD0)",
            "totalRecipes": 56,
            "totalProfit": 56,
            "idCatRecipe": 453,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Ladrillo color solido (M) - Red (#FF0000)",
            "totalRecipes": 48,
            "totalProfit": 48,
            "idCatRecipe": 482,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Ladrillo colores (C) - Beige (#F5F5DC), Marr\u00f3n (#A52A2A), Crema (#FFFDD0)",
            "totalRecipes": 5,
            "totalProfit": 5,
            "idCatRecipe": 493,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Ladrillo colores (M) - Azul (#0000FF), Verde (#008000), Blanco (#FFFFFF)",
            "totalRecipes": 55,
            "totalProfit": 55,
            "idCatRecipe": 500,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Ladrillo colores (G) - Azul (#0000FF), Verde (#008000), Blanco (#FFFFFF)",
            "totalRecipes": 31,
            "totalProfit": 31,
            "idCatRecipe": 501,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Lavabo colores (G) - Azul (#0000FF), Verde (#008000), Blanco (#FFFFFF)",
            "totalRecipes": 28,
            "totalProfit": 28,
            "idCatRecipe": 543,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Maceta color solido (C) - Negro (#000000)",
            "totalRecipes": 14,
            "totalProfit": 14,
            "idCatRecipe": 568,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Mosaico color solido (C) - Verde (#008000)",
            "totalRecipes": 49,
            "totalProfit": 49,
            "idCatRecipe": 604,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Mosaico color solido (M) - Red (#FF0000)",
            "totalRecipes": 23,
            "totalProfit": 23,
            "idCatRecipe": 608,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Pimentero color solido (C) - Azul (#0000FF)",
            "totalRecipes": 3,
            "totalProfit": 3,
            "idCatRecipe": 643,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Pimentero color solido (C) - Verde (#008000)",
            "totalRecipes": 26,
            "totalProfit": 26,
            "idCatRecipe": 646,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Pimentero color solido (G) - Red (#FF0000)",
            "totalRecipes": 35,
            "totalProfit": 35,
            "idCatRecipe": 651,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Pimentero color solido (M) - Terracota (#E2725B)",
            "totalRecipes": 34,
            "totalProfit": 34,
            "idCatRecipe": 659,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Pimentero colores (M) - Azul (#0000FF), Verde (#008000), Blanco (#FFFFFF)",
            "totalRecipes": 8,
            "totalProfit": 8,
            "idCatRecipe": 668,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Platillo color solido (G) - Verde (#008000)",
            "totalRecipes": 49,
            "totalProfit": 49,
            "idCatRecipe": 690,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Platillo color solido (G) - Negro (#000000)",
            "totalRecipes": 29,
            "totalProfit": 29,
            "idCatRecipe": 696,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Platillo colores (G) - Blanco (#FFFFFF), Gris (#808080), Negro (#000000)",
            "totalRecipes": 35,
            "totalProfit": 35,
            "idCatRecipe": 708,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Platillo colores (M) - Terracota (#E2725B), Marr\u00f3n (#A52A2A), Crema (#FFFDD0)",
            "totalRecipes": 20,
            "totalProfit": 20,
            "idCatRecipe": 713,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Plato color solido (G) - Gris (#808080)",
            "totalRecipes": 19,
            "totalProfit": 19,
            "idCatRecipe": 723,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Plato color solido (M) - Verde (#008000)",
            "totalRecipes": 10,
            "totalProfit": 10,
            "idCatRecipe": 731,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Plato color solido (C) - Terracota (#E2725B)",
            "totalRecipes": 16,
            "totalProfit": 16,
            "idCatRecipe": 742,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Plato colores (G) - Blanco (#FFFFFF), Gris (#808080), Negro (#000000)",
            "totalRecipes": 54,
            "totalProfit": 54,
            "idCatRecipe": 750,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Salero color solido (M) - Marr\u00f3n (#A52A2A)",
            "totalRecipes": 24,
            "totalProfit": 24,
            "idCatRecipe": 767,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Taza color solido (C) - Azul (#0000FF)",
            "totalRecipes": 9,
            "totalProfit": 9,
            "idCatRecipe": 811,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Taza color solido (C) - Red (#FF0000)",
            "totalRecipes": 7,
            "totalProfit": 7,
            "idCatRecipe": 817,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Tetera color solido (M) - Blanco (#FFFFFF)",
            "totalRecipes": 10,
            "totalProfit": 10,
            "idCatRecipe": 884,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Tetera color solido (M) - Gris (#808080)",
            "totalRecipes": 31,
            "totalProfit": 31,
            "idCatRecipe": 890,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Tetera color solido (M) - Negro (#000000)",
            "totalRecipes": 2,
            "totalProfit": 2,
            "idCatRecipe": 905,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        },
        {
            "descriptionRecipe": "Tetera colores (M) - Terracota (#E2725B), Marr\u00f3n (#A52A2A), Crema (#FFFDD0)",
            "totalRecipes": 62,
            "totalProfit": 62,
            "idCatRecipe": 923,
            "FileName": null,
            "FileExtension": null,
            "FileSizeInBytes": null,
            "FilePath": null
        }
    ];
    
    //ESte es el segundo 
    // customerData: CustomerData[] =
    //     [
    //         {
    //             "purchaseCount": 1,
    //             "totalPurchases": 4000.0,
    //             "name": "Estibaliz",
    //             "lastName": "Iglesias",
    //             "middleName": "Guevara"
    //         },
    //         {
    //             "purchaseCount": 1,
    //             "totalPurchases": 10000.0,
    //             "name": "Rachida",
    //             "lastName": "Ojeda",
    //             "middleName": "Moyano"
    //         },
    //         {
    //             "purchaseCount": 1,
    //             "totalPurchases": 1500.0,
    //             "name": "Alexandra",
    //             "lastName": "Felipe",
    //             "middleName": "Cardona"
    //         },
    //         {
    //             "purchaseCount": 1,
    //             "totalPurchases": 4000.0,
    //             "name": "Angelica",
    //             "lastName": "Palacios",
    //             "middleName": "Garrido"
    //         },
    //         {
    //             "purchaseCount": 1,
    //             "totalPurchases": 8000.0,
    //             "name": "Markel",
    //             "lastName": "Maroto",
    //             "middleName": "San-Juan"
    //         },
    //         {
    //             "purchaseCount": 1,
    //             "totalPurchases": 14000.0,
    //             "name": "Marcelina",
    //             "lastName": "Megias",
    //             "middleName": "Verdu"
    //         },
    //         {
    //             "purchaseCount": 1,
    //             "totalPurchases": 12000.0,
    //             "name": "Roger",
    //             "lastName": "Barrientos",
    //             "middleName": "Cardona"
    //         },
    //         {
    //             "purchaseCount": 1,
    //             "totalPurchases": 5000.0,
    //             "name": "Estibaliz",
    //             "lastName": "Iglesias",
    //             "middleName": "Guevara"
    //         },
    //         {
    //             "purchaseCount": 1,
    //             "totalPurchases": 2400.0,
    //             "name": "Rachida",
    //             "lastName": "Ojeda",
    //             "middleName": "Moyano"
    //         },
    //         {
    //             "purchaseCount": 1,
    //             "totalPurchases": 1500.0,
    //             "name": "Alexandra",
    //             "lastName": "Felipe",
    //             "middleName": "Cardona"
    //         },
    //         {
    //             "purchaseCount": 1,
    //             "totalPurchases": 4000.0,
    //             "name": "Angelica",
    //             "lastName": "Palacios",
    //             "middleName": "Garrido"
    //         },
    //         {
    //             "purchaseCount": 1,
    //             "totalPurchases": 4000.0,
    //             "name": "Marcelina",
    //             "lastName": "Megias",
    //             "middleName": "Verdu"
    //         },
    //         {
    //             "purchaseCount": 1,
    //             "totalPurchases": 2000.0,
    //             "name": "Roger",
    //             "lastName": "Barrientos",
    //             "middleName": "Cardona"
    //         }
    //     ]

    chartData!: ChartData




    optionsBarras!: any
    getChartData(): ChartData {
        // Aquí generamos y devolvemos el objeto chartData que configuramos antes
        return this.chartData;
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
    basicOptionsGrafica!: any;
    chartDataPay!: any;


    ngOnInit() {


        // this.chartDataR = {
        //     labels: this.rawDataR.map(item => item.descriptionRecipe),
        //     datasets: [
        //         {
        //             label: 'Total de Recetas',
        //             data: this.rawDataR.map(item => item.totalRecipes),
        //             backgroundColor: '#42A5F5', // Color de las barras
        //         }
        //     ]
        // };

        // this.chartOptionsR = {
        //     scales: {
        //         y: {
        //             beginAtZero: true // Comenzar desde cero en el eje y
        //         }
        //     }
        // };


        const documentStyle = getComputedStyle(document.documentElement);
        const textColor = documentStyle.getPropertyValue('--text-color');
        const textColorSecondary = documentStyle.getPropertyValue('--text-color-secondary');
        const surfaceBorder = documentStyle.getPropertyValue('--surface-border');

        // const documentStyle = getComputedStyle(document.documentElement);
        // const textColor = documentStyle.getPropertyValue('--text-color');
        // const textColorSecondary = documentStyle.getPropertyValue('--text-color-secondary');
        // const surfaceBorder = documentStyle.getPropertyValue('--surface-border');


        // const jsonData = [
        //     {
        //         "purchaseCount": 10,
        //         "totalSales": 14370.0,
        //         "UserName": "francisco_la332",
        //         "name": "Francisco",
        //         "lastName": "Gaspar",
        //         "middleName": "Avila"
        //     },
        //     {
        //         "purchaseCount": 27,
        //         "totalSales": 75040.0,
        //         "UserName": "iryna_ro349",
        //         "name": "Iryna",
        //         "lastName": "Fern\u00e1ndez",
        //         "middleName": "Valero"
        //     },
        //     {
        //         "purchaseCount": 30,
        //         "totalSales": 42620.0,
        //         "UserName": "noel_da366",
        //         "name": "Noel",
        //         "lastName": "Mosquera",
        //         "middleName": "Estrada"
        //     },
        //     {
        //         "purchaseCount": 31,
        //         "totalSales": 43750.0,
        //         "UserName": "hilario_no383",
        //         "name": "Hilario",
        //         "lastName": "Alcantara",
        //         "middleName": "Moyano"
        //     },
        //     {
        //         "purchaseCount": 13,
        //         "totalSales": 12180.0,
        //         "UserName": "florin_ra400",
        //         "name": "Florin",
        //         "lastName": "Beltran",
        //         "middleName": "Rivera"
        //     },
        //     {
        //         "purchaseCount": 11,
        //         "totalSales": 26420.0,
        //         "UserName": "german_ra417",
        //         "name": "German",
        //         "lastName": "Rivera",
        //         "middleName": "Alcantara"
        //     },
        //     {
        //         "purchaseCount": 10,
        //         "totalSales": 4360.0,
        //         "UserName": "unax_ez434",
        //         "name": "Unax",
        //         "lastName": "Verdu",
        //         "middleName": "Ya\u00f1ez"
        //     },
        //     {
        //         "purchaseCount": 15,
        //         "totalSales": 5360.0,
        //         "UserName": "unai_pe451",
        //         "name": "Unai",
        //         "lastName": "Hidalgo",
        //         "middleName": "Felipe"
        //     },
        //     {
        //         "purchaseCount": 8,
        //         "totalSales": 2040.0,
        //         "UserName": "fabian_da468",
        //         "name": "Fabian",
        //         "lastName": "Quiroga",
        //         "middleName": "Ubeda"
        //     },
        //     {
        //         "purchaseCount": 9,
        //         "totalSales": 2620.0,
        //         "UserName": "maria_ia485",
        //         "name": "Maria",
        //         "lastName": "Cabanillas",
        //         "middleName": "Garc\u00eda"
        //     },
        //     {
        //         "purchaseCount": 6,
        //         "totalSales": 1140.0,
        //         "UserName": "narciso_du502",
        //         "name": "Narciso",
        //         "lastName": "Reyes",
        //         "middleName": "Verdu"
        //     },
        //     {
        //         "purchaseCount": 5,
        //         "totalSales": 900.0,
        //         "UserName": "anibal_ro519",
        //         "name": "Anibal",
        //         "lastName": "Garrido",
        //         "middleName": "Valero"
        //     },
        //     {
        //         "purchaseCount": 8,
        //         "totalSales": 3580.0,
        //         "UserName": "jeronima_ll536",
        //         "name": "Jeronima",
        //         "lastName": "Tirado",
        //         "middleName": "Martorell"
        //     },
        //     {
        //         "purchaseCount": 6,
        //         "totalSales": 1480.0,
        //         "UserName": "segundo_ar553",
        //         "name": "Segundo",
        //         "lastName": "Martin",
        //         "middleName": "Gaspar"
        //     },
        //     {
        //         "purchaseCount": 5,
        //         "totalSales": 910.0,
        //         "UserName": "julia_ar570",
        //         "name": "Julia",
        //         "lastName": "Ya\u00f1ez",
        //         "middleName": "Gaspar"
        //     },
        //     {
        //         "purchaseCount": 8,
        //         "totalSales": 430.0,
        //         "UserName": "leire_ez587",
        //         "name": "Leire",
        //         "lastName": "Martorell",
        //         "middleName": "Fern\u00e1ndez"
        //     }
        // ]

        // const labels = jsonData.map(item => item.name);
        // const purchaseData = jsonData.map(item => item.purchaseCount);
        // const salesData = jsonData.map(item => item.totalSales);

        // this.data = {
        //     labels: labels,
        //     datasets: [
        //         {
        //             label: 'Recuento de compras',
        //             fill: false,
        //             borderColor: documentStyle.getPropertyValue('--blue-500'),
        //             yAxisID: 'y',
        //             tension: 0.4,
        //             data: purchaseData
        //         },
        //         {
        //             label: 'Ventastotales',
        //             fill: false,
        //             borderColor: documentStyle.getPropertyValue('--green-500'),
        //             yAxisID: 'y1',
        //             tension: 0.4,
        //             data: salesData
        //         }
        //     ]
        // };

        this.options = {
            stacked: false,
            maintainAspectRatio: false,
            aspectRatio: 0.6,
            plugins: {
                legend: {
                    labels: {
                        color: textColor
                    }
                }
            },
            scales: {
                x: {
                    ticks: {
                        color: textColorSecondary
                    },
                    grid: {
                        color: surfaceBorder
                    }
                },
                y: {
                    type: 'linear',
                    display: true,
                    position: 'left',
                    ticks: {
                        color: textColorSecondary
                    },
                    grid: {
                        color: surfaceBorder
                    }
                },
                y1: {
                    type: 'linear',
                    display: true,
                    position: 'right',
                    ticks: {
                        color: textColorSecondary
                    },
                    grid: {
                        drawOnChartArea: false,
                        color: surfaceBorder
                    }
                }
            }
        };

        this.basicOptionsGrafica = {
            plugins: {
                legend: {
                    labels: {
                        color: textColor
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        color: textColorSecondary
                    },
                    grid: {
                        color: surfaceBorder,
                        drawBorder: false
                    }
                },
                x: {
                    ticks: {
                        color: textColorSecondary
                    },
                    grid: {
                        color: surfaceBorder,
                        drawBorder: false
                    }
                }
            }
        };

        // this.chartDataPay = {
        //     labels: this.arrayComprasp.map((item: any) => item.name),
        //     datasets: [
        //         {
        //             data: this.arrayComprasp.map((item: any) => item.totalQuantityRawMaterialUsed),
        //             backgroundColor: [
        //                 "#FF6384",
        //                 "#36A2EB",
        //                 "#FFCE56",
        //                 // Agregar más colores aquí si tienes más datos
        //             ],
        //             hoverBackgroundColor: [
        //                 "#FF6384",
        //                 "#36A2EB",
        //                 "#FFCE56",
        //                 // Agregar más colores aquí si tienes más datos
        //             ]
        //         }
        //     ]
        // };


        this.optionsBarras = {
            indexAxis: 'y',
            maintainAspectRatio: false,
            aspectRatio: 0.8,
            plugins: {
                legend: {
                    labels: {
                        color: textColor
                    }
                }
            },
            scales: {
                x: {
                    ticks: {
                        color: textColorSecondary,
                        font: {
                            weight: 500
                        }
                    },
                    grid: {
                        color: surfaceBorder,
                        drawBorder: false
                    }
                },
                y: {
                    ticks: {
                        color: textColorSecondary
                    },
                    grid: {
                        color: surfaceBorder,
                        drawBorder: false
                    }
                }
            }
        };
    }



    arrayComprasp: any[] = [
        {
            "totalQuantityRawMaterialUsed": 444,
            "name": "Arcilla de loza",
            "quantityWarehouse": 29225,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 444,
            "name": "Feldespato pot\u00e1sico (ortoclasa o microclina)",
            "quantityWarehouse": 57862,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 444,
            "name": "S\u00edlice de cuarzo (cristalino)",
            "quantityWarehouse": 36485,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 444,
            "name": "Almid\u00f3n de ma\u00edz (almid\u00f3n de ma\u00edz ceroso)",
            "quantityWarehouse": 34504,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 444,
            "name": "Esmalte transparentes",
            "quantityWarehouse": 373885,
            "quantityPackage": 100,
            "description": "Mililitro"
        },
        {
            "totalQuantityRawMaterialUsed": 444,
            "name": "\u00d3xido de hierro rojo",
            "quantityWarehouse": 116355,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 444,
            "name": "\u00d3xido de manganeso",
            "quantityWarehouse": 242918,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 444,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 68,
            "name": "Arcilla de loza",
            "quantityWarehouse": 29225,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 68,
            "name": "Feldespato pot\u00e1sico (ortoclasa o microclina)",
            "quantityWarehouse": 57862,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 68,
            "name": "S\u00edlice de cuarzo (cristalino)",
            "quantityWarehouse": 36485,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 68,
            "name": "Almid\u00f3n de ma\u00edz (almid\u00f3n de ma\u00edz ceroso)",
            "quantityWarehouse": 34504,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 68,
            "name": "Esmalte transparentes",
            "quantityWarehouse": 373885,
            "quantityPackage": 100,
            "description": "Mililitro"
        },
        {
            "totalQuantityRawMaterialUsed": 68,
            "name": "\u00d3xido de hierro rojo",
            "quantityWarehouse": 116355,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 68,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 212,
            "name": "Arcilla de loza",
            "quantityWarehouse": 29225,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 212,
            "name": "Feldespato pot\u00e1sico (ortoclasa o microclina)",
            "quantityWarehouse": 57862,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 212,
            "name": "S\u00edlice de cuarzo (cristalino)",
            "quantityWarehouse": 36485,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 212,
            "name": "Almid\u00f3n de ma\u00edz (almid\u00f3n de ma\u00edz ceroso)",
            "quantityWarehouse": 34504,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 212,
            "name": "Esmalte transparentes",
            "quantityWarehouse": 373885,
            "quantityPackage": 100,
            "description": "Mililitro"
        },
        {
            "totalQuantityRawMaterialUsed": 212,
            "name": "\u00d3xido de titanio",
            "quantityWarehouse": 125673,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 212,
            "name": "\u00d3xido de cromo",
            "quantityWarehouse": 23790,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 522,
            "name": "Arcilla de loza",
            "quantityWarehouse": 29225,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 522,
            "name": "Feldespato pot\u00e1sico (ortoclasa o microclina)",
            "quantityWarehouse": 57862,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 522,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 522,
            "name": "\u00d3xido de hierro rojo",
            "quantityWarehouse": 116355,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 522,
            "name": "\u00d3xido de manganeso",
            "quantityWarehouse": 242918,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 522,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 528,
            "name": "Arcilla de loza",
            "quantityWarehouse": 29225,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 528,
            "name": "Feldespato pot\u00e1sico (ortoclasa o microclina)",
            "quantityWarehouse": 57862,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 528,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 1056,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 528,
            "name": "\u00d3xido de manganeso",
            "quantityWarehouse": 242918,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 1056,
            "name": "\u00d3xido de hierro rojo",
            "quantityWarehouse": 116355,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 1056,
            "name": "\u00d3xido de titanio",
            "quantityWarehouse": 125673,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 228,
            "name": "Arcilla de gres",
            "quantityWarehouse": 13319,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 228,
            "name": "Feldespato c\u00e1lcico (anortita)",
            "quantityWarehouse": 67533,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 228,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 684,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 228,
            "name": "\u00d3xido de hierro amarillo",
            "quantityWarehouse": 8635,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 228,
            "name": "\u00d3xido de manganeso",
            "quantityWarehouse": 242918,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 228,
            "name": "\u00d3xido de hierro rojo",
            "quantityWarehouse": 116355,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 228,
            "name": "\u00d3xido de titanio",
            "quantityWarehouse": 125673,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 288,
            "name": "Arcilla de loza",
            "quantityWarehouse": 29225,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 288,
            "name": "Feldespato pot\u00e1sico (ortoclasa o microclina)",
            "quantityWarehouse": 57862,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 288,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 576,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 288,
            "name": "\u00d3xido de esta\u00f1o",
            "quantityWarehouse": 102067,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 576,
            "name": "\u00d3xido de manganeso",
            "quantityWarehouse": 242918,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 288,
            "name": "\u00d3xido de hierro negro",
            "quantityWarehouse": 328688,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 480,
            "name": "Arcilla refractaria",
            "quantityWarehouse": 38360,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 480,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 480,
            "name": "Almid\u00f3n de tapioca",
            "quantityWarehouse": 12320,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 480,
            "name": "\u00d3xido de manganeso",
            "quantityWarehouse": 242918,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 480,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 252,
            "name": "Arcilla refractaria",
            "quantityWarehouse": 38360,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 252,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 252,
            "name": "Almid\u00f3n de tapioca",
            "quantityWarehouse": 12320,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 504,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 252,
            "name": "\u00d3xido de esta\u00f1o",
            "quantityWarehouse": 102067,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 252,
            "name": "\u00d3xido de cobalto",
            "quantityWarehouse": 174367,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 252,
            "name": "Carbonato de cobalto",
            "quantityWarehouse": 174367,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 504,
            "name": "\u00d3xido de hierro negro",
            "quantityWarehouse": 328688,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 252,
            "name": "\u00d3xido de cobre",
            "quantityWarehouse": 109559,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 11760,
            "name": "Arcilla de porcelana",
            "quantityWarehouse": 171058,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 11760,
            "name": "Feldespato s\u00f3dico (albita o oligoclasa)",
            "quantityWarehouse": 225421,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 11760,
            "name": "S\u00edlice de cuarzo (cristalino)",
            "quantityWarehouse": 36485,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 11760,
            "name": "Almid\u00f3n de papa",
            "quantityWarehouse": 225421,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 11760,
            "name": "Esmalte transparentes",
            "quantityWarehouse": 373885,
            "quantityPackage": 100,
            "description": "Mililitro"
        },
        {
            "totalQuantityRawMaterialUsed": 23520,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 11760,
            "name": "\u00d3xido de esta\u00f1o",
            "quantityWarehouse": 102067,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 11760,
            "name": "\u00d3xido de cobalto",
            "quantityWarehouse": 174367,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 11760,
            "name": "Carbonato de cobalto",
            "quantityWarehouse": 174367,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 23520,
            "name": "\u00d3xido de hierro negro",
            "quantityWarehouse": 328688,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 11760,
            "name": "\u00d3xido de cobre",
            "quantityWarehouse": 109559,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 220,
            "name": "Arcilla de loza",
            "quantityWarehouse": 29225,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 220,
            "name": "Feldespato pot\u00e1sico (ortoclasa o microclina)",
            "quantityWarehouse": 57862,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 220,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 220,
            "name": "\u00d3xido de manganeso",
            "quantityWarehouse": 242918,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 220,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 310,
            "name": "Arcilla de loza",
            "quantityWarehouse": 29225,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 310,
            "name": "Feldespato pot\u00e1sico (ortoclasa o microclina)",
            "quantityWarehouse": 57862,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 310,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 310,
            "name": "\u00d3xido de titanio",
            "quantityWarehouse": 125673,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 310,
            "name": "\u00d3xido de cromo",
            "quantityWarehouse": 23790,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 740,
            "name": "Arcilla de loza",
            "quantityWarehouse": 29225,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 740,
            "name": "Feldespato pot\u00e1sico (ortoclasa o microclina)",
            "quantityWarehouse": 57862,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 740,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 1480,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 740,
            "name": "\u00d3xido de esta\u00f1o",
            "quantityWarehouse": 102067,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 1480,
            "name": "\u00d3xido de manganeso",
            "quantityWarehouse": 242918,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 740,
            "name": "\u00d3xido de hierro negro",
            "quantityWarehouse": 328688,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 21,
            "name": "Arcilla de loza",
            "quantityWarehouse": 29225,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 21,
            "name": "Feldespato pot\u00e1sico (ortoclasa o microclina)",
            "quantityWarehouse": 57862,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 21,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 21,
            "name": "\u00d3xido de cobre",
            "quantityWarehouse": 109559,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 21,
            "name": "\u00d3xido de hierro negro",
            "quantityWarehouse": 328688,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 21,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 65,
            "name": "Arcilla de loza",
            "quantityWarehouse": 29225,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 65,
            "name": "Feldespato pot\u00e1sico (ortoclasa o microclina)",
            "quantityWarehouse": 57862,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 65,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 130,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 65,
            "name": "\u00d3xido de esta\u00f1o",
            "quantityWarehouse": 102067,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 65,
            "name": "\u00d3xido de cobalto",
            "quantityWarehouse": 174367,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 65,
            "name": "Carbonato de cobalto",
            "quantityWarehouse": 174367,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 130,
            "name": "\u00d3xido de hierro negro",
            "quantityWarehouse": 328688,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 65,
            "name": "\u00d3xido de cobre",
            "quantityWarehouse": 109559,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 150,
            "name": "Arcilla de porcelana",
            "quantityWarehouse": 171058,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 150,
            "name": "Feldespato pot\u00e1sico (ortoclasa o microclina)",
            "quantityWarehouse": 57862,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 150,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 150,
            "name": "\u00d3xido de cobre",
            "quantityWarehouse": 109559,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 150,
            "name": "\u00d3xido de hierro negro",
            "quantityWarehouse": 328688,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 150,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 195,
            "name": "Arcilla de porcelana",
            "quantityWarehouse": 171058,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 195,
            "name": "Feldespato pot\u00e1sico (ortoclasa o microclina)",
            "quantityWarehouse": 57862,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 195,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 585,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 195,
            "name": "\u00d3xido de hierro amarillo",
            "quantityWarehouse": 8635,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 195,
            "name": "\u00d3xido de manganeso",
            "quantityWarehouse": 242918,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 195,
            "name": "\u00d3xido de hierro rojo",
            "quantityWarehouse": 116355,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 195,
            "name": "\u00d3xido de titanio",
            "quantityWarehouse": 125673,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 42,
            "name": "Arcilla de gres",
            "quantityWarehouse": 13319,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 42,
            "name": "Feldespato c\u00e1lcico (anortita)",
            "quantityWarehouse": 67533,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 42,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 42,
            "name": "\u00d3xido de hierro rojo",
            "quantityWarehouse": 116355,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 42,
            "name": "\u00d3xido de manganeso",
            "quantityWarehouse": 242918,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 42,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 148,
            "name": "Arcilla de gres",
            "quantityWarehouse": 13319,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 148,
            "name": "Feldespato c\u00e1lcico (anortita)",
            "quantityWarehouse": 67533,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 148,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 148,
            "name": "\u00d3xido de hierro negro",
            "quantityWarehouse": 328688,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 148,
            "name": "\u00d3xido de manganeso",
            "quantityWarehouse": 242918,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 120,
            "name": "Arcilla de gres",
            "quantityWarehouse": 13319,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 120,
            "name": "Feldespato c\u00e1lcico (anortita)",
            "quantityWarehouse": 67533,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 120,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 120,
            "name": "\u00d3xido de hierro rojo",
            "quantityWarehouse": 116355,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 120,
            "name": "\u00d3xido de titanio",
            "quantityWarehouse": 125673,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 474,
            "name": "Arcilla de gres",
            "quantityWarehouse": 13319,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 474,
            "name": "Feldespato c\u00e1lcico (anortita)",
            "quantityWarehouse": 67533,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 474,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 1422,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 474,
            "name": "\u00d3xido de hierro amarillo",
            "quantityWarehouse": 8635,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 474,
            "name": "\u00d3xido de manganeso",
            "quantityWarehouse": 242918,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 474,
            "name": "\u00d3xido de hierro rojo",
            "quantityWarehouse": 116355,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 474,
            "name": "\u00d3xido de titanio",
            "quantityWarehouse": 125673,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 42,
            "name": "Arcilla de porcelana",
            "quantityWarehouse": 171058,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 42,
            "name": "Feldespato s\u00f3dico (albita o oligoclasa)",
            "quantityWarehouse": 225421,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 42,
            "name": "S\u00edlice de cuarzo (cristalino)",
            "quantityWarehouse": 36485,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 42,
            "name": "Almid\u00f3n de papa",
            "quantityWarehouse": 225421,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 42,
            "name": "Esmalte transparentes",
            "quantityWarehouse": 373885,
            "quantityPackage": 100,
            "description": "Mililitro"
        },
        {
            "totalQuantityRawMaterialUsed": 42,
            "name": "\u00d3xido de cobalto",
            "quantityWarehouse": 174367,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 42,
            "name": "Carbonato de cobalto",
            "quantityWarehouse": 174367,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 42,
            "name": "\u00d3xido de hierro negro",
            "quantityWarehouse": 328688,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 376,
            "name": "Arcilla de porcelana",
            "quantityWarehouse": 171058,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 376,
            "name": "Feldespato pot\u00e1sico (ortoclasa o microclina)",
            "quantityWarehouse": 57862,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 376,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 376,
            "name": "\u00d3xido de hierro rojo",
            "quantityWarehouse": 116355,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 376,
            "name": "\u00d3xido de manganeso",
            "quantityWarehouse": 242918,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 376,
            "name": "Caol\u00edn",
            "quantityWarehouse": 613391,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 408,
            "name": "Arcilla de porcelana",
            "quantityWarehouse": 171058,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 408,
            "name": "Feldespato pot\u00e1sico (ortoclasa o microclina)",
            "quantityWarehouse": 57862,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 408,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 408,
            "name": "\u00d3xido de hierro negro",
            "quantityWarehouse": 328688,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 408,
            "name": "\u00d3xido de manganeso",
            "quantityWarehouse": 242918,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 160,
            "name": "Arcilla de porcelana",
            "quantityWarehouse": 171058,
            "quantityPackage": 350,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 160,
            "name": "Feldespato pot\u00e1sico (ortoclasa o microclina)",
            "quantityWarehouse": 57862,
            "quantityPackage": 100,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 160,
            "name": "S\u00edlice coloidal",
            "quantityWarehouse": 157077,
            "quantityPackage": 50,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 160,
            "name": "\u00d3xido de titanio",
            "quantityWarehouse": 125673,
            "quantityPackage": 10,
            "description": "Gramo"
        },
        {
            "totalQuantityRawMaterialUsed": 160,
            "name": "\u00d3xido de cromo",
            "quantityWarehouse": 23790,
            "quantityPackage": 10,
            "description": "Gramo"
        }
    ]
}