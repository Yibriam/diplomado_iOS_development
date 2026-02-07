# Ejercicio

## Información General

Este ejercicio está dividido en dos partes:
- **Parte 1**: Mejoras al proyecto Pokedex existente
- **Parte 2**: Crear una nueva aplicación desde cero

---

# Parte 1: Mejoras al Pokedex

En esta parte trabajarás con el proyecto de Pokedex que hemos desarrollado en clase. Deberás implementar las siguientes mejoras:

---

## 1.1 Barra de Búsqueda Programática (20 puntos)

### Objetivo
Agregar una barra de búsqueda (`UISearchController`) a la lista de Pokémon que permita filtrar por nombre.

### Requisitos
- [ ] La barra de búsqueda debe ser creada **programáticamente** 
- [ ] Debe integrarse con el `UINavigationController`
- [ ] El filtrado debe realizarse en el `PokemonListViewModel`
- [ ] La búsqueda debe ser **case-insensitive** (no distinguir mayúsculas de minúsculas). Debes poder buscar mediante nombre del pokemon y su número
- [ ] La tabla debe actualizarse en tiempo real mientras el usuario escribe
- [ ] Cuando se borre el texto de búsqueda, debe mostrarse la lista completa

---

## 1.2 Propiedades Anidadas: Debilidades y Evoluciones (25 puntos)

### Objetivo
Actualizar el modelo de datos y la vista de detalle para mostrar las debilidades y evoluciones de cada Pokémon.

### Requisitos
- [ ] Actualizar `Pokemon.swift` para decodificar las propiedades `weaknesses`, `next_evolution` y `prev_evolution`
- [ ] Crear una estructura `Evolution` con propiedades `name` y `num`
- [ ] Mostrar las **debilidades** en el `PokemonDetailViewController`
- [ ] Mostrar las **evoluciones anteriores** si existen
- [ ] Mostrar las **evoluciones siguientes** si existen
- [ ] El diseño debe ser claro y legible

---

## 1.3 Navegación a Detalle de Evolución (15 puntos)

### Objetivo
Permitir que el usuario pueda tocar una evolución y navegar al detalle de ese Pokémon.

### Requisitos
- [ ] Las evoluciones deben ser **tappable** 
- [ ] Al tocar una evolución, debe abrirse el `PokemonDetailViewController` con la información del Pokémon seleccionado
- [ ] La navegación debe funcionar tanto para evoluciones anteriores como siguientes
- [ ] Si el Pokémon de la evolución no se encuentra en la lista, mostrar un alert indicándolo

---

## 1.4 Botón de Cerrar en el Modal del Mapa (5 puntos)

### Objetivo
Agregar un botón para cerrar fácilmente el modal que muestra la ubicación del Pokémon.

### Requisitos
- [ ] Agregar un botón de cerrar (X) en la esquina superior derecha del `PokemonLocationViewController`
- [ ] El botón debe ser creado **programáticamente**
- [ ] Al tocarlo, debe cerrar el modal (`dismiss`)
- [ ] El botón debe ser claramente visible sobre el mapa

---

## 1.5 Alerta de Permisos de Ubicación (15 puntos)

### Objetivo
Mostrar una alerta cuando el usuario no haya otorgado permisos de ubicación.

### Requisitos
- [ ] Detectar cuando el permiso de ubicación es denegado o restringido
- [ ] Mostrar un `UIAlertController` explicando que se necesitan permisos
- [ ] El mensaje debe ser claro y amigable
- [ ] Incluir un botón "OK" que cierre el modal del mapa

### Pistas
- Revisa el método `locationManagerDidChangeAuthorization(_:)` del `CLLocationManagerDelegate`
- Revisa los estados de `CLAuthorizationStatus`: `.denied`, `.restricted`

---

## 1.6 ViewModel para PokemonLocationViewController (20 puntos)

### Objetivo
Crear un ViewModel para separar la lógica de negocio de la vista en `PokemonLocationViewController`.

### Requisitos
- [ ] Crear un nuevo archivo `PokemonLocationViewModel.swift`
- [ ] El ViewModel debe manejar:
  - La información del Pokémon (nombre, ubicación)
  - La imagen del Pokémon
  - El `CLLocationManager` y su configuración
  - El estado de autorización de ubicación
