import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
export interface Employee {
  idCatEmployee: number;
  fkCatPerson: number;
  fkUser: string;
  fkRol: string;
  person: {
    idCatPerson: number;
    name: string;
    lastName: string;
    middleName: string;
    phone: string;
    postalCode: number;
    streetNumber: string;
    apartmentNumber: string;
    street: string;
    neighborhood: string;
    status: boolean;
    creationDate: string;
    updateDate: string;
  };
  user: {
    id: string;
    userName: string;
    normalizedUserName: string;
    email: string;
    normalizedEmail: string;
    emailConfirmed: boolean;
    passwordHash: string;
    securityStamp: string;
    concurrencyStamp: string;
    phoneNumber: string;
    phoneNumberConfirmed: boolean;
    twoFactorEnabled: boolean;
    lockoutEnd: string;
    lockoutEnabled: boolean;
    accessFailedCount: number;
  };
  role: {
    id: string;
    name: string;
    normalizedName: string;
    concurrencyStamp: string;
  };
}

@Injectable({
  providedIn: 'root'
})
export class EmpleadosService {
  private baseUrl = 'https://localhost:7106/';
  private token=localStorage.getItem("token");

  constructor(private http: HttpClient) {
   }

   obtenerEmpleados(): Observable<any> {
    const url = `${this.baseUrl}api/Employee`;
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    
    console.log('ESTE ES EL TOKEN', token)
    return this.http.get<any>(url, { headers });
  }

  
  guardarEmpleado(empleado: Employee): Observable<any> {
    const url = `${this.baseUrl}api/Employee`; // Ajusta la URL según la ruta de la API para guardar empleados
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.post<Employee>(url, empleado, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }
}
