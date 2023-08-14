import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';

export interface RawMaterial {
  idCatalog: number;
  quantity: number;
  price: number;
  fkCatRawMaterial: number;
}

export interface PurchaseData {
  idCatPurchase: number;
  total: number;
  fkCatSupplier: number;
  fkCatEmployee: number;
  rawMaterials: RawMaterial[];
}


@Injectable({
  providedIn: 'root'
})
export class CompraService {
  private baseUrl = 'https://localhost:7106/';
  private token=localStorage.getItem("token");

  constructor(private http: HttpClient) {
   }

   obtenerCompra(): Observable<any> {
    const url = `${this.baseUrl}api/Purchase/GetAll`;
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    
    console.log('ESTE ES EL TOKEN', token)
    return this.http.get<any>(url, { headers });
  }

  guardarCompra(compra: PurchaseData): Observable<any> {
    const url = `${this.baseUrl}api/Purchase/Add`; // Ajusta la URL según la ruta de la API para guardar compras
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.post<PurchaseData>(url, compra, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }

}
