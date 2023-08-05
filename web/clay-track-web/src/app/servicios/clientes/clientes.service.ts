import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';

export interface Client {
  idCatClient: number;
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
export class ClientesService {
  private baseUrl = 'https://localhost:7106/';
  private token=localStorage.getItem("token");

  constructor(private http: HttpClient) {
   }

   obtenerClientes(): Observable<any> {
    const url = `${this.baseUrl}api/Client`;
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    
    console.log('ESTE ES EL TOKEN', token)
    return this.http.get<any>(url, { headers });
  }

  guardarCliente(cliente: Client): Observable<Client> {
    const url = `${this.baseUrl}api/Client`;
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
}
