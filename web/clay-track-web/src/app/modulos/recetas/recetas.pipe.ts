import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'rawMaterialName'
})
export class RawMaterialNamePipe implements PipeTransform {

  transform(id: number, rawMaterials: any[]): string {
    const matchingRawMaterial = rawMaterials.find(rawMaterial => rawMaterial.idCatRawMaterial === id);

    if (matchingRawMaterial) {
      return matchingRawMaterial.name;
    }

    return 'Unknown Raw Material';
  }

  transformEmpleado(id: number, employees: any[]): string {
    const matchingEmployee = employees.find(employee => employee.idCatEmployee === id);
  
    if (matchingEmployee) {
      return matchingEmployee.name; // Reemplaza "name" con la propiedad correcta que contiene el nombre del empleado en tu objeto
    }
  
    return 'Unknown Employee';
  }
  

}


@Pipe({
  name: 'nombreEmpleado'
})
export class EmpleadoNombre implements PipeTransform {

  transform(id: number, employees: any[]): string {
    const matchingEmployee = employees.find(employee => employee.idCatEmployee === id);
  
    if (matchingEmployee) {
      return matchingEmployee.name; // Reemplaza "name" con la propiedad correcta que contiene el nombre del empleado en tu objeto
    }
  
    return 'Unknown Employee';
  }
  

}
