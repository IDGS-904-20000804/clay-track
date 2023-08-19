import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MenuComponent } from '../menu/menu.component';
import { InicioSesionComponent } from '../inicio-sesion/inicio-sesion.component';
import { RegistroComponent } from '../registro/registro.component';
import { AlmacenComponent } from './almacen/almacen/almacen.component';
import { ClientesComponent } from './clientes/clientes/clientes.component';
import { ComprasComponent } from './compras/compras/compras.component';
import { EmpleadosComponent } from './empleados/empleados/empleados.component';
import { EnviosComponent } from './envios/envios/envios.component';
import { MateriaPrimaComponent } from './materiaPrima/materia-prima/materia-prima.component';
import { ProveedoresComponent } from './proveedores/proveedores/proveedores.component';
import { RecetasComponent } from './recetas/recetas/recetas.component';
import { VentasComponent } from './ventas/ventas/ventas.component';

const routes: Routes = [
  { path: 'Inicio', component: MenuComponent },
  { path: 'Empleados', component: EmpleadosComponent },
  { path: 'Clientes', component: ClientesComponent },
  { path: 'Almacen', component: AlmacenComponent },
  { path: 'MateriaPrima', component: MateriaPrimaComponent },
  { path: 'Recetas', component: RecetasComponent },
  { path: 'Ventas', component: VentasComponent },
  { path: 'Proveedores', component: ProveedoresComponent },
  { path: 'Compras', component: ComprasComponent },
  { path: 'Envios', component: EnviosComponent },
  { path: '**', redirectTo: 'Inicio' }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ModulosRoutingModule { }
