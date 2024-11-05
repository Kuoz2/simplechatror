# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

# Array de nombres de tareas relacionadas con mecánica
task_names = [
  "Cambio de aceite",
  "Revisión de frenos",
  "Ajuste de suspensión",
  "Inspección del motor",
  "Cambio de neumáticos",
  "Alineación de ruedas",
  "Cambio de filtro de aire",
  "Revisión de luces",
  "Chequeo de batería",
  "Cambio de bujías",
  "Reemplazo de correa de distribución",
  "Inspección del sistema de escape",
  "Cambio de líquido de frenos",
  "Limpieza de inyectores",
  "Revisión de embrague",
  "Ajuste de transmisión",
  "Verificación de aire acondicionado",
  "Reemplazo de amortiguadores",
  "Mantenimiento del radiador",
  "Inspección de cables",
  "Revisión de sistema eléctrico",
  "Cambio de líquido de dirección",
  "Ajuste de freno de mano",
  "Cambio de pastillas de freno",
  "Revisión de sistema de refrigeración",
  "Reemplazo de mangueras",
  "Cambio de líquido anticongelante",
  "Ajuste de válvulas",
  "Revisión de sensores",
  "Chequeo de sistema de encendido",
  "Cambio de filtro de combustible",
  "Revisión de sistema hidráulico",
  "Inspección de diferencial",
  "Cambio de junta de culata",
  "Ajuste de tensores",
  "Mantenimiento de caja de cambios",
  "Chequeo de dirección asistida",
  "Limpieza de motor",
  "Cambio de aceite de caja",
  "Revisión de alternador",
  "Inspección de bomba de agua",
  "Reemplazo de retenes",
  "Ajuste de poleas",
  "Verificación de sistema de frenado ABS",
  "Revisión de nivel de líquidos",
  "Mantenimiento de suspensión",
  "Cambio de polea tensora",
  "Inspección de ejes",
  "Cambio de retén de cárter",
  "Limpieza de sistema de admisión",
  "Chequeo de turbo",
  "Ajuste de bomba de gasolina",
  "Revisión de caja de fusibles",
  "Reemplazo de inyectores",
  "Cambio de bobinas",
  "Inspección de válvula EGR",
  "Cambio de sensor de oxígeno",
  "Revisión de catalizador",
  "Ajuste de bujes",
  "Cambio de tapa de distribución",
  "Chequeo de carburador",
  "Cambio de empacaduras",
  "Inspección de sistema de escape",
  "Revisión de válvula PCV",
  "Reemplazo de bujes de suspensión",
  "Cambio de compresor de aire acondicionado",
  "Chequeo de termostato",
  "Revisión de balatas"
]

# Crear 100 registros de Room con datos de ejemplo
100.times do
  created_at = Faker::Date.backward(days: 30) # Fecha aleatoria dentro de los últimos 30 días
  Room.create(
    name: task_names.sample,                     # Selecciona un nombre de tarea aleatorio
    created_at: created_at,                       # Usa la fecha generada
    updated_at: created_at,                       # Igual a created_at
    estimated_end_time: created_at + 5.days,      # 5 días después de created_at
    completed: false                              # Establece completed en false
  )
end