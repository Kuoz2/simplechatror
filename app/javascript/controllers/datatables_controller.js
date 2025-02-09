import { Controller } from "@hotwired/stimulus"
import "datatables.net-dt";
// Connects to data-controller="datatables"
export default class extends Controller {
  connect() {
    if (!$.fn.DataTable.isDataTable(this.element)) {
        $(this.element).DataTable(
          {
            responsive:true,
            ajax:{
              url:"http://localhost:3000/reports/worker_efficiency",
              dataSrc:'data',
            },
            columns:[
              {
                data: function (row) {
                  return row["user.email"]; // Usando función para acceder a la propiedad
                },
                title: 'Email del Usuario'
              },
              {data:"completed_tasks", title:"Tareas Completadas"},
              {data:"average_completion_time", title: 'Tiempo Promedio de Compleción'},
              {data:"on_time_percentage", title:"% Cumplimento Tiempo"},
              {data:"late_task_count", title:"Tareas retrasadas"},
              {data:"late_task_percentage", title:"% de Tareas Retrasada"}
            ],
            dom:'Blfrtip',
            buttons: [
              'copy', 'csv', 'excel', 'pdf', 'print'
            ] 
          }); 
        }
  }
}
