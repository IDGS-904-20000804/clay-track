import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class LoginService {
  private baseUrl = 'https://localhost:7106/';

  constructor(private http: HttpClient) {
   }

   login(usuario:string, contrasenia:string): Observable<any> {
    const url = `${this.baseUrl}api/Account/Login`;
    const body = {
      username: usuario,
      password: contrasenia
    };
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      'accept': 'text/plain'
    });

    return this.http.post<any>(url, body, { headers });
  }
}
