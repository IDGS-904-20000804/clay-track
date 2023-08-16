import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class EnvioService {
  private baseUrl = 'https://localhost:7106/';
  private token=localStorage.getItem("token");

  constructor(private http: HttpClient) {
   }

   obtenerEnvio(): Observable<any> {
    const url = `${this.baseUrl}api/Shipment/GetAll`;
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    
    console.log('ESTE ES EL TOKEN', token)
    return this.http.get<any>(url, { headers });
  }

  obtenerDetalleEnvio(id:string): Observable<any> {
    const url = `${this.baseUrl}api/Shipment/GetAllForClient`;
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    const params = {
      clientId: id
    };
    
    
    console.log('ESTE ES EL TOKEN', token)
    return this.http.get<any>(url, { headers,params });
  }

  enviarEnvio(id:string): Observable<any> {
    const url = `${this.baseUrl}api/Shipment/Delivered${id}`;
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });

    
    
    
    console.log('ESTE ES EL TOKEN', token)
    return this.http.put<any>(url, { headers });
  }
}
