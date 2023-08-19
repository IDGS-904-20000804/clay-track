import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AnalisisService {
  private baseUrl = 'https://localhost:7106/';
  private token=localStorage.getItem("token");

  constructor(private http: HttpClient) {
   }

   obtenerDatos(targetDate:string,type:string): Observable<any> {
    const url = `${this.baseUrl}api/Analytics/GetAll`;
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    const params = {
      targetDate: targetDate,
      type: type
    };
    
    console.log('ESTE ES EL TOKEN', token)
    return this.http.get<any>(url, { headers , params});
  }
}
