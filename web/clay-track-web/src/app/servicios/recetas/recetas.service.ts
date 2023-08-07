import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';

export interface RawMaterial {
  idCatalog: number;
  quantity: string;
  fkCatRawMaterial: number;
}

export interface Product {
  name: string;
  price: number;
  imagePath: string;
  fkCatSize: number;
  colorIds: any[];
  rawMaterials: RawMaterial[];
}

@Injectable({
  providedIn: 'root'
})
export class RecetasService {
  private baseUrl = 'https://localhost:7106/';
  private token=localStorage.getItem("token");

  constructor(private http: HttpClient) {
   }

   obtenerColor(): Observable<any> {
    const url = `${this.baseUrl}api/Colors/GetAll`;
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    
    console.log('ESTE ES EL TOKEN', token)
    return this.http.get<any>(url, { headers });
  }

  guardarReceta(provedor: Product): Observable<any> {
    const url = `${this.baseUrl}api/Recipe/InsertRecipe`; // Ajusta la URL según la ruta de la https://accounts.google.com/b/0/AddMailServiceAPI para guardar provedors
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.post<Product>(url, provedor, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }

}
