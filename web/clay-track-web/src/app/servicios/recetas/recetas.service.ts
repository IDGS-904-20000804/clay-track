import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';

export interface Receta {
  idCatRecipe?: number; // Agregado si es necesario
  name: string;
  price: number;
  quantityStock?: number; // Agregado si es necesario
  status?: boolean; // Agregado si es necesario
  creationDate?: string; // Agregado si es necesario
  updateDate?: string; // Agregado si es necesario
  fkCatSize: number;
  fkCatImage: number;
  size?: CatSize; // Agregado si es necesario
  image?: CatImage; // Agregado si es necesario
  colorIds: number[];
  rawMaterials: RawMaterial[];
}

export interface CatSize {
  idCatSize: number;
  description: string;
  abbreviation: string;
  status?: boolean; // Agregado si es necesario
  creationDate?: string; // Agregado si es necesario
  updateDate?: string; // Agregado si es necesario
}

export interface CatImage {
  idCatImage: number;
  file: any; // Cambia "any" por el tipo de dato correcto para representar la imagen
  fileName: string;
  fileExtension: string;
  fileSizeInBytes: number;
  filePath: string;
}

export interface RawMaterial {
  idCatalog: number;
  quantity: number;
  fkCatRawMaterial: number;
}


@Injectable({
  providedIn: 'root'
})
export class RecetasService {
  private baseUrl = 'https://localhost:7106/';
  private token = localStorage.getItem("token");

  constructor(private http: HttpClient) {
  }

  obtenerReceta(): Observable<any> {
    const url = `${this.baseUrl}api/Recipe/GetAll`;
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    
    console.log('ESTE ES EL TOKEN', token)
    return this.http.get<any>(url, { headers });
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

  guardarReceta(receta:Receta): Observable<any> {
    const url = `${this.baseUrl}api/Recipe/InsertRecipe`; // Ajusta la URL según la ruta de la https://accounts.google.com/b/0/AddMailServiceAPI para guardar provedors
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json',
    });
    // const provedor = {
    //   "name": "Nestor",
    //   "price": 0,
    //   "fkCatSize": 1,
    //   "fkCatImage": 1,
    //   "colorIds": [
    //     3, 4, 5
    //   ],
    //   "rawMaterials": [
    //     {
    //       "idCatalog": 0,
    //       "quantity": 3,
    //       "fkCatRawMaterial": 3
    //     }
    //   ]
    // }
    return this.http.post<Receta>(url, receta, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }

  guardarRecetaFoto(file: File): Observable<any> {
    const url = `${this.baseUrl}api/Recipe/Upload`;
    const token = this.token;
    const boundary = '--------------------------' + new Date().getTime(); // Genera el límite único
  
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`,
      'Content-Type': `multipart/form-data; boundary=${boundary}`,
      'Accept': '*/*'
        });
  
    let formData = new FormData();
    formData.append('File', file);
    formData.append('FileName', 'FotoLuisA');
  
    return this.http.post<any>(url, formData, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error);
        return throwError(error);
      })
    );
  }


  uploadRecipeFile(file: File): any {
    const token = this.token;
    const url = `${this.baseUrl}api/Image/Upload`;
    const formData = new FormData();
    formData.append('File', file, file.name);
    formData.append('FileName', file.name);

    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`,
    });

    return this.http.post(url, formData, { headers });
  }
  

  obtenerFotos(): Observable<any> {
    const url = `${this.baseUrl}api/Image/GetAll`;
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });

    console.log('ESTE ES EL TOKEN', token)
    return this.http.get<any>(url, { headers });
  }

  actualizarReceta(receta: Receta,id:number): Observable<any> {
    const url = `${this.baseUrl}api/Recipe/Update/${id}`; // Ajusta la URL según la ruta de la API para guardar recetas
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.post<Receta>(url, receta, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }

  obtenerRecetaPorId(id:string):Observable<Receta>{
    const url = `${this.baseUrl}api/Recipe/GetOne${id}`; // Ajusta la URL según la ruta de la API para guardar provedors
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.get<Receta>(url, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }

  eliminarReceta(id:string): Observable<any> {
    const url = `${this.baseUrl}api/Recipe/Delete${id}`; // Ajusta la URL según la ruta de la API para guardar provedors
    const token = this.token;
    const headers = new HttpHeaders({
      'Authorization': `Bearer ${token}`
    });
    return this.http.put<any>(url,null, { headers }).pipe(
      catchError((error) => {
        console.error('Error:', error); // Registra el error en la consola.
        return throwError(error); // Re-lanza el error para que sea capturado por el componente que lo llame.
      })
    );
  }




  // importar(file:File){
  //   const headers = new HttpHeaders().set('content-type', 'application/json');
  //   headers.append('Content-Type', 'multipart/form-data');
  //   let formData = new FormData(); 
  //   formData.append('file', file);
  //   const url=`${baseUrl}/importar`;
  //   return this.http.post(url,formData)
  // }

}
