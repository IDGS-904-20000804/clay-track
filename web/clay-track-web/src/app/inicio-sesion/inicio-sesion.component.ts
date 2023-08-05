import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { MenuComponent } from '../menu/menu.component';
import { LoginService } from '../servicios/login/login.service';
import { ConfirmationService, MessageService } from 'primeng/api';

@Component({
  selector: 'app-inicio-sesion',
  templateUrl: './inicio-sesion.component.html',
  styleUrls: ['./inicio-sesion.component.css'],
  providers: [ConfirmationService, MessageService]

})
export class InicioSesionComponent {
  visible: boolean = false;
  usuario: string = '';
  contrasenia: string = '';
  mostrarContrasenia: boolean = false;
  tipoContrasenia: string = 'password';

  constructor(private router: Router,
    private _servicioLogin: LoginService,
    private confirmationService: ConfirmationService, private messageService: MessageService ) { }

  cambiarTipoContrasenia() {
    this.tipoContrasenia = this.mostrarContrasenia ? 'text' : 'password';
  }

  ingresarUsuario() {
    this.router.navigate(['/Inicio']);
  }

  registrarseRuta(){
    this.router.navigate(['/Registro']);
    }

  obtenerInicioSesion(){
    this._servicioLogin.login(this.usuario, this.contrasenia).subscribe((datos)=>{
      localStorage.setItem("token", datos.token);
      console.log(datos)
      this.visible=false;
      this.messageService.add({key: 'tc', severity: 'success', summary: 'Exito', detail: 'Usuario cargado correctamente.' });
      setTimeout(() => {
        this.router.navigate(['/Inicio']);
        console.log('Entre');
      }, 2000); // 10000 milisegundos = 10 segundos
    }, (err)=>{
      console.log(err)
      this.messageService.add({key: 'tc', severity: 'error', summary: 'Error', detail: 'Usuario y contraseña incorrectos intenta de nuevo.' });
    })
  }
  
}
