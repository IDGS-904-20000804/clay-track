import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CompraService {
  private baseUrl = 'https://localhost:7106/';
  private token=localStorage.getItem("token");

  constructor(private http: HttpClient) {
   }

   obtenerCompra(): Observable<any> {
    const url = `${this.baseUrl}api/Purchase`;
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    
    console.log('ESTE ES EL TOKEN', token)
    return this.http.get<any>(url, { headers });
  }
}
