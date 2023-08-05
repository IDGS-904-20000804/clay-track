import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { MenuComponent } from '../menu/menu.component';
import { LoginService } from '../servicios/login/login.service';
import { ConfirmationService, MessageService } from 'primeng/api';
import jwt_decode from 'jwt-decode';


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
  token:any;

  constructor(private router: Router,
    private _servicioLogin: LoginService,
    private confirmationService: ConfirmationService, private messageService: MessageService) { }

  cambiarTipoContrasenia() {
    this.tipoContrasenia = this.mostrarContrasenia ? 'text' : 'password';
  }

  ingresarUsuario() {
    this.router.navigate(['/Inicio']);
  }

  registrarseRuta() {
    this.router.navigate(['/Registro']);
  }

  getDecodedAccessToken(token: string): any {
    try {
      return jwt_decode(token);
    } catch (Error) {
      return null;
    }
  }

  obtenerInicioSesion() {
    this._servicioLogin.login(this.usuario, this.contrasenia).subscribe((datos) => {
      localStorage.setItem("token", datos.jwtToken);
      console.log(datos)
      this.visible = false;
      this.messageService.add({ key: 'tc', severity: 'success', summary: 'Exito', detail: 'Usuario cargado correctamente.' });
      this.router.navigate(['/Inicio']);
      console.log('Entre');
      this.token=localStorage.getItem("token");
      const tokenInfo = this.getDecodedAccessToken(this.token); 
      console.log(tokenInfo)
      localStorage.setItem('usuario',tokenInfo['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress']);
      localStorage.setItem('rol',tokenInfo['http://schemas.microsoft.com/ws/2008/06/identity/claims/role']);
      console.log(tokenInfo);
    }, (err) => {
      console.log(err)
      this.messageService.add({ key: 'tc', severity: 'error', summary: 'Error', detail: 'Usuario y contraseña incorrectos intenta de nuevo.' });
    })
  }

}
