import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
export interface RawMaterial {
  idCatRawMaterial: number;
  name: string;
  quantityWarehouse: number;
  quantityPackage: number;
  status: boolean;
  creationDate: string;
  updateDate: string;
  fkCatUnitMeasure: number;
  unitMeasure: {
    idCatUnitMeasure: number;
    description: string;
    status: boolean;
    creationDate: string;
    updateDate: string;
  };
}
@Injectable({
  providedIn: 'root'
})
export class MateriaPrimaService {
  private baseUrl = 'https://localhost:7106/';
  private token=localStorage.getItem("token");

  constructor(private http: HttpClient) {
   }

   obtenerMateriaP(): Observable<any> {
    const url = `${this.baseUrl}api/RawMaterial/GetAll`;
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    
    console.log('ESTE ES EL TOKEN', token)
    return this.http.get<any>(url, { headers });
  }

  guardarMatreriaP(materiaP: RawMaterial): Observable<any> {
    const url = `${this.baseUrl}api/RawMaterial`; // Ajusta la URL según la ruta de la https://accounts.google.com/b/0/AddMailServiceAPI para guardar materiaPs
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.post<RawMaterial>(url, materiaP, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }

  obtenerMateriaPPorId(id:string):Observable<RawMaterial>{
    const url = `${this.baseUrl}api/RawMaterial/GetOne${id}`; // Ajusta la URL según la ruta de la API para guardar provedors
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.get<RawMaterial>(url, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }

  actualizarMateriaP(materiaP: RawMaterial,id:number): Observable<any> {
    const url = `${this.baseUrl}api/RawMaterial/${id}`; // Ajusta la URL según la ruta de la API para guardar materiaPs
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.put<RawMaterial>(url, materiaP, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }

  eliminarMateriaPrima(id:string): Observable<any> {
    const url = `${this.baseUrl}api/RawMaterial/Delete${id}`; // Ajusta la URL según la ruta de la API para guardar provedors
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.put<RawMaterial>(url, null, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }
}