- [ ] Crear un **protocolo/delegate** para comunicar cambios al ViewController
- [ ] El ViewController **NO** debe tener ninguna lógica del `CLLocationManager`
- [ ] El ViewController solo debe:
  - Configurar la UI
  - Responder a las notificaciones del ViewModel
  - Actualizar el mapa cuando el ViewModel lo indique

---

# Parte 2: App "Don Bigotes" 🐱

En esta parte crearás una aplicación nueva. La app mostrará información de una cadena ficticia de tiendas para mascotas llamada "Don Bigotes".

---

## Descripción General

La aplicación tendrá **3 pantallas**:

1. **Pantalla de Inicio**: Información de la cadena y botón para ver sucursales
2. **Lista de Sucursales**: TableView con todas las sucursales
3. **Detalle de Sucursal**: Información completa con mapa integrado

---

## 2.1 Configuración Inicial (5 puntos)

### Requisitos
- [ ] Crear un nuevo proyecto en Xcode llamado "DonBigotes"
- [ ] Configurar el proyecto para usar **UIKit programático**
- [ ] Configurar el `SceneDelegate` para iniciar la app programáticamente
- [ ] Agregar el archivo `don_bigotes.json` al proyecto
- [ ] Agregar el permiso de ubicación en `Info.plist`

---

## 2.2 Modelos de Datos (15 puntos)

### Requisitos
- [ ] Crear los modelos necesarios para decodificar el JSON
- [ ] Todos los modelos deben conformar `Codable`
- [ ] Manejar correctamente los días que están cerrados

---

## 2.3 Pantalla de Inicio (20 puntos)

### Requisitos
- [ ] Crear `HomeViewController` programáticamente
- [ ] Crear `HomeViewModel` para manejar los datos
- [ ] Mostrar:
  - Logo de la tienda (imagen desde URL o placeholder)
  - Nombre de la cadena (fuente grande)
  - Slogan
  - Descripción (en un scroll view si es necesario)
  - Botón "Ver Sucursales"
- [ ] El botón debe navegar a la lista de sucursales


## 2.4 Lista de Sucursales (20 puntos)

### Requisitos
- [ ] Crear `BranchListTableViewController`
- [ ] Crear `BranchListViewModel`
- [ ] Cada celda debe mostrar:
  - Nombre de la sucursal
  - Dirección
- [ ] Al seleccionar una celda, navegar al detalle de la sucursal
- [ ] La navegación debe ser con **push** (dentro de un `UINavigationController`)

---

## 2.5 Detalle de Sucursal con Mapa (40 puntos)

### Requisitos
- [ ] Crear `BranchDetailViewController` programáticamente
- [ ] Crear `BranchDetailViewModel`
- [ ] La pantalla debe mostrar **en la misma vista**:
  - Nombre de la sucursal
  - Dirección completa
  - Teléfono
  - Horarios de atención (Lunes-Viernes, Sábado, Domingo)
  - Si un día está cerrado, mostrar "Cerrado"
  - Lista de servicios disponibles
  - **Mapa con la ubicación de la sucursal**
- [ ] El mapa debe:
  - Mostrar un **pin** en la ubicación de la sucursal
  - Tener un **zoom apropiado** para ver claramente la ubicación
  - **NO** necesita mostrar la ubicación del usuario
- [ ] El diseño debe usar `UIScrollView` para permitir scroll si el contenido es largo
- [ ] El mapa debe tener un tamaño fijo (ej: 300 pts de alto)

---

## Estructura Sugerida del Proyecto

```
DonBigotes/
├── AppDelegate.swift
├── SceneDelegate.swift
├── Models/
│   ├── Store.swift
│   ├── Branch.swift
│   └── OpeningHours.swift
├── Home/
│   ├── HomeViewController.swift
│   └── HomeViewModel.swift
├── BranchList/
│   ├── BranchListViewController.swift
│   └── BranchListViewModel.swift
├── BranchDetail/
│   ├── BranchDetailViewController.swift
│   └── BranchDetailViewModel.swift
├── Resources/
│   └── don_bigotes.json
└── Info.plist
```

---

## Puntos Extra (Opcionales)

- **+10 puntos**: Agregar una barra de búsqueda en la lista de sucursales
- **+5 puntos**: Implementar Dark Mode correctamente
- **-10 puntos**: Uso de `print` statements 


**¡Buena suerte! 🍀**
