import { Component } from '@angular/core';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.css']
})
export class MenuComponent {
  isSidebarCollapsed = false;
  usuario!:any;
  rol!:any;

  ngOnInit(): void {
    this.usuario=localStorage.getItem('usuario');
    this.rol=localStorage.getItem('rol');
  }

  onToggleSidebar() {
    this.isSidebarCollapsed = !this.isSidebarCollapsed;
    const sidebar = document.getElementById('sidebar');
    const content = document.getElementById('content');
    if (sidebar && content) {
      if (this.isSidebarCollapsed) {
        sidebar.classList.add('active');
        content.classList.add('active');
      } else {
        sidebar.classList.remove('active');
        content.classList.remove('active');
      }
    }
  }

  cerrarSesion(){
    localStorage.clear()
  }
}
