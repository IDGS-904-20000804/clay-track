import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
export interface Empleado {
  idCatEmployee: number;
  fkCatPerson: number;
  fkUser: number | string;
  fkRol: string;
  person: {
    idCatPerson: number;
    name: string;
    lastName: string;
    middleName: string | undefined;
    phone: string;
    postalCode: number;
    streetNumber: string | number;
    apartmentNumber: string | undefined;
    street: string;
    neighborhood: string;
    status: boolean;
    creationDate: string;
    updateDate: string;
  };
  user: {
    id: string;
    userName: string;
    email: string;
    passwordHash: string;
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
    const url = `${this.baseUrl}api/Employee/GetAll`;
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    
    console.log('ESTE ES EL TOKEN', token)
    return this.http.get<any>(url, { headers });
  }

  
  guardarEmpleado(empleado: Empleado): Observable<any> {
    const url = `${this.baseUrl}api/Employee/AddEmployee`; // Ajusta la URL según la ruta de la API para guardar empleados
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.post<Empleado>(url, empleado, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }

  obtenerEmpleadoPorId(id:string):Observable<Empleado>{
    const url = `${this.baseUrl}api/Employee/GetOne${id}`; // Ajusta la URL según la ruta de la API para guardar provedors
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.get<Empleado>(url, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }

  eliminarEmpleado(id:string): Observable<any> {
    const url = `${this.baseUrl}api/Employee/Delete${id}`; // Ajusta la URL según la ruta de la API para guardar provedors
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.put<any>(url,null, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }

}
