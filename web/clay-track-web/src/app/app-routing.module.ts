import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { InicioSesionComponent } from './inicio-sesion/inicio-sesion.component';
import { RegistroComponent } from './registro/registro.component';
import { MenuComponent } from './menu/menu.component';
import { EmpleadosComponent } from './modulos/empleados/empleados/empleados.component';
import { ClientesComponent } from './modulos/clientes/clientes/clientes.component';
import { AlmacenComponent } from './modulos/almacen/almacen/almacen.component';
import { MateriaPrimaComponent } from './modulos/materiaPrima/materia-prima/materia-prima.component';
import { RecetasComponent } from './modulos/recetas/recetas/recetas.component';
import { VentasComponent } from './modulos/ventas/ventas/ventas.component';
import { ProveedoresComponent } from './modulos/proveedores/proveedores/proveedores.component';
import { ComprasComponent } from './modulos/compras/compras/compras.component';
import { EnviosComponent } from './modulos/envios/envios/envios.component';
import { GraficasComponent } from './modulos/graficas/graficas.component';
import { InicioComponent } from './inicio/inicio.component';
import { TiendaComponent } from './modulos/tienda/tienda/tienda.component';

const routes: Routes = [
  { path: 'Inicio', component: MenuComponent },
  { path: 'InicioSesion', component: InicioSesionComponent },
  { path: 'Registro', component: RegistroComponent },
  { path: 'Empleados', component: EmpleadosComponent },
  { path: 'EditarEmpleados/:id', component: ProveedoresComponent } ,
  { path: 'Clientes', component: ClientesComponent },
  { path: 'EditarClientes/:id', component: ClientesComponent } ,
  { path: 'Almacen', component: AlmacenComponent },
  { path: 'MateriaPrima', component: MateriaPrimaComponent },
  { path: 'Recetas', component: RecetasComponent },
  { path: 'Ventas', component: VentasComponent },
  { path: 'Proveedores', component: ProveedoresComponent },
  { path: 'EditarProveedores/:id', component: ProveedoresComponent } ,
  { path: 'Compras', component: ComprasComponent },
  { path: 'Envios', component: EnviosComponent },
  { path: 'Dashboard', component: GraficasComponent },
  { path: 'Inicial', component: InicioComponent },
  { path: 'TiendaOnline', component: TiendaComponent },
  { path: '**', redirectTo: 'Inicial' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
