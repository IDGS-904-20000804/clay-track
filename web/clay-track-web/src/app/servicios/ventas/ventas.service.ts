import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class VentasService {
  private baseUrl = 'https://localhost:7106/';
  private token = localStorage.getItem("token");

  constructor(private http: HttpClient) {
  }

  obtenerStock(): Observable<any> {
    const url = `${this.baseUrl}api/Stock/GetAll`;
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    
    console.log('ESTE ES EL TOKEN', token)
    return this.http.get<any>(url, { headers });
  }

  agregarStock(idReceta:any, totalReceta:any): any {
    const token = this.token;
    const url = `${this.baseUrl}api/Stock/InsertStock`;
    const params = {
      idCatRecipe: idReceta,
      totalRecipes: totalReceta
    };
    // const formData = new FormData();
    // formData.append('idCatRecipe', idReceta);
    // formData.append('totalRecipes', totalReceta);
  
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`,
      'accept': '*/*'
    });
  
    return this.http.post(url, null, { headers, params });
  }

  obtenerStockPorId(id:string):Observable<any>{
    const url = `${this.baseUrl}api/Stock/GetOne${id}`; // Ajusta la URL según la ruta de la API para guardar provedors
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.get<any>(url, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }

  eliminarStock(id:string): Observable<any> {
    const url = `${this.baseUrl}api/Stock/Delete${id}`; // Ajusta la URL según la ruta de la API para guardar provedors
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.put<any>(url, null, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }
}
