import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';

export interface Supplier {
  idCatSupplier: number;
  email: string;
  fkCatPerson: number;
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
}

@Injectable({
  providedIn: 'root'
})
export class ProveedorService {
  private baseUrl = 'https://localhost:7106/';
  private token=localStorage.getItem("token");

  constructor(private http: HttpClient) {
   }

   obtenerProveedor(): Observable<any> {
    const url = `${this.baseUrl}api/Supplier`;
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    
    console.log('ESTE ES EL TOKEN', token)
    return this.http.get<any>(url, { headers });
  }

  guardarProvedor(provedor: Supplier): Observable<any> {
    const url = `${this.baseUrl}api/Supplier`; // Ajusta la URL según la ruta de la API para guardar provedors
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.post<Supplier>(url, provedor, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }

  actualizarProvedor(provedor: Supplier,id:number): Observable<any> {
    const url = `${this.baseUrl}api/Supplier/${id}`; // Ajusta la URL según la ruta de la API para guardar provedors
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.put<Supplier>(url, provedor, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }

  eliminarProvedor(id:number): Observable<any> {
    const url = `${this.baseUrl}api/Supplier/${id}`; // Ajusta la URL según la ruta de la API para guardar provedors
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.delete<Supplier>(url, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }

}
