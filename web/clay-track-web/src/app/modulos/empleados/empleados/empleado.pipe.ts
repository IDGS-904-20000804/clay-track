import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'nombreEmpleado'
})
export class EmpleadoNombre implements PipeTransform {

  transform(id: number, employees: any[]): string {
    const matchingEmployee = employees.find(employee => employee.idCatEmployee === id);

    if (matchingEmployee && matchingEmployee.fkCatPerson) {
      const employeeName = matchingEmployee.fkCatPerson.name; // Ajusta la propiedad según corresponda
      return employeeName || 'Unknown Employee';
    }

    return 'Unknown Employee';
  }
}
