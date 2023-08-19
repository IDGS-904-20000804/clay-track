import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { MenuComponent } from 'src/app/menu/menu.component';
import { EmpleadosComponent } from '../empleados/empleados/empleados.component';
import { ClientesComponent } from '../clientes/clientes/clientes.component';



const routes: Routes = [
  { path: 'Inicio', component: MenuComponent },
  { path: 'Empleados', component: EmpleadosComponent },
  { path: 'Clientes', component: ClientesComponent }];


@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class ModulosRoutingModule { }
