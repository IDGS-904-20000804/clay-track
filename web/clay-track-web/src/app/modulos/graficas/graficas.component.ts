import { trigger, state, style, transition, animate } from '@angular/animations';
import { Component } from '@angular/core';
import { ChartData, ChartOptions } from 'chart.js';

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
    columna:string='col-9';
  navBar:boolean=false;

  toggleNavBar() {
    if(this.navBar==false){
      this.navBar =true;
      this.columna='col-12';
    }else{
      this.navBar =false;
      this.columna='col-9';
    }
    
  }

    ngOnInit() {
        const documentStyle = getComputedStyle(document.documentElement);
        const textColor = documentStyle.getPropertyValue('--text-color');
        const textColorSecondary = documentStyle.getPropertyValue('--text-color-secondary');
        const surfaceBorder = documentStyle.getPropertyValue('--surface-border');
        const jsonData = [
          {
              "purchaseCount": 10,
              "totalSales": 14370.0,
              "UserName": "francisco_la332",
              "name": "Francisco",
              "lastName": "Gaspar",
              "middleName": "Avila"
          },
          {
              "purchaseCount": 27,
              "totalSales": 75040.0,
              "UserName": "iryna_ro349",
              "name": "Iryna",
              "lastName": "Fern\u00e1ndez",
              "middleName": "Valero"
          },
          {
              "purchaseCount": 30,
              "totalSales": 42620.0,
              "UserName": "noel_da366",
              "name": "Noel",
              "lastName": "Mosquera",
              "middleName": "Estrada"
          },
          {
              "purchaseCount": 31,
              "totalSales": 43750.0,
              "UserName": "hilario_no383",
              "name": "Hilario",
              "lastName": "Alcantara",
              "middleName": "Moyano"
          },
          {
              "purchaseCount": 13,
              "totalSales": 12180.0,
              "UserName": "florin_ra400",
              "name": "Florin",
              "lastName": "Beltran",
              "middleName": "Rivera"
          },
          {
              "purchaseCount": 11,
              "totalSales": 26420.0,
              "UserName": "german_ra417",
              "name": "German",
              "lastName": "Rivera",
              "middleName": "Alcantara"
          },
          {
              "purchaseCount": 10,
              "totalSales": 4360.0,
              "UserName": "unax_ez434",
              "name": "Unax",
              "lastName": "Verdu",
              "middleName": "Ya\u00f1ez"
          },
          {
              "purchaseCount": 15,
              "totalSales": 5360.0,
              "UserName": "unai_pe451",
              "name": "Unai",
              "lastName": "Hidalgo",
              "middleName": "Felipe"
          },
          {
              "purchaseCount": 8,
              "totalSales": 2040.0,
              "UserName": "fabian_da468",
              "name": "Fabian",
              "lastName": "Quiroga",
              "middleName": "Ubeda"
          },
          {
              "purchaseCount": 9,
              "totalSales": 2620.0,
              "UserName": "maria_ia485",
              "name": "Maria",
              "lastName": "Cabanillas",
              "middleName": "Garc\u00eda"
          },
          {
              "purchaseCount": 6,
              "totalSales": 1140.0,
              "UserName": "narciso_du502",
              "name": "Narciso",
              "lastName": "Reyes",
              "middleName": "Verdu"
          },
          {
              "purchaseCount": 5,
              "totalSales": 900.0,
              "UserName": "anibal_ro519",
              "name": "Anibal",
              "lastName": "Garrido",
              "middleName": "Valero"
          },
          {
              "purchaseCount": 8,
              "totalSales": 3580.0,
              "UserName": "jeronima_ll536",
              "name": "Jeronima",
              "lastName": "Tirado",
              "middleName": "Martorell"
          },
          {
              "purchaseCount": 6,
              "totalSales": 1480.0,
              "UserName": "segundo_ar553",
              "name": "Segundo",
              "lastName": "Martin",
              "middleName": "Gaspar"
          },
          {
              "purchaseCount": 5,
              "totalSales": 910.0,
              "UserName": "julia_ar570",
              "name": "Julia",
              "lastName": "Ya\u00f1ez",
              "middleName": "Gaspar"
          },
          {
              "purchaseCount": 8,
              "totalSales": 430.0,
              "UserName": "leire_ez587",
              "name": "Leire",
              "lastName": "Martorell",
              "middleName": "Fern\u00e1ndez"
          }
      ]
    
        const labels = jsonData.map(item => item.name);
        const purchaseData = jsonData.map(item => item.purchaseCount);
        const salesData = jsonData.map(item => item.totalSales);
        
        this.data = {
            labels: labels,
            datasets: [
                {
                    label: 'Recuento de compras',
                    fill: false,
                    borderColor: documentStyle.getPropertyValue('--blue-500'),
                    yAxisID: 'y',
                    tension: 0.4,
                    data: purchaseData
                },
                {
                    label: 'Ventastotales',
                    fill: false,
                    borderColor: documentStyle.getPropertyValue('--green-500'),
                    yAxisID: 'y1',
                    tension: 0.4,
                    data: salesData
                }
            ]
        };
        
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
    }
}