import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';

export interface Client {
  idCatClient: number;
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
export class ClientesService {
  private baseUrl = 'https://localhost:7106/';
  private token=localStorage.getItem("token");

  constructor(private http: HttpClient) {
   }

   obtenerClientes(): Observable<any> {
    const url = `${this.baseUrl}api/Client/GetAll`;
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    
    console.log('ESTE ES EL TOKEN', token)
    return this.http.get<any>(url, { headers });
  }

  guardarCliente(cliente: Client): Observable<Client> {
    const url = `${this.baseUrl}api/Client/AddClient`;
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.post<Client>(url, cliente, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Log the error to the console.
        return throwError(error); // Re-throw the error to be caught by the calling component.
      })
    );
  }

  obtenerClientePorId(id:string):Observable<Client>{
    const url = `${this.baseUrl}api/Client/GetOne${id}`; // Ajusta la URL según la ruta de la API para guardar provedors
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.get<Client>(url, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }

  eliminarCliente(id:string): Observable<any> {
    const url = `${this.baseUrl}api/Client/Delete${id}`; // Ajusta la URL según la ruta de la API para guardar provedors
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.put<Client>(url, null, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }

}
