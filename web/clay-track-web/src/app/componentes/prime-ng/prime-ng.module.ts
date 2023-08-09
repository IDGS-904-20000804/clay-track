import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ButtonModule } from 'primeng/button';
import { CheckboxModule } from 'primeng/checkbox';
import { FormsModule } from '@angular/forms';
import { PasswordModule } from 'primeng/password';
import { InputTextModule } from 'primeng/inputtext';
import { InicioSesionComponent } from 'src/app/inicio-sesion/inicio-sesion.component';
import { InputSwitchModule } from 'primeng/inputswitch';
import { AppRoutingModule } from 'src/app/app-routing.module';
import { TableModule } from 'primeng/table';
import { EmpleadosComponent } from 'src/app/modulos/empleados/empleados/empleados.component';
import { ConfirmDialogModule } from 'primeng/confirmdialog';
import { ToastModule } from 'primeng/toast';
import { DialogModule } from 'primeng/dialog';
import { ClientesComponent } from 'src/app/modulos/clientes/clientes/clientes.component';
import { MateriaPrimaComponent } from 'src/app/modulos/materiaPrima/materia-prima/materia-prima.component';
import { AlmacenComponent } from 'src/app/modulos/almacen/almacen/almacen.component';
import { RecetasComponent } from 'src/app/modulos/recetas/recetas/recetas.component';
import { VentasComponent } from 'src/app/modulos/ventas/ventas/ventas.component';
import { ProveedoresComponent } from 'src/app/modulos/proveedores/proveedores/proveedores.component';
import { ComprasComponent } from 'src/app/modulos/compras/compras/compras.component';
import { EnviosComponent } from 'src/app/modulos/envios/envios/envios.component';
import { StockComponent } from 'src/app/modulos/stock/stock/stock.component';
import { DataViewModule, DataViewLayoutOptions } from 'primeng/dataview';
import { BrowserModule } from '@angular/platform-browser';
import { RatingModule } from 'primeng/rating';
import { TagModule } from 'primeng/tag';
import { InputNumberModule } from 'primeng/inputnumber';
import { MenuComponent } from 'src/app/menu/menu.component';
import { MultiSelectModule } from 'primeng/multiselect';
import { ChartModule } from 'primeng/chart';
import { GraficasComponent } from 'src/app/modulos/graficas/graficas.component';

@NgModule({
  declarations: [
    InicioSesionComponent,
    EmpleadosComponent,
    ClientesComponent,
    MateriaPrimaComponent,
    AlmacenComponent,
    MateriaPrimaComponent,
    RecetasComponent,
    VentasComponent,
    ProveedoresComponent,
    ComprasComponent,
    EnviosComponent,
    StockComponent,
    MenuComponent,
    GraficasComponent
  ],
  imports: [
    CommonModule,
    ButtonModule,
    CheckboxModule,
    InputTextModule,
    FormsModule,
    PasswordModule,
    InputSwitchModule,
    AppRoutingModule,
    TableModule,
    ConfirmDialogModule,
    ToastModule,
    DialogModule,
    DataViewModule,
    BrowserModule,
    RatingModule,
    TagModule,
    ButtonModule,
    InputNumberModule,
    MultiSelectModule,
    ChartModule
    
    
  ],
  exports: [
    InicioSesionComponent,
    EmpleadosComponent,
    ClientesComponent,
    MateriaPrimaComponent,
    AlmacenComponent,
    MateriaPrimaComponent,
    RecetasComponent,
    VentasComponent,
    ProveedoresComponent,
    ComprasComponent,
    EnviosComponent,
    StockComponent,
    MenuComponent,
    MultiSelectModule,
    ChartModule
  ]
})
export class PrimeNgModule { }
