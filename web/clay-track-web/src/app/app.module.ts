import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MenuComponent } from './menu/menu.component';
import { RegistroComponent } from './registro/registro.component';
import { InicioSesionComponent } from './inicio-sesion/inicio-sesion.component';
import { PrimeNgModule } from './componentes/prime-ng/prime-ng.module';
import { AngularMaterialModule } from './componentes/angular-material/angular-material.module';
import { EmpleadosComponent } from './modulos/empleados/empleados/empleados.component';
import { ClientesComponent } from './modulos/clientes/clientes/clientes.component';
import { AlmacenComponent } from './modulos/almacen/almacen/almacen.component';
import { MateriaPrimaComponent } from './modulos/materiaPrima/materia-prima/materia-prima.component';
import { RecetasComponent } from './modulos/recetas/recetas/recetas.component';
import { VentasComponent } from './modulos/ventas/ventas/ventas.component';
import { ProveedoresComponent } from './modulos/proveedores/proveedores/proveedores.component';
import { ComprasComponent } from './modulos/compras/compras/compras.component';
import { EnviosComponent } from './modulos/envios/envios/envios.component';
import { StockComponent } from './modulos/stock/stock/stock.component';
import { HttpClientModule } from '@angular/common/http';
import { InicioComponent } from './inicio/inicio.component';

@NgModule({
  declarations: [
    AppComponent,
    RegistroComponent,
    
   
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    PrimeNgModule,
    AngularMaterialModule,
    HttpClientModule
  ],
  exports:[
    PrimeNgModule,
    AngularMaterialModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
